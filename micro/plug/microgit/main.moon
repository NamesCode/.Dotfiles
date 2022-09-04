export VERSION = "1.0.0"
export DESC    = 'Git for Micro'

NAME = _M._NAME

local git

-- Workaround for import being a keyword in Moonscript
go = assert loadstring([[
  -- script: lua
  return ({
    import = function (pkg)
      return import(pkg)
    end
  })
  -- script: end
]])!

os  = go.import"os"
app = go.import"micro"
buf = go.import"micro/buffer"
cfg = go.import"micro/config"
shl = go.import"micro/shell"
str = go.import"strings"
util = go.import"micro/util"
path = go.import"path"
fpath = go.import"path/file"
ioutil = go.import"ioutil"
regexp = go.import"regexp"
runtime = go.import"runtime"

GITLINE_ACTIVE = false
ACTIVE_UPDATES = {}
ACTIVE_COMMITS = {}
CALLBACKS_SET = {}
BUFFER_REPO = {}
REPO_STATUS = {}

LOADED_COMMANDS = { __order: {} } unless LOADED_COMMANDS
LOADED_OPTIONS = { __order: {} } unless LOADED_OPTIONS
LOADED_LINEFNS = { __order: {} } unless LOADED_LINEFNS
PATHSEP = string.char os.PathSeparator

bound  = (n, min, max) -> n > max and max or (n < min and min or n)
debug  = (m) -> app.Log "#{NAME}: #{m}"
truthy = (v) -> if v then return true else false
errors = {
  is_a_repo: "the current file is already in a repository"
  not_a_repo: "the current file is not in a repository"
  invalid_arg: "invalid_argument provided"
  bad_label_arg: "invalid argument, please provide a valid rev label"
  not_enough_args: "not enough arguments"
  unknown_label: "given label is not known to this repo"
  command_not_found: "invalid command provided (not a command)"
  no_help: "FIXME: no help for command git."
  no_scratch: "this cannot be run out of a temporary pane"
  need_file: "this can only be run in a file pane"
}


--- Add a function to the list of callbacks for the given callback string
-- @tparam string callback name
-- @tparam function function to run during the given callback run
add_callback = (callback, fn) ->
  unless CALLBACKS_SET[callback]
    CALLBACKS_SET[callback] = {}
  table.insert CALLBACKS_SET[callback], fn


--- Run all callbacks for the given callback against the arguments provided
-- 
-- When a calback is run, if it returns a truthy value, it is removed from the 
-- list. Otherwise, it is retained for further runs.
--
-- @tparam name callback name to run
-- @tparam ...any arguments that will be passed to each callback
run_callbacks = (callback, ...) ->
  active = {}
  for i, fn in ipairs (CALLBACKS_SET[callback] or {})
    unless fn ...
      table.insert active, fn
  CALLBACKS_SET[callback] = active
      

--- Delete leading and trailing spaces, and the final newline
-- @tparam string string to process
chomp = (s) ->
  s = s\gsub("^%s*", "")\gsub("%s*$", "")\gsub("[\n\r]*$", "")
  return s


--- Reimplementation of util.ReplaceHome, as it's not exposed to lua
-- @tparam string filepath string
-- @return string|nil processed filepath, nil on error
-- @return error
replace_home = (_path) ->
  switch true
    when truthy str.HasPrefix(_path, "~")
      home, err = os.UserHomeDir!
      return nil, err if err
      return str.Replace _path, "~", (home .. PATHSEP), 1
    when truthy str.HasPrefix(_path, "%USERPROFILE%")
      home, err = os.UserHomeDir!
      return nil, err if err
      return str.Replace _path, "%USERPROFILE%", (home .. PATHSEP), 1
  return _path


--- Run a given function for each line in a string
-- 
-- The function signature should be (string, number, number, function). In order,
-- those represent the line being processed, the current line number, the total
-- line count, and a function that ends the loop before the following line.
--
-- @tparam string input string to process line by line
-- @tparam function function to run for each line
--
-- @example 
--    each_line (line, i, total, final) ->
--      return final!
each_line = (input, fn) ->
  input = str.Replace input, "\r\n", "\n", -1
  input = str.Replace input, "\n\r", "\n", -1
  lines = str.Split(input, "\n")
  l_count = #lines

  local finish_ret, finish_err
  stop = false
  finish = (v, err) ->
    stop = true
    finish_ret = v
    finish_err = err if err

  for i = 1, l_count
    break if stop
    fn lines[i], i, l_count, finish

  return finish_ret, finish_err


--- Iterate over a golang array
--
-- @tparam userdata golang array
-- @return function iterator function
iter_goarray = (object) ->
  len = #object
  i = 0
  return ->
    i += 1
    return if i > len
    return i, object[i], len


--- Iterate over a golang array
--
-- @tparam userdata golang array
-- @return function iterator function
reverse_goarray = (object) ->
  len = #object
  i = len + 1
  return ->
    i -= 1
    return if i < 1
    return i, object[i], len
    

--- Process a filepath and return information regarding it
--
-- @tparam string filepath to process 
-- @return string the absolute version of the filepath given
-- @return string the parent directory of the filepath given
-- @return string the basename of the filepath given
-- @return string the current working directory
--
-- NOTE: filepath.Abs and filepath.IsAbs both exist, however, their use in Lua
--       code here currently panics the application. Until then, we'll just have
--       to rely on something hacky in the meantime. This is pretty gross, but
--       it works.
get_path_info = (->
  s = string.char os.PathSeparator
  insert = table.insert
  windows = (runtime.GOOS == "windows" and true or false)

  re_part = regexp.MustCompile "[^#{s}]+"
  re_root = regexp.MustCompile "^#{windows and '[a-zA-Z]:' or ''}#{s}#{s}?"
  
  --- Convert a goarray to a table using a numerical for loop
  -- @tparam array Array to convert
  -- @local
  convert = (goarray) ->
    tbl, len = {}, #goarray
    for i = 1, len
      insert tbl, goarray[i]
    return tbl

  --- Check whether or not a filepath is has the root (/) or windows drive (C://)
  -- @tparam string filepath to check
  -- @local
  has_root = (s) ->
    re_root\Match s

  return (filepath="") ->
    return nil unless filepath != "" and type(filepath) == "string"
  
    pwd, err = os.Getwd!
    assert not err, "failed to get current working directory"

    work_string = filepath
    unless has_root filepath  
      work_string = pwd .. s .. work_string

    skip = 0
    canon_split = {}
    for i, ent, len in reverse_goarray re_part\FindAllString work_string, -1
      switch true
        when ent == "."
          continue
        when ent == ".."
          skip += 1
          continue
        when skip > 0
          skip -= 1
          continue
        when skip > len - i
          return nil, "get_path_info: #{work_string} invalid path, too many parent traversals"

      insert canon_split, 1, ent

    absolute = str.Join canon_split, s
    unless windows and (absolute\sub 1, 1) == s
      absolute = s .. absolute
  
    canon_split = re_part\FindAllString absolute, -1
    name = canon_split[#canon_split]
    parent = (str.TrimSuffix absolute, name) or ""
    parent = (str.TrimSuffix parent, s) or ""

    return absolute, parent, name, pwd
)!


--- Register a provided function+callback as a command
--
-- Wraps the given function to account for Micros handling of arguments placing
-- additional arguments of len size > 1 in a Go array.
--
-- Command functions need to take a window object (pane, split, etc) as the
-- first argument, a fileinfo table as the second argument (see get_path_info).
-- Every argument following this is what is provided on the Micro command line.
--
-- TODO: For now, commands get their infomation from the git local table, using
--       git[${commandname}_help] to determine whether or not commands have a
--       proper help section. This should be changed to use the config table.
--
-- @tparam string private name of the command to register
-- @tparam function function to use as the command function
-- @tparam table additional configuration
-- @return none
add_command = (name, fn, config={}) ->
  return if LOADED_COMMANDS[name]

  external_name = "git.#{name}"
  callbacks = config.callbacks or {}
  completer = config.completer or cfg.NoComplete

  add_callback external_name, (...) ->
    for cb in *callbacks
      cb ...
    return false
  
  cmd = (any, extra) ->
    local _finfo

    debug "command[#{external_name}] started"
    _buf = any.Buf or any
    abs, dir, name, pwd = get_path_info _buf.Path
    _finfo = { :dir, :abs, :name, :pwd } if pwd
    
    fn any, _finfo, unpack([a for a in *(extra or {})])
    run_callbacks external_name, _buf, _finfo
    debug "command[#{external_name}] completed"
    
    return

  cfg.MakeCommand external_name, cmd, completer
  LOADED_COMMANDS[name] = { :cmd, help: git[name .. "_help"] }
  table.insert LOADED_COMMANDS.__order, name


--- Register a configuration option
--
-- Canonicalizes the option name, and places the provided information into
-- the LOADED_OPTIONS table for later usage. The description provided will
-- be loaded into the help page for the option
--
-- @tparam string configuration name
-- @tparam any default value for the configuration
-- @tparam string description to be loaded into help
-- @return none
add_config = (name, default, description) ->
  return if LOADED_OPTIONS[name]
  
  cfg.RegisterCommonOption NAME, name, default
  LOADED_OPTIONS[name] = description
  table.insert LOADED_OPTIONS.__order, name


--- Register a provided statusline parameter function
--
-- Canonicalizes the option name, and places the provided information into
-- the LOADED_PARAMS table for later usage. The description provided will
-- be loaded into the help page for the option
--
-- @tparam string configuration name
-- @tparam any default value for the configuration
-- @tparam string description to be loaded into help
-- @return none
add_statusinfo = (name, fn, description) ->
  return if LOADED_LINEFNS[name]

  app.SetStatusInfoFn "#{NAME}.#{name}"
  LOADED_LINEFNS[name] = description
  table.insert LOADED_LINEFNS.__order, name

--- Generates our help pages for the various registered components and loads
-- them into the following pages: ${plugin}.command, ${plugin}.options, and
-- ${plugin}.statusline
generate_help = (-> 
  get_parser = ->
    on_line, margin, parsed = 1, '', ''
    _get_result = -> parsed
    _parse_line = (line, _, total) ->
      return if on_line == 1 and line\match"^%s*$"
      margin = line\match"^(%s*).+$" if on_line == 1
      line = line\gsub(margin, "", 1)
      return if (on_line >= total and line\match"^%s*$")
      parsed ..= "\n>  #{line}"
      on_line += 1
    return _parse_line, _get_result

  return ->
    commands_help = "# Microgit\n#{DESC}\n\n## Commands"
    for name in *LOADED_COMMANDS.__order
      debug "Adding #{name} to help"
      commands_help ..= "\n* %pub%.#{name}"
      continue if not LOADED_COMMANDS[name].help
      parser, parser_result = get_parser!
      each_line LOADED_COMMANDS[name].help, parser
      commands_help ..= "#{parser_result!}\n"

    options_help = "# Microgit\n#{DESC}\n\n## Options"
    for name in *LOADED_OPTIONS.__order
      debug "Adding #{name} to help"
      options_help ..= "\n* %NAME%.#{name}"
      continue if not LOADED_OPTIONS[name]
      parser, parser_result = get_parser!
      each_line LOADED_OPTIONS[name], parser
      options_help ..= "#{parser_result!}\n"

    statusline_help = "# Microgit\n#{DESC}\n\n## Statusline Help"
    for name in *LOADED_LINEFNS.__order
      debug "Adding #{name} to help"
      statusline_help ..= "\n* %NAME%.#{name}"
      continue if not LOADED_LINEFNS[name]
      parser, parser_result = get_parser!
      each_line LOADED_LINEFNS[name], parser
      statusline_help ..= "#{parser_result!}\n"

    options_help = str.Replace options_help, '%pub%', 'git', -1
    options_help = str.Replace options_help, '%NAME%', NAME, -1
    commands_help = str.Replace commands_help, '%pub%', 'git', -1
    commands_help = str.Replace commands_help, '%NAME%', NAME, -1
    statusline_help = str.Replace statusline_help, '%pub%', 'git', -1
    statusline_help = str.Replace statusline_help, '%NAME%', NAME, -1
    
    cfg.AddRuntimeFileFromMemory cfg.RTHelp, "#{NAME}.commands", commands_help
    cfg.AddRuntimeFileFromMemory cfg.RTHelp, "#{NAME}.options", options_help
    cfg.AddRuntimeFileFromMemory cfg.RTHelp, "#{NAME}.statusline", statusline_help
)!


--- Generate a function that takes a number, and returns the correct plurality of a word
wordify = (word, singular, plural) ->
  singular = word .. singular
  plural   = word .. plural
  (number) ->
    number != 1 and plural or singular


--- If a path is accessible, return true. Otherwise, false
path_exists = (filepath) ->
  finfo, _ = os.Stat filepath
  return finfo != nil


--- Create a temporary file and return the filepath.
--
-- Files created using this function will be created within a tmp
-- directory within the Micro main directory with the format:
--
--   $plugin.$header.XXXXXXXXXXXX
--
-- X characters will be replaced with a random capital letter, x lowercase.
--
-- @return string
make_temp = (->
  rand = go.import "math/rand"
  chars = 'qwertyuioasdfghjklzxcvbnm'
  return (header='XXX') ->
    dir = path.Join "#{cfg.ConfigDir}", "tmp"
    err = os.MkdirAll(dir, 0x1F8) -- 770, to account for octal
    assert not err, err
    
    file = ("#{NAME}.#{header}.") .. ("XXXXXXXXXXXX")\gsub '[xX]', =>
      i = rand.Intn(25) + 1
      c = chars\sub i, i
      switch @
        when 'x'
          return c
        when 'X'
          return string.upper c

    debug "Generated new tempfile: #{dir}/#{file}"
    return tostring path.Join dir, file
)!


--- Create a new readonly scratch hsplit pane and return it
--
-- Initially inspired by filemanager
-- https://github.com/micro-editor/updated-plugins/blob/master/filemanager-plugin/filemanager.lua
make_empty_hsplit = (root, rszfn, header, output, filepath) ->
  if not output and not filepath
    output = ""

  local pane
  old_view = root\GetView!
  h = old_view.Height
  if filepath
    pane = root\HSplitIndex(buf.NewBufferFromFile(filepath), true)
  else
    pane = root\HSplitIndex(buf.NewBuffer(output, ""), true)
    
  pane\ResizePane rszfn h
  pane.Buf.Type.Scratch = true
  pane.Buf.Type.Readonly = true
  pane.Buf.Type.Syntax = false
  pane.Buf\SetOptionNative "softwrap", true
  pane.Buf\SetOptionNative "ruler", false
  pane.Buf\SetOptionNative "autosave", false
  pane.Buf\SetOptionNative "statusformatr", ""
  pane.Buf\SetOptionNative "statusformatl", header
  pane.Buf\SetOptionNative "scrollbar", false
  pane.Buf\SetOptionNative "diffgutter", false
  pane.Cursor.Loc.Y = 0
  pane.Cursor.Loc.X = 0
  pane.Cursor\Relocate!
  return pane

--- Create a new readonly scratch vsplit pane and return it
make_empty_vsplit = (root, rszfn, header, output, filepath) ->
  local pane
  old_view = root\GetView!
  w = old_view.Width
  if filepath
    pane = root\VSplitIndex(buf.NewBufferFromFile(filepath, true), true)
  else
    pane = root\VSplitIndex(buf.NewBuffer(output, ""), true)
  pane\ResizePane rszfn w
  pane.Buf.Type.Scratch = true
  pane.Buf.Type.Readonly = true
  pane.Buf.Type.Syntax = false
  pane.Buf\SetOptionNative "softwrap", true
  pane.Buf\SetOptionNative "ruler", false
  pane.Buf\SetOptionNative "autosave", false
  pane.Buf\SetOptionNative "statusformatr", ""
  pane.Buf\SetOptionNative "statusformatl", header
  pane.Buf\SetOptionNative "scrollbar", false
  pane.Buf\SetOptionNative "diffgutter", false
  pane.Cursor.Loc.Y = 0
  pane.Cursor.Loc.X = 0
  pane.Cursor\Relocate!
  return pane

  
--- Create a new readonly scratch pane with the contents of output
send_block = (header, output, syntax=false) ->
  pane = make_empty_hsplit app.CurPane!, ((h) -> h - (h / 5)), header, output
  pane.Buf.Type.Syntax = truthy syntax

--- Get the current argument
--
-- NOTE: This is an inefficient recreation of the GetArg function, as it is not
-- exported to lua: https://github.com/zyedidia/micro/internal/buffer/autocomplete.go
-- 
-- @tparam userdata buffer object
-- @return string
-- @return number
get_arg = =>
  c = @GetActiveCursor!
  args = str.Split util.String(@LineBytes c.Y), ' '
  count = #args
  current = args[count]
  argstart = 0
  
  for i, a in iter_goarray args
    break if i == count
    argstart += util.CharacterCountInString(a) + 1

  return args, current, argstart - 1
  

git = (->
  w_commit  = wordify 'commit', '', 's'
  w_line    = wordify 'line', '', 's'
  re_commit = regexp.MustCompile"^commit[\\s]+([^\\s]+).*$"
  is_scratch = => @Type.Scratch

  --- Issue a message to the buffer with a neat syntax.
  -- If a string has more than one line, use a pane. Otherwise, issue a message
  -- via the infobar
  send = setmetatable {}, __index: (_, cmd) ->
    (msg, config) ->
      debug "git-#{cmd}: Issuing message - #{msg}"
      line_count = select(2, string.gsub(tostring(msg), "[\r\n]", ""))

      debug "LineCount: #{line_count}"
      if line_count > 1
        header = "git.#{cmd}"
        if type(config) == "table"
          if config.header != nil
            header = "#{header}: #{config.header}"
        send_block header, msg
        return

      (app.InfoBar!)\Message "git.#{cmd}: #{msg}"
      return

  --- Generate a new git command context for the directory. All git commands
  -- run through this context will run with -C "directory"
  new_command = (directory) ->
    if type(directory) != 'string' or directory == ''
      debug "filepath '#{filepath}' is not a valid editor path (need non-empty string): (got: #{type filepath})"
      return nil, "Please run this in a file pane"

    --- Execute a git command with arguments and return the output
    exec = (command, ...) ->
      unless path_exists directory
        return nil, "directory #{directory} does not exist"

      debug "Parent directory #{directory} exists, continuing ..."
      base = cfg.GetGlobalOption "#{NAME}.command"
      if base == ""
        base, _ = shl.ExecCommand "command", "-v", "git"
        base = chomp base
        if base == '' or not base
          return nil, "no git configured"

      debug "Found valid git path: #{base}"
      unless path_exists base
        return nil, err.Error!

      out = shl.ExecCommand base, "-P", "-C", directory, command, ...
      return out


    --- Execute the git command with arguments in the background, and fill a new
    -- pane with the contents of it's stdout.
    exec_async = (cmd, ...) =>
      unless path_exists directory
        return nil, "directory #{directory} does not exist"

      debug "Parent directory #{directory} exists, continuing ..."
      base = cfg.GetGlobalOption "#{NAME}.command"
      if base == ""
        base, _ = shl.ExecCommand "command", "-v", "git"
        base = chomp base
        if base == '' or not base
          return nil, "no git configured"

      debug "Found valid git path: #{base}"
      unless path_exists base
        return nil, err.Error!

      resize_fn = (h) -> h - ( h / 3 )
      pane = make_empty_hsplit self, resize_fn, "git-#{cmd}"

      on_emit = (_str, _) ->
        pane.Buf\Write _str
        return

      on_exit = (_, _) ->
        pane.Buf\Write "\n[command has completed, ctrl-q to exit]\n"
        return

      args = {...}
      table.insert args, 1, cmd
      table.insert args, 1, directory
      table.insert args, 1, "-C"
      table.insert args, 1, "-P"
      shl.JobSpawn base, args, on_emit, on_emit, on_exit
      return "", nil

    exec_async_cb = (cmd, cb_args={}, on_stdout, on_stderr, on_exit, ...) ->
      unless path_exists directory
        return nil, "directory #{directory} does not exist"

      debug "Parent directory #{directory} exists, continuing ..."
      base = cfg.GetGlobalOption "#{NAME}.command"
      if base == ""
        base, _ = shl.ExecCommand "command", "-v", "git"
        base = chomp base
        if base == '' or not base
          return nil, "no git configured"

      debug "Found valid git path: #{base}"
      unless path_exists base
        return nil, err.Error!

      on_stdout = assert on_stdout, "#{cmd}: exec_async_cb requires an on_stdout callback"
      on_stderr = assert on_stderr, "#{cmd}: exec_async_cb requires an on_stderr callback"
      on_exit = assert on_exit, "#{cmd}: exec_async_cb requires an on_exit callback"

      args = {...}
      table.insert args, 1, cmd
      table.insert args, 1, directory
      table.insert args, 1, "-C"
      table.insert args, 1, "-P"
      debug "Launching: #{base} #{str.Join args, " "}"
      shl.JobSpawn base, args, on_stdout, on_stderr, on_exit, unpack(cb_args)
      return

    --- Return true or false dependent on whether or not the context is a repo
    in_repo = ->
      out, err = exec "rev-parse", "--is-inside-work-tree"
      return send.in_repo err if err
      return chomp(out) == 'true'


    top_level = ->
      out, err = exec "rev-parse", "--show-toplevel"
      return nil unless out
      return chomp out

    --- Parse all of the known branches and return both those branches, and the 
    -- name of the current branch
    get_branches = ->
      out, err = exec "branch", "-al"
      if err
        send.get_branches "failed to get branches: #{err}"
        return nil, nil
      
      branches = {}
      current = ''

      each_line chomp(out), (line) ->
        debug "Attempting to match: #{line}"
        cur, name = line\match "^%s*(%*?)%s*([^%s]+)"
        if name
          if cur == '*'
            current = name
        else
          name = cur
        return unless name

        debug "Found branch: #{name}"
        revision, err = exec "rev-parse", name
        if err and err != ""
          debug "Failed to rev-parse #{name}: #{err}"
          return

        table.insert branches,
          commit: chomp revision
          :name

      return branches, current


    --- Return the revision hash for a given label, or false
    known_label = (label) ->
      out = exec "for-each-ref", "--format=%(refname:short)",
        "refs/heads",
        "refs/remotes"
        
      each_line (out or ""), (line, _, _, final) ->
        if label == line or str.HasSuffix(line, "/#{label}")
          label = line
          return final true
    
      out, err = exec "rev-parse", "--quiet", "--verify", label
      unless (err and err != "") or (out and out != "")
        return false, err
      return chomp(out)

    return {
      :new, :exec, :exec_async,
      :exec_async_cb, :in_repo,
      :known_label, :get_branches,
      :top_level
    }


  --- Updates tracked branch information for the given buffer
  -- @tparam table|nil Path information for the operative buffer
  -- @tparam userdata Triggering buffer object
  -- @return none
  update_branch_status = (->
    ref_data_fmt = "--format=%(HEAD);%(refname:short);%(objectname:short);%(upstream:short)"
    re_sha_sum = regexp.MustCompile"^\\s*([0-9a-zA-Z]{40}?)\\s*$"
    (finfo, cmd) =>
      GITLINE_ACTIVE = truthy cfg.GetGlobalOption "#{NAME}.updateinfo"
      return unless GITLINE_ACTIVE
      return unless finfo and (not @Type.Scratch) and (@Path != '')

      unless cmd
        cmd, err = new_command finfo.dir
        return send.updater (err .. " (to suppress this message, set #{NAME}.updateinfo to false)") unless cmd    

      return unless cmd.in_repo!
      
      if BUFFER_REPO[finfo.abs]
        return if BUFFER_REPO[finfo.abs].__updating
        if BUFFER_REPO[finfo.abs].branch
          if REPO_STATUS[BUFFER_REPO[finfo.abs].branch]
            return if REPO_STATUS[BUFFER_REPO[finfo.abs].branch].__updating

      local start_chain, parse_repo_root, parse_initial_commit
      local parse_ref_data, parse_detached_head, start_get_countstaged
      local parse_diff_string, finish_chain
      
      set_empty = (reason) ->
        debug "update_branch_status: Setting empty tableset for #{finfo.abs}: #{reason}"
        BUFFER_REPO[finfo.abs] = { repoid: false, branch: false }


      repoid = ''
      branch = ''
      repo_root = ''
      repo_root_err = ''
      start_chain = ->
        debug "update_branch_status: Beginning update process for #{self}"
        cmd.exec_async_cb "rev-parse", nil,
          ((out) -> repo_root ..= out),
          ((err) -> repo_root_err ..= err),
          parse_repo_root,
          "--show-toplevel"


      first_commit = ''
      first_commit_err = ''
      parse_repo_root = ->
        unless repo_root_err == ''
          return set_empty "error encountered getting repository root: #{repo_root_err}"
        unless repo_root
          return set_empty "got nil repository root"
        repo_root = chomp repo_root
        if repo_root == ''
          return set_empty "got empty repository root"
          
        cmd.exec_async_cb "rev-list", nil,
          ((out) -> first_commit ..= out),
          ((err) -> first_commit_err ..= err),
          parse_initial_commit,
          "--parents",
          "HEAD",
          "--reverse"


      ref_data = ''
      ref_data_err = ''
      parse_initial_commit = ->
        unless first_commit_err == ''
          return set_empty "error encountered getting first revision: #{first_commit_err}"
        unless first_commit and first_commit != ''
          return set_empty "got empty initial commit"
        ok = each_line chomp(first_commit),
          (line, i, len, final) ->
            _hash = re_sha_sum\FindString line
            return final false unless _hash and _hash != ''
            first_commit = _hash
            return final true

        unless ok
          return set_empty "failed to parse initial commit"

        repoid = "#{first_commit}:#{repo_root}"
        
        unless REPO_STATUS[repoid]
          REPO_STATUS[repoid] = {}

        unless BUFFER_REPO[finfo.abs]
          BUFFER_REPO[finfo.abs] = {}

        BUFFER_REPO[finfo.abs].repoid = repoid
        cmd.exec_async_cb "for-each-ref", nil,
          ((out) -> ref_data ..= out),
          ((err) -> ref_data_err ..= err),
          parse_ref_data,
          ref_data_fmt,
          "refs/heads"


      head_data = ''
      diff_string = ''
      head_data_err = ''
      diff_string_err = ''
      parse_ref_data = ->
        unless ref_data_err == ''
          return set_empty "error encountered getting branch: #{ref_data_err}"
        unless ref_data and ref_data != ''
          return set_empty "repository has no branches setup (got empty)"

        get_detached = ->
          branch = ''
          branch_err = ''
          return cmd.exec_async_cb "branch", nil,
            ((out) -> head_data ..= out),
            ((err) -> head_data_err ..= err),
            parse_detached_head,
            "--contains",
            "HEAD"

        local origin, branch, commit
        
        dbg_msg = "failed to parse ref data: '#{ref_data}'. Checking for detached HEAD"
        return get_detached! unless each_line ref_data, (line, i, c, final) ->
          debug "Line: #{line}, #{string.sub(line, 1, 1)}"
          return unless string.sub(line, 1, 1) == "*"
          
          branch, commit, origin = line\match"^%*;([^;]+);([^;]+);([^;]*)$"
          debug "Got: #{branch}, #{origin}, #{commit}"
          
          return final true if origin and origin != ''
          
          debug dbg_msg
          final!

        unless REPO_STATUS[repoid][branch]
          REPO_STATUS[repoid][branch] = {}

        branch_tbl = REPO_STATUS[repoid][branch]
        bufinf_tbl = BUFFER_REPO[finfo.abs]
        
        branch_tbl.name = branch  
        branch_tbl.commit = commit
        branch_tbl.display = branch
        
        bufinf_tbl.repoid = repoid
        bufinf_tbl.branch = branch
        bufinf_tbl.branch_ptr = branch_tbl
      
        cmd.exec_async_cb "rev-list", nil,
          ((out) -> diff_string ..= out),
          ((err) -> diff_string_err ..= err),
          parse_diff_string,
          "--left-right",
          "--count",
          "#{origin}...#{branch}"


      parse_detached_head = ->
        n = 'parse_detached_head'
        unless head_data and head_data != ''
          return set_empty "#{n}: got empty branch list"
        unless head_data_err == ''
          return set_empty "#{n}: error encountered getting branch: #{head_data}"

        local commit

        return set_empty "failed to parse state: #{head_data}" unless each_line chomp(head_data),
          (line, i, len, final) ->
            _hash = line\match'^%s*%*%s*%(%s*HEAD%s+detached%s+at%s+([0-9A-Za-z]+)%s*%)%s*$'
            if _hash
              commit = _hash
              return final true

        unless REPO_STATUS[repoid][commit]
          REPO_STATUS[repoid][commit] = {}

        branch_tbl = REPO_STATUS[repoid][commit]
        bufinf_tbl = BUFFER_REPO[finfo.abs]
        
        branch_tbl.name = commit
        branch_tbl.commit = commit
        branch_tbl.display = "(detached HEAD)"
        
        bufinf_tbl.repoid = repoid
        bufinf_tbl.branch = commit
        bufinf_tbl.branch_ptr = branch_tbl
        
        cmd.exec_async_cb "rev-list", nil,
          ((out) -> diff_string ..= out),
          ((err) -> diff_string_err ..= err),
          parse_diff_string,
          "--left-right",
          "--count",
          "#{commit}...#{commit}"


      count_staged = ''
      count_staged_err = ''
      parse_diff_string = ->
        unless diff_string_err == ''
          return set_empty "error encountered getting diff string: #{diff_string_err}"

        a, b = 0, 0
        unless diff_string and diff_string != ''
          a, b = (chomp diff_string)\match("^(%d+)%s+(%d+)$")

        
        branch_tbl = BUFFER_REPO[finfo.abs].branch_ptr
        branch_tbl.ahead = a
        branch_tbl.behind = b
          
        cmd.exec_async_cb "diff", nil,
          ((out) -> count_staged ..= out),
          ((err) -> count_staged_err ..= err),
          finish_chain,
          "--name-only",
          "--cached"

      -- Count the number of staged files and mark the repo+branch and file
      -- as no longer being updated
      finish_chain = ->
        unless count_staged_err == ''
          return set_empty "error encountered getting list of staged files: #{count_staged_err}"
      
        staged = select(2, (chomp count_staged)\gsub("([^%s\r\n]+)", ''))
        branch_tbl = BUFFER_REPO[finfo.abs].branch_ptr
        branch_tbl.staged = staged
        branch_tbl.__updating = false
        BUFFER_REPO[finfo.abs].__updating = false
        GITLINE_ACTIVE = true

      start_chain!
  )!


  suppress = " (to suppress this message, set #{NAME}.gitgutter to false)"

  --- Updates the base object that Micro will use to diff the current buffer against
  -- @tparam table|nil Path information for the operative buffer
  -- @tparam userdata Triggering buffer object
  -- @return none
  update_git_diff_base = (finfo, cmd) =>
    return unless truthy cfg.GetGlobalOption "#{NAME}.gitgutter"
    return unless truthy cfg.GetGlobalOption "diffgutter"
    return unless finfo and (not @Type.Scratch) and (@Path != '')

    return if ACTIVE_UPDATES[finfo.abs]
    ACTIVE_UPDATES[finfo.abs] = true

    unless cmd
      cmd, err = new_command finfo.dir
      return send.diffupdate "#{err}#{suppress}" unless cmd  

    return unless cmd.in_repo!
    repo_relative_path = ''
    top_level = ''
    diff_base = ''

    local parse_top_level, start_chain, finish_chain
    
    start_chain = ->
      debug "update_git_diff_base: Starting git diff chain"
      cmd.exec_async_cb "rev-parse", nil,
        ((out) -> top_level ..= out),
        ((out) -> top_level ..= out),
        parse_top_level,
        "--show-toplevel"
    
    parse_top_level = ->
      repo_relative_path = str.TrimPrefix finfo.abs, chomp(top_level)
      debug "update_git_diff_base: Got repo_relative: #{repo_relative_path} for #{finfo.abs}"
      cmd.exec_async_cb "show", nil,
        ((out) -> diff_base ..= out),
        ((out) -> diff_base ..= out),
        finish_chain,
        ":./#{repo_relative_path}"

    finish_chain = ->
      diff_base = @Bytes! unless diff_base and diff_base != ''
      @SetDiffBase diff_base
      ACTIVE_UPDATES[finfo.abs] = false

    start_chain!

  --- Create a new pane with the contents of output.
  -- 
  -- This function take the generated pane and inserts it along with the temp
  -- file used by git.commit and a callback to the table of active commits.
  --
  -- The provided callback function should have the signature with string being
  -- a filepath.
  --   (string) ->
  -- 
  -- @tparam userdata root pane object
  -- @tparam table git.new_command object (used to diff the current buffer)
  -- @tparam output string to populate new pane with
  -- @tparam function oncommit callback
  -- @return none
  make_commit_pane = (root, cmd, output, fn) ->
    filepath = make_temp 'commit'
    ioutil.WriteFile filepath, output, 0x1B0 -- 0660, to account for octal
    
    commit_header = "[new commit: save and quit to finalize]"
    commit_pane = make_empty_hsplit root, ((h) -> h - (h / 3)), commit_header, output, filepath
    commit_pane.Buf.Type.Scratch = false
    commit_pane.Buf.Type.Readonly = false

    callback = fn
    diff_header = "[changes staged for commit]"
    diff_output = cmd.exec "diff", "--cached"
    if diff_output != ''
      closed = false
      diff_pane = make_empty_vsplit commit_pane, ((w) -> w / 2 ), diff_header, diff_output
      diff_pane.Buf.Type.Scratch = false

      add_callback "onQuit", (any) ->
        if (any == diff_pane) or (any == diff_pane.Buf)
          closed = true
        return closed
        
      callback = (...) ->
        diff_pane\ForceQuit! unless closed
        closed = true
        fn ...

    tab = (commit_pane\Tab!)
    tab\SetActive tab\GetPane commit_pane\ID!

    table.insert ACTIVE_COMMITS, {
      pane: commit_pane
      file: filepath
      done: false
      root: root
      :callback
    }


  --- Provide branch and tag label completion for a repo
  branch_complete = (->
    ref_data_fmt = "--format=%(refname:short);%(objectname:short)"
    
    return =>
      root = app.CurPane!
      return nil, nil unless root

      _, dir, _, _ = get_path_info root.Buf.Path
      
      cmd = new_command dir
      return nil, nil unless cmd
      return nil, nil unless cmd.in_repo!

      out = cmd.exec 'for-each-ref', ref_data_fmt,
        "refs/heads",
        "refs/remotes",
        "refs/tags"
      return nil, nil unless out

      args, arg, place = get_arg self
      branches = {}
      suggestions = {}
      completions = {}

      -- Prevents duplicate branches from being added (which can happen, as we 
      -- are checking both local and remote refs)
      added = {}
      each_line out, (line) ->
        branch = line\match"^([^;]+);([^;]+)$"
        return unless branch
        branch = branch\gsub("^[^/]+/", "")
        return if added[branch]
        table.insert branches, branch
        added[branch] = true
      
      c = @GetActiveCursor!

      for _, branch in ipairs branches
        if str.HasPrefix(branch, arg) and not (branch == arg)
          table.insert suggestions, branch
          table.insert completions, string.sub(branch, c.X - place)
    
      return completions, suggestions
  )!


  --- Provide file completion using a repo's top level directory
  repo_complete = =>
    root = app.CurPane!
    c = @GetActiveCursor!

    _, dir, _, _ = get_path_info root.Buf.Path
    cmd, err = new_command dir
    return nil, nil unless cmd
    return nil, nil unless cmd.in_repo!

    repo_root = cmd.top_level!
    return nil, nil unless repo_root
    
    args, arg, place = get_arg self
    dirs = str.Split arg, PATHSEP
    dir_str = str.Join([d for d in *dirs[1,]], PATHSEP)
    files = {}

    local err
    if #dirs > 1
      _path = replace_home(dir_str .. PATHSEP)
      unless str.HasPrefix(_path, PATHSEP)
        _path = repo_root .. PATHSEP .. _path
      files, err = ioutil.ReadDir _path
      
    else
      files, err = ioutil.ReadDir repo_root

    return nil, nil if err

    suggestions = {}
    completions = {}
    
    for _, f in iter_goarray files
      name = f\Name!
      name ..= PATHSEP if f\IsDir!
      if str.HasPrefix name, dirs[#dirs]
        table.insert suggestions, name
        name = dir_str .. name if #dirs > 1
        table.insert completions, string.sub(name, c.X - place)

    return completions, suggestions

  return {
    :update_branch_status
    :update_git_diff_base
    :branch_complete
    :repo_complete
      
    init: (finfo) =>
      return send.init errors.need_file unless finfo
      return send.init errors.no_scratch if is_scratch @Buf

      cmd, err = new_command finfo.dir
      return send.init err unless cmd
      return send.init errors.is_a_repo if cmd.in_repo!
        
      out, err = cmd.exec "init"
      return send.init err if err
      send.init out
      
    init_help: [[
      Usage: %pub%.init
        Initialize a repository in the current panes directory
    ]]

    diff: (finfo, ...) =>
      return send.diff errors.need_file unless finfo
      return send.diff errors.no_scratch if is_scratch @Buf
      
      cmd, err = new_command finfo.dir
      return send.diff err unless cmd
      return send.diff errors.not_a_repo unless cmd.in_repo!

      diff_all, diff_staged, header = false, false, ''
      diff_args = {}

      if ...
        for a in *{...}
          switch a
            when '--all', '-a'
              diff_all = true
            when '--staged', '-s'
              diff_staged = true

      if diff_staged
        table.insert diff_args, "--cached"
        header ..= "(staged) "

      if not diff_all
        repo_relative_file = str.TrimPrefix finfo.abs, cmd.top_level!
        repo_relative_file = str.TrimPrefix repo_relative_file, "/"
        table.insert diff_args, "./" .. repo_relative_file
        header ..= "REPO:./#{repo_relative_file}"
      else
        header ..= "(showing all changes)"

      out, err = cmd.exec "diff", unpack diff_args
      out = "no changes to diff" if chomp(out) == ''
      return send.diff err if err
      send.diff out, :header
      
    diff_help: [[
      Usage: %pub%.diff
        Git diff HEAD for the current file

      Options:
        -s --staged   Include staged files
        -a --all      Diff entire repository
    ]]
    
    fetch: (finfo) =>
      return send.fetch errors.need_file unless finfo
      return send.fetch errors.no_scratch if is_scratch @Buf
      
      cmd, err = new_command finfo.dir
      return send.fetch err unless cmd
      return send.fetch errors.not_a_repo unless cmd.in_repo!
        
      _, err = cmd.exec_async self, "fetch"
      return send.fetch err if err
      return

    fetch_help: [[
      Usage: %pub%.fetch
        Fetch latest changes from remotes
    ]]

    checkout: (->
      re_valid_label = regexp.MustCompile"^[a-zA-Z-_/.]+$"

      return (finfo, label) =>
        return send.checkout errors.need_file unless finfo
        return send.checkout errors.no_scratch if is_scratch @Buf
        
        cmd, err = new_command finfo.dir
        unless cmd
          return send.checkout err
        
        unless cmd.in_repo!
          return send.checkout errors.not_a_repo

        unless label != nil
          return send.checkout errors.not_enough_args .. "(supply a branch/tag/commit)"

        unless re_valid_label\Match label
          return send.checkout errors.bad_label_arg

        unless cmd.known_label label
          return send.checkout errors.unknown_label

        out, err = cmd.exec "checkout", label
        return send.checkout err if err
        send.checkout out
    )!

    checkout_help: [[
      Usage: %pub%.help <label>
        Checkout a specific branch, tag, or revision
    ]]

    list: (finfo) =>
      return send.list errors.need_file unless finfo
      return send.list errors.no_scratch if is_scratch @Buf
      
      cmd, err = new_command finfo.dir
      unless cmd
        return send.list err
      
      unless cmd.in_repo!
        return send.checkout errors.not_a_repo

      branches, current = cmd.get_branches!
      return unless branches
      output   = ''

      output ..= "Branches:\n"
      for branch in *branches
        if branch.name == current
          output ..= "-> "
        else
          output ..= "   "
        output ..= "#{branch.name} - rev:#{branch.commit}\n"

      return send.list_branches output

    list_help: [[
      Usage: %pub%.list
        List branches, and note the currently active branch
    ]]

    status: (finfo) =>
      return send.status errors.need_file unless finfo
      return send.status errors.no_scratch if is_scratch @Buf
      
      cmd, err = new_command finfo.dir
      unless cmd
        return send.status err
    
      unless cmd.in_repo!
        return send.status errors.not_a_repo

      status_out, err = cmd.exec "status"
      return send.status err if err
      send.status status_out

    status_help: [[
      Usage: %pub%.status
        Show current status of the active repo
    ]]
    
    branch: (->
      re_valid_label = regexp.MustCompile"^[a-zA-Z-_/.]+$"

      return (finfo, label) =>
        return send.branch errors.need_file unless finfo
        return send.branch errors.no_scratch if is_scratch @Buf
        
        cmd, err = new_command finfo.dir
        unless cmd
          return send.branch err
        
        unless cmd.in_repo!
          return send.branch errors.not_a_repo
          
        unless re_valid_label\Match label
          return send.branch errors.invalid_lbl

        if rev = cmd.known_label label
          return send.branch errors.invalid_arg ..
            ", please supply an unused label (#{label} is rev:#{rev})"

        branch_out, err = cmd.exec "branch", label
        out = "> git branch #{label}\n"
        out ..= branch_out

        unless err
          chkout_out, _ = cmd.exec "checkout", label
          out ..= "> git checkout #{label}\n"
          out ..= chkout_out

        send.branch out
    )!

    branch_help: [[
      Usage: %pub%.branch <label>
        Create a new local branch, and switch to it, also note that it performs a 
        git-fetch prior to making any changes.
    ]]

    commit: (->    
      msg_line = regexp.MustCompile"^\\s*([^#])"
      base_msg = "\n# Committing as:\n#   %name% - %email%\n#\n"
      base_msg ..= "# Please enter the commit message for your changes. Lines starting\n"
      base_msg ..= "# with '#' will be ignored, and an empty message aborts the commit.\n#\n"

      return (finfo, msg) =>
        return send.commit errors.need_file unless finfo
        return send.commit errors.no_scratch if is_scratch @Buf
        
        cmd, err = new_command finfo.dir
        unless cmd
          return send.commit err
      
        unless cmd.in_repo!
          return send.commit errors.not_a_repo

        if msg
          commit_out, err = cmd.exec "commit", "-m", msg
          return send.commit err if err
          return send.commit commit_out

        name, err = cmd.exec "config", "user.name"
        return send.commit err if err
        
        email, err = cmd.exec "config", "user.email"
        return send.commit err if err

        commit_msg_start = base_msg\gsub("%%name%%", chomp name)\gsub("%%email%%", chomp email)
        
        status_out, _ = cmd.exec "status"
        each_line chomp(status_out), (line) ->
          commit_msg_start ..= "# #{line}\n"

        add_callback "onQuit", (pane, finfo) ->
          return unless #ACTIVE_COMMITS > 0
          
          for i, commit in ipairs ACTIVE_COMMITS
            continue unless commit.pane == pane
            if commit.ready
              commit.callback pane.Buf, commit.file
              table.remove ACTIVE_COMMITS, i
              return true

            info = app.InfoBar!
            unless pane.Buf\Modified!
              info\Message "Aborted commit (closed without saving)"
              commit.callback false
              os.Remove commit.file
              table.remove ACTIVE_COMMITS, i
              return

            if info.HasYN and info.HasPrompt
              info.YNCallback = ->
              info\AbortCommand!

            info\YNPrompt "Would you like to save and commit? (y,n,esc)",
              (yes, cancelled) ->
                return if cancelled
                
                unless yes
                  info\Message "Aborted commit (closed without saving)"
                  os.Remove commit.file
                  commit.callback false
                  pane\ForceQuit!
                else
                  pane.Buf\Save!
                  pane\ForceQuit!
                  commit.callback pane.Buf, commit.file
                  os.Remove commit.file
                
                for t, _temp in ipairs ACTIVE_COMMITS
                  if _temp == commit
                    table.remove ACTIVE_COMMITS, t
                    break
                    
            return true

        make_commit_pane self, cmd, commit_msg_start, (buffer, file, _) ->
          return unless file
          
          commit_msg = ioutil.ReadFile file
          commit_msg = str.TrimSuffix commit_msg, commit_msg_start
          
          if commit_msg == ""
            return send.commit "Aborting, empty commit"

          final_commit = ''
          each_line chomp(commit_msg), (line) ->
            return if line == nil
            
            if msg_line\Match line
              final_commit ..= "#{line}\n"

          ioutil.WriteFile file, final_commit, 0x1B0 -- 0660 octal

          if "" == chomp final_commit
            return send.commit "Aborting, empty commit"
            
          commit_out, err = cmd.exec "commit", "-F", file
          return send.commit err if err
          send.commit commit_out
          
          update_branch_status buffer, finfo
          update_git_diff_base buffer, finfo
    )!

    commit_help: [[
      Usage: %pub%.commit [<commit message>]
        Begin a new commit. If a commit message is not provided, opens a new
        pane to enter the desired message into. Commit is initiated when the
        pane is saved and then closed.
    ]]

    push: (->
      re_valid_label = regexp.MustCompile"^[a-zA-Z-_/.]+$"
      
      return (finfo, branch) =>
        return send.push errors.need_file unless finfo
        return send.push errors.no_scratch if is_scratch @Buf
        
        cmd, err = new_command finfo.dir
        unless cmd
          return send.push err
      
        unless cmd.in_repo!
          return send.push errors.not_a_repo

        if branch != nil  
          unless re_valid_label\Match branch
            return send.push errors.bad_label_arg
        else
          branch = "--all"

        _, err = cmd.exec_async self, "push", branch
        return send.push err if err
        return
    )!

    push_help: [[
      Usage: %pub%.push [<label>]
        Push local changes onto remote. A branch label is optional, and limits
        the scope of the push to the provided branch. Otherwise, all changes
        are pushed.
    ]]

    pull: (finfo) =>
      return send.pull errors.need_file unless finfo
      return send.pull errors.no_scratch if is_scratch @Buf
    
      cmd, err = new_command finfo.dir
      unless cmd
        return send.pull err
      
      unless cmd.in_repo!
        return send.pull errors.not_a_repo
      
      _, err = cmd.exec_async self, "pull"
      return send.pull err if err
      return

    pull_help: [[
      Usage: %pub%.pull
        Pull all changes from remote into the working tree
    ]]

    log: (finfo) =>
      return send.log errors.need_file unless finfo
      return send.log errors.no_scratch if is_scratch @Buf
      
      cmd, err = new_command finfo.dir
      unless cmd
        return send.log err
      
      unless cmd.in_repo!
        return send.log errors.not_a_repo

      count = 0
      out, err = cmd.exec "log"
      return send.log if err
      each_line chomp(out), (line) ->
        count += 1 if re_commit\MatchString line

      send.log out, {
        header: "#{count} #{w_commit count}"
      }

    log_help: [[
      Usage: %pub%.log
        Show the commit log
    ]]

    stage: (finfo, ...) =>
      return send.stage errors.need_file unless finfo
      return send.stage errors.no_scratch if is_scratch @Buf
      
      cmd, err = new_command finfo.dir
      unless cmd
        return send.stage err

      unless cmd.in_repo!
        return send.stage errors.not_a_repo
      
      files = {}
      for file in *{...}
        continue if file == ".."
        if file == "--all" or file =="-a"
          files = { "." }
          break

        file, err = replace_home file
        return send.stage err if err
        unless path_exists(file) or path_exists(cmd.top_level! .. PATHSEP .. file)
          return send.stage errors.invalid_arg .. ", file #{file} doesn't exist"

        table.insert files, file

      unless #files > 0
        return send.stage errors.not_enough_args .. ", please supply a file"

      cmd.exec "add", unpack files

    stage_help: [[
      Usage: %pub%.stage [<file1>, <file2>, ...] [<options>]
        Stage a file (or files) to commit.

      Options:
        -a --all   Stage all files
    ]]

    unstage: (finfo, ...) =>
      return send.unstage errors.need_file unless finfo
      return send.unstage errors.no_scratch if is_scratch @Buf
      
      cmd, err = new_command finfo.dir
      unless cmd
        return send.unstage err

      unless cmd.in_repo!
        return send.unstage errors.not_a_repo
      
      files = {}
      all = false
      for file in *{...}
        continue if file == ".."
        if file == "--all" or file == "-a"
          files = {}
          all = true
          break
          
        file, err = replace_home file
        return send.unstage err if err
        unless path_exists(file) or path_exists(cmd.top_level! .. PATHSEP .. file)
          return send.unstage errors.invalid_arg .. "(file #{file} doesn't exist)"

        table.insert files, file

      unless (#files > 0) or all
        return send.unstage errors.not_enough_args .. ", please supply a file"

      cmd.exec "reset", "--", unpack files

    unstage_help: [[
      Usage: %pub%.unstage [<file1>, <file2>, ...] [<options>]
        Unstage a file (or files) to commit.

      Options:
        -a --all   Unstage all files
    ]]

    rm: (finfo, ...) =>
      return send.rm errors.need_file unless finfo
      return send.rm errors.no_scratch if is_scratch @Buf
      
      cmd, err = new_command finfo.dir
      unless cmd
        return send.rm err

      unless cmd.in_repo!
        return send.add errors.not_a_repo
    
      files = {}
      for file in *{...}
        continue if file == ".."
        if file == "."
          files = { "." }
          break

        file, err = replace_home file
        return send.rm err if err
        unless path_exists file
          return send.rm errors.invalid_arg .. "(file #{file} doesn't exist)"

        table.insert files, file

      unless #files > 0
        return send.rm errors.not_enough_args .. ", please supply a file"

      cmd.exec "rm", unpack files

    rm_help: [[
      Usage: %pub%.rm [<file1>, <file2>, ...]
        Stage the removal of a file (or files) from the git repo.
    ]]

    debug: (finfo, ...) =>
      return send.debug errors.need_file unless finfo
    
      debug_output = ''
      cmd, err = new_command finfo.dir
      unless cmd
        return send.debug err

      _, branch = cmd.get_branches!
      unless branch
        branch = "Error"        

      debug_output ..= "File: #{finfo.abs}\n"
      debug_output ..= "Name: #{finfo.name}\n"
      debug_output ..= "PWD: #{finfo.pwd}\n"
      debug_output ..= "Directory: #{finfo.dir}\n"
      debug_output ..= "Absolute Path: #{finfo.abs}\n"
      debug_output ..= "In Repo: #{cmd.in_repo! or false}\n"
      debug_output ..= "Branch: #{branch}\n"

      debug_output ..= "\n"
      debug_output ..= "_G.ACTIVE_UPDATES\n"
      for k, v in pairs ACTIVE_UPDATES
        debug_output ..= "  Updating Diff: #{k}: #{v}\n"

      debug_output ..= "_G.ACTIVE_COMMITS\n"
      for k, v in pairs ACTIVE_COMMITS
        debug_output ..= "  Active Commits: #{k}: #{v}\n"
        
      debug_output ..= "_G.BUFFER_REPO\n"
      for k, v in pairs BUFFER_REPO
        debug_output ..= "  File: #{k}\n"
        debug_output ..= "    #{v.repoid}\n"
        debug_output ..= "    #{v.branch}\n"
        
      debug_output ..= "_G.REPO_STATUS\n"
      for k, v in pairs REPO_STATUS
        debug_output ..= "  Repo: #{k}\n"
        for b, data in pairs REPO_STATUS[k]
          debug_output ..= "    Branch: #{b}\n"
          debug_output ..= "      a:#{data.ahead}, b:#{data.behind}, "
          debug_output ..= "c:#{data.commit}, s:#{data.staged}\n"

      debug_output ..= "_G.CALLBACKS_SET\n"
      for k, v in pairs CALLBACKS_SET
        for cb, fn in pairs CALLBACKS_SET[k]
          debug_output ..= "  #{k}: #{fn}\n"

      debug_output ..= "_M: #{_M or 'none'}\n"
      debug_output ..= "_G\n"
      for k, v in pairs _G
        debug_output ..= "  #{k}: #{v}\n"
        if k == _M._NAME
          for k2, v2 in pairs _G[k]
            debug_output ..= "    #{k2}: #{v2}\n"

      return send.debug debug_output
      
    debug_help: [[
      Usage: %pub%.debug
        Dumps plugin operational data for easy viewing
    ]]
  }
)!


export numahead = =>
  return "-" unless GITLINE_ACTIVE
  abs = get_path_info @Path
  return "-" unless abs and BUFFER_REPO[abs] and BUFFER_REPO[abs].branch_ptr
  return tostring BUFFER_REPO[abs].branch_ptr.ahead or "-"


export numbehind = =>
  return "-" unless GITLINE_ACTIVE
  abs = get_path_info @Path
  return "-" unless abs and BUFFER_REPO[abs] and BUFFER_REPO[abs].branch_ptr
  return tostring BUFFER_REPO[abs].branch_ptr.behind or "-"


export numstaged = =>
  return "-" unless GITLINE_ACTIVE
  abs = get_path_info @Path
  return "-" unless abs and BUFFER_REPO[abs] and BUFFER_REPO[abs].branch_ptr
  return tostring BUFFER_REPO[abs].branch_ptr.staged or "-"


export oncommit = =>
  return "-" unless GITLINE_ACTIVE
  abs = get_path_info @Path
  return "-" unless abs and BUFFER_REPO[abs] and BUFFER_REPO[abs].branch_ptr
  return tostring BUFFER_REPO[abs].branch_ptr.commit or "-"


export onbranch = =>
  return "-" unless GITLINE_ACTIVE
  abs = get_path_info @Path
  return "-" unless abs and BUFFER_REPO[abs] and BUFFER_REPO[abs].branch_ptr
  return tostring BUFFER_REPO[abs].branch_ptr.display or "-"


export preinit = ->
  add_config "command", "", [[
    The absolute path to the command to use for git operations (type: string) 
  ]]

  add_config "updateinfo", true, [[
    Update tracked branch information during select callbacks (type: boolean)

    Note: Required for statusline
  ]]

  add_config "gitgutter", true, [[
    Enable or disable updating the diff gutter with git changes (type: boolean)

    Note: To use this, ensure the diff plugin is installed and diffgutter enabled!
  ]]

  add_config "cleanstale", true, [[
    Enable or disable whether this plugin deletes it's old tempfiles on startup (type: boolean)
  ]]

  add_statusinfo "numahead", numahead, [[
    The number of commits ahead of your branches origin (type: number)
  ]]
  
  add_statusinfo "numbehind", numbehind, [[
    The number of commits behind of origin your branches tree is (type: number)
  ]]
  
  add_statusinfo "numstaged", numstaged, [[
    The number of files staged in the local branch (type: number)
  ]]
  
  add_statusinfo "onbranch", onbranch, [[
    The current branch of a pane
  ]]
  
  add_statusinfo "oncommit", oncommit, [[
    The latest commit short hash
  ]]

  if truthy cfg.GetGlobalOption "#{NAME}.cleanstale"
    debug "Clearing stale temporary files ..."
    pfx = "#{NAME}."
    dir = path.Join "#{cfg.ConfigDir}", "tmp"

    files, err = ioutil.ReadDir dir
    unless err
      for f in *files
        debug "Does #{f\Name!} have the prefix #{pfx}?"
        if str.HasPrefix f\Name!, pfx
          filepath = path.Join dir, f\Name!
          debug "Clearing #{filepath}"
          os.Remove filepath

export init = ->
  debug "Initializing #{NAME}"

  cmd = tostring cfg.GetGlobalOption "#{NAME}.command"
  if cmd == ""
    cmd, _ = shl.ExecCommand "command", "-v", "git"
    if cmd == '' or not cmd
      app.TermMessage "#{NAME}: git not present in $PATH or set, plugin will not work correctly"
    else
      cfg.SetGlobalOption "#{NAME}.command", chomp cmd

  add_command "init", git.init,
    callbacks: {
      git.update_branch_status
      git.update_git_diff_base
    }
    
  add_command "pull", git.pull,
    completer: git.branch_complete
    callbacks: {
      git.update_branch_status
      git.update_git_diff_base
    }
    
  add_command "push", git.push,
    completer: git.branch_complete
    callbacks: {
      git.update_branch_status
      git.update_git_diff_base
    }
    
  add_command "branch", git.branch,
    callbacks: {
      git.update_branch_status
      git.update_git_diff_base
    }
    
  add_command "fetch", git.fetch,
    completer: git.branch_complete
    callbacks: {
      git.update_branch_status
      git.update_git_diff_base
    }

  add_command "checkout", git.checkout,
    completer: git.branch_complete
    callbacks: {
      git.update_branch_status
      git.update_git_diff_base
    }

  add_command "stage", git.stage,
    completer: git.repo_complete
    callbacks: {
      git.update_branch_status
      git.update_git_diff_base
    }

  add_command "unstage", git.unstage,
    completer: git.repo_complete
    callbacks: {
      git.update_branch_status
      git.update_git_diff_base
    }
    
  add_command "rm", git.rm,
    completer: git.repo_complete
    callbacks: {
      git.update_branch_status
      git.update_git_diff_base
    }

  if os.Getenv"MICROGIT_DEBUG" == "1"
    add_command "debug", git.debug, 
      callbacks: {
        git.update_branch_status
        git.update_git_diff_base
      }

  -- You would think that git.commit wants a callback, but since it opens a 
  -- pane and creates a callback to process that pane, we just use that one
  -- to handle additional callbacks instead
  add_command "commit", git.commit
  add_command "list", git.list
  add_command "log", git.log
  add_command "status", git.status
  add_command "diff", git.diff

  generate_help!


--- Populate branch tracking information for the buffer
export onBufPaneOpen = =>
  debug "Caught onBufPaneOpen bufpane:#{self}"
  local _finfo
  abs, dir, name, pwd = get_path_info @Buf.Path
  _finfo = {:dir, :abs, :name, :pwd} if pwd
  git.update_branch_status @Buf, _finfo
  git.update_git_diff_base @Buf, _finfo
  return

--- Update branch tracking for the buffer, and if its a commit pane mark it as
-- ready to commit
export onSave = =>
  local _finfo

  abs, dir, name, pwd = get_path_info @Buf.Path
  _finfo = {:dir, :abs, :name, :pwd} if pwd
  git.update_branch_status @Buf, _finfo
  git.update_git_diff_base @Buf, _finfo
  return unless #ACTIVE_COMMITS > 0

  for i, commit in ipairs ACTIVE_COMMITS
    if commit.pane == @
      debug "Marking commit #{i} as ready ..."
      commit.ready = true
      break

  return

--- Remove a buffers path from tracking, and if we are in a commit pane call its
-- callback function if it's been modified and saved. Alternatively, hijack the
-- commit save prompt and offer a confirmation to save and commit.
export onQuit = =>
  abs, parent, name, pwd = get_path_info @Path
  if abs and BUFFER_REPO[abs]
    BUFFER_REPO[abs] = nil
  
  run_callbacks "onQuit", self, {
    :abs
    :pwd
    :name
    dir: parent
  }
