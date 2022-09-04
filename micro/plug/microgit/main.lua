VERSION = "1.0.0"
DESC = 'Git for Micro'
local NAME = _M._NAME
local git
local go = assert(loadstring([[  -- script: lua
  return ({
    import = function (pkg)
      return import(pkg)
    end
  })
  -- script: end
]])())
local os = go.import("os")
local app = go.import("micro")
local buf = go.import("micro/buffer")
local cfg = go.import("micro/config")
local shl = go.import("micro/shell")
local str = go.import("strings")
local util = go.import("micro/util")
local path = go.import("path")
local fpath = go.import("path/file")
local ioutil = go.import("ioutil")
local regexp = go.import("regexp")
local runtime = go.import("runtime")
local GITLINE_ACTIVE = false
local ACTIVE_UPDATES = { }
local ACTIVE_COMMITS = { }
local CALLBACKS_SET = { }
local BUFFER_REPO = { }
local REPO_STATUS = { }
local LOADED_COMMANDS
if not (LOADED_COMMANDS) then
  LOADED_COMMANDS = {
    __order = { }
  }
end
local LOADED_OPTIONS
if not (LOADED_OPTIONS) then
  LOADED_OPTIONS = {
    __order = { }
  }
end
local LOADED_LINEFNS
if not (LOADED_LINEFNS) then
  LOADED_LINEFNS = {
    __order = { }
  }
end
local PATHSEP = string.char(os.PathSeparator)
local bound
bound = function(n, min, max)
  return n > max and max or (n < min and min or n)
end
local debug
debug = function(m)
  return app.Log(tostring(NAME) .. ": " .. tostring(m))
end
local truthy
truthy = function(v)
  if v then
    return true
  else
    return false
  end
end
local errors = {
  is_a_repo = "the current file is already in a repository",
  not_a_repo = "the current file is not in a repository",
  invalid_arg = "invalid_argument provided",
  bad_label_arg = "invalid argument, please provide a valid rev label",
  not_enough_args = "not enough arguments",
  unknown_label = "given label is not known to this repo",
  command_not_found = "invalid command provided (not a command)",
  no_help = "FIXME: no help for command git.",
  no_scratch = "this cannot be run out of a temporary pane",
  need_file = "this can only be run in a file pane"
}
local add_callback
add_callback = function(callback, fn)
  if not (CALLBACKS_SET[callback]) then
    CALLBACKS_SET[callback] = { }
  end
  return table.insert(CALLBACKS_SET[callback], fn)
end
local run_callbacks
run_callbacks = function(callback, ...)
  local active = { }
  for i, fn in ipairs((CALLBACKS_SET[callback] or { })) do
    if not (fn(...)) then
      table.insert(active, fn)
    end
  end
  CALLBACKS_SET[callback] = active
end
local chomp
chomp = function(s)
  s = s:gsub("^%s*", ""):gsub("%s*$", ""):gsub("[\n\r]*$", "")
  return s
end
local replace_home
replace_home = function(_path)
  local _exp_0 = true
  if truthy(str.HasPrefix(_path, "~")) == _exp_0 then
    local home, err = os.UserHomeDir()
    if err then
      return nil, err
    end
    return str.Replace(_path, "~", (home .. PATHSEP), 1)
  elseif truthy(str.HasPrefix(_path, "%USERPROFILE%")) == _exp_0 then
    local home, err = os.UserHomeDir()
    if err then
      return nil, err
    end
    return str.Replace(_path, "%USERPROFILE%", (home .. PATHSEP), 1)
  end
  return _path
end
local each_line
each_line = function(input, fn)
  input = str.Replace(input, "\r\n", "\n", -1)
  input = str.Replace(input, "\n\r", "\n", -1)
  local lines = str.Split(input, "\n")
  local l_count = #lines
  local finish_ret, finish_err
  local stop = false
  local finish
  finish = function(v, err)
    stop = true
    finish_ret = v
    if err then
      finish_err = err
    end
  end
  for i = 1, l_count do
    if stop then
      break
    end
    fn(lines[i], i, l_count, finish)
  end
  return finish_ret, finish_err
end
local iter_goarray
iter_goarray = function(object)
  local len = #object
  local i = 0
  return function()
    i = i + 1
    if i > len then
      return 
    end
    return i, object[i], len
  end
end
local reverse_goarray
reverse_goarray = function(object)
  local len = #object
  local i = len + 1
  return function()
    i = i - 1
    if i < 1 then
      return 
    end
    return i, object[i], len
  end
end
local get_path_info = (function()
  local s = string.char(os.PathSeparator)
  local insert = table.insert
  local windows = (runtime.GOOS == "windows" and true or false)
  local re_part = regexp.MustCompile("[^" .. tostring(s) .. "]+")
  local re_root = regexp.MustCompile("^" .. tostring(windows and '[a-zA-Z]:' or '') .. tostring(s) .. tostring(s) .. "?")
  local convert
  convert = function(goarray)
    local tbl, len = { }, #goarray
    for i = 1, len do
      insert(tbl, goarray[i])
    end
    return tbl
  end
  local has_root
  has_root = function(s)
    return re_root:Match(s)
  end
  return function(filepath)
    if filepath == nil then
      filepath = ""
    end
    if not (filepath ~= "" and type(filepath) == "string") then
      return nil
    end
    local pwd, err = os.Getwd()
    assert(not err, "failed to get current working directory")
    local work_string = filepath
    if not (has_root(filepath)) then
      work_string = pwd .. s .. work_string
    end
    local skip = 0
    local canon_split = { }
    for i, ent, len in reverse_goarray(re_part:FindAllString(work_string, -1)) do
      local _continue_0 = false
      repeat
        local _exp_0 = true
        if (ent == ".") == _exp_0 then
          _continue_0 = true
          break
        elseif (ent == "..") == _exp_0 then
          skip = skip + 1
          _continue_0 = true
          break
        elseif (skip > 0) == _exp_0 then
          skip = skip - 1
          _continue_0 = true
          break
        elseif (skip > len - i) == _exp_0 then
          return nil, "get_path_info: " .. tostring(work_string) .. " invalid path, too many parent traversals"
        end
        insert(canon_split, 1, ent)
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    local absolute = str.Join(canon_split, s)
    if not (windows and (absolute:sub(1, 1)) == s) then
      absolute = s .. absolute
    end
    canon_split = re_part:FindAllString(absolute, -1)
    local name = canon_split[#canon_split]
    local parent = (str.TrimSuffix(absolute, name)) or ""
    parent = (str.TrimSuffix(parent, s)) or ""
    return absolute, parent, name, pwd
  end
end)()
local add_command
add_command = function(name, fn, config)
  if config == nil then
    config = { }
  end
  if LOADED_COMMANDS[name] then
    return 
  end
  local external_name = "git." .. tostring(name)
  local callbacks = config.callbacks or { }
  local completer = config.completer or cfg.NoComplete
  add_callback(external_name, function(...)
    for _index_0 = 1, #callbacks do
      local cb = callbacks[_index_0]
      cb(...)
    end
    return false
  end)
  local cmd
  cmd = function(any, extra)
    local _finfo
    debug("command[" .. tostring(external_name) .. "] started")
    local _buf = any.Buf or any
    local abs, dir, pwd
    abs, dir, name, pwd = get_path_info(_buf.Path)
    if pwd then
      _finfo = {
        dir = dir,
        abs = abs,
        name = name,
        pwd = pwd
      }
    end
    fn(any, _finfo, unpack((function()
      local _accum_0 = { }
      local _len_0 = 1
      local _list_0 = (extra or { })
      for _index_0 = 1, #_list_0 do
        local a = _list_0[_index_0]
        _accum_0[_len_0] = a
        _len_0 = _len_0 + 1
      end
      return _accum_0
    end)()))
    run_callbacks(external_name, _buf, _finfo)
    debug("command[" .. tostring(external_name) .. "] completed")
  end
  cfg.MakeCommand(external_name, cmd, completer)
  LOADED_COMMANDS[name] = {
    cmd = cmd,
    help = git[name .. "_help"]
  }
  return table.insert(LOADED_COMMANDS.__order, name)
end
local add_config
add_config = function(name, default, description)
  if LOADED_OPTIONS[name] then
    return 
  end
  cfg.RegisterCommonOption(NAME, name, default)
  LOADED_OPTIONS[name] = description
  return table.insert(LOADED_OPTIONS.__order, name)
end
local add_statusinfo
add_statusinfo = function(name, fn, description)
  if LOADED_LINEFNS[name] then
    return 
  end
  app.SetStatusInfoFn(tostring(NAME) .. "." .. tostring(name))
  LOADED_LINEFNS[name] = description
  return table.insert(LOADED_LINEFNS.__order, name)
end
local generate_help = (function()
  local get_parser
  get_parser = function()
    local on_line, margin, parsed = 1, '', ''
    local _get_result
    _get_result = function()
      return parsed
    end
    local _parse_line
    _parse_line = function(line, _, total)
      if on_line == 1 and line:match("^%s*$") then
        return 
      end
      if on_line == 1 then
        margin = line:match("^(%s*).+$")
      end
      line = line:gsub(margin, "", 1)
      if (on_line >= total and line:match("^%s*$")) then
        return 
      end
      parsed = parsed .. "\n>  " .. tostring(line)
      on_line = on_line + 1
    end
    return _parse_line, _get_result
  end
  return function()
    local commands_help = "# Microgit\n" .. tostring(DESC) .. "\n\n## Commands"
    local _list_0 = LOADED_COMMANDS.__order
    for _index_0 = 1, #_list_0 do
      local _continue_0 = false
      repeat
        local name = _list_0[_index_0]
        debug("Adding " .. tostring(name) .. " to help")
        commands_help = commands_help .. "\n* %pub%." .. tostring(name)
        if not LOADED_COMMANDS[name].help then
          _continue_0 = true
          break
        end
        local parser, parser_result = get_parser()
        each_line(LOADED_COMMANDS[name].help, parser)
        commands_help = commands_help .. tostring(parser_result()) .. "\n"
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    local options_help = "# Microgit\n" .. tostring(DESC) .. "\n\n## Options"
    local _list_1 = LOADED_OPTIONS.__order
    for _index_0 = 1, #_list_1 do
      local _continue_0 = false
      repeat
        local name = _list_1[_index_0]
        debug("Adding " .. tostring(name) .. " to help")
        options_help = options_help .. "\n* %NAME%." .. tostring(name)
        if not LOADED_OPTIONS[name] then
          _continue_0 = true
          break
        end
        local parser, parser_result = get_parser()
        each_line(LOADED_OPTIONS[name], parser)
        options_help = options_help .. tostring(parser_result()) .. "\n"
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    local statusline_help = "# Microgit\n" .. tostring(DESC) .. "\n\n## Statusline Help"
    local _list_2 = LOADED_LINEFNS.__order
    for _index_0 = 1, #_list_2 do
      local _continue_0 = false
      repeat
        local name = _list_2[_index_0]
        debug("Adding " .. tostring(name) .. " to help")
        statusline_help = statusline_help .. "\n* %NAME%." .. tostring(name)
        if not LOADED_LINEFNS[name] then
          _continue_0 = true
          break
        end
        local parser, parser_result = get_parser()
        each_line(LOADED_LINEFNS[name], parser)
        statusline_help = statusline_help .. tostring(parser_result()) .. "\n"
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    options_help = str.Replace(options_help, '%pub%', 'git', -1)
    options_help = str.Replace(options_help, '%NAME%', NAME, -1)
    commands_help = str.Replace(commands_help, '%pub%', 'git', -1)
    commands_help = str.Replace(commands_help, '%NAME%', NAME, -1)
    statusline_help = str.Replace(statusline_help, '%pub%', 'git', -1)
    statusline_help = str.Replace(statusline_help, '%NAME%', NAME, -1)
    cfg.AddRuntimeFileFromMemory(cfg.RTHelp, tostring(NAME) .. ".commands", commands_help)
    cfg.AddRuntimeFileFromMemory(cfg.RTHelp, tostring(NAME) .. ".options", options_help)
    return cfg.AddRuntimeFileFromMemory(cfg.RTHelp, tostring(NAME) .. ".statusline", statusline_help)
  end
end)()
local wordify
wordify = function(word, singular, plural)
  singular = word .. singular
  plural = word .. plural
  return function(number)
    return number ~= 1 and plural or singular
  end
end
local path_exists
path_exists = function(filepath)
  local finfo, _ = os.Stat(filepath)
  return finfo ~= nil
end
local make_temp = (function()
  local rand = go.import("math/rand")
  local chars = 'qwertyuioasdfghjklzxcvbnm'
  return function(header)
    if header == nil then
      header = 'XXX'
    end
    local dir = path.Join(tostring(cfg.ConfigDir), "tmp")
    local err = os.MkdirAll(dir, 0x1F8)
    assert(not err, err)
    local file = (tostring(NAME) .. "." .. tostring(header) .. ".") .. ("XXXXXXXXXXXX"):gsub('[xX]', function(self)
      local i = rand.Intn(25) + 1
      local c = chars:sub(i, i)
      local _exp_0 = self
      if 'x' == _exp_0 then
        return c
      elseif 'X' == _exp_0 then
        return string.upper(c)
      end
    end)
    debug("Generated new tempfile: " .. tostring(dir) .. "/" .. tostring(file))
    return tostring(path.Join(dir, file))
  end
end)()
local make_empty_hsplit
make_empty_hsplit = function(root, rszfn, header, output, filepath)
  if not output and not filepath then
    output = ""
  end
  local pane
  local old_view = root:GetView()
  local h = old_view.Height
  if filepath then
    pane = root:HSplitIndex(buf.NewBufferFromFile(filepath), true)
  else
    pane = root:HSplitIndex(buf.NewBuffer(output, ""), true)
  end
  pane:ResizePane(rszfn(h))
  pane.Buf.Type.Scratch = true
  pane.Buf.Type.Readonly = true
  pane.Buf.Type.Syntax = false
  pane.Buf:SetOptionNative("softwrap", true)
  pane.Buf:SetOptionNative("ruler", false)
  pane.Buf:SetOptionNative("autosave", false)
  pane.Buf:SetOptionNative("statusformatr", "")
  pane.Buf:SetOptionNative("statusformatl", header)
  pane.Buf:SetOptionNative("scrollbar", false)
  pane.Buf:SetOptionNative("diffgutter", false)
  pane.Cursor.Loc.Y = 0
  pane.Cursor.Loc.X = 0
  pane.Cursor:Relocate()
  return pane
end
local make_empty_vsplit
make_empty_vsplit = function(root, rszfn, header, output, filepath)
  local pane
  local old_view = root:GetView()
  local w = old_view.Width
  if filepath then
    pane = root:VSplitIndex(buf.NewBufferFromFile(filepath, true), true)
  else
    pane = root:VSplitIndex(buf.NewBuffer(output, ""), true)
  end
  pane:ResizePane(rszfn(w))
  pane.Buf.Type.Scratch = true
  pane.Buf.Type.Readonly = true
  pane.Buf.Type.Syntax = false
  pane.Buf:SetOptionNative("softwrap", true)
  pane.Buf:SetOptionNative("ruler", false)
  pane.Buf:SetOptionNative("autosave", false)
  pane.Buf:SetOptionNative("statusformatr", "")
  pane.Buf:SetOptionNative("statusformatl", header)
  pane.Buf:SetOptionNative("scrollbar", false)
  pane.Buf:SetOptionNative("diffgutter", false)
  pane.Cursor.Loc.Y = 0
  pane.Cursor.Loc.X = 0
  pane.Cursor:Relocate()
  return pane
end
local send_block
send_block = function(header, output, syntax)
  if syntax == nil then
    syntax = false
  end
  local pane = make_empty_hsplit(app.CurPane(), (function(h)
    return h - (h / 5)
  end), header, output)
  pane.Buf.Type.Syntax = truthy(syntax)
end
local get_arg
get_arg = function(self)
  local c = self:GetActiveCursor()
  local args = str.Split(util.String(self:LineBytes(c.Y)), ' ')
  local count = #args
  local current = args[count]
  local argstart = 0
  for i, a in iter_goarray(args) do
    if i == count then
      break
    end
    argstart = argstart + (util.CharacterCountInString(a) + 1)
  end
  return args, current, argstart - 1
end
git = (function()
  local w_commit = wordify('commit', '', 's')
  local w_line = wordify('line', '', 's')
  local re_commit = regexp.MustCompile("^commit[\\s]+([^\\s]+).*$")
  local is_scratch
  is_scratch = function(self)
    return self.Type.Scratch
  end
  local send = setmetatable({ }, {
    __index = function(_, cmd)
      return function(msg, config)
        debug("git-" .. tostring(cmd) .. ": Issuing message - " .. tostring(msg))
        local line_count = select(2, string.gsub(tostring(msg), "[\r\n]", ""))
        debug("LineCount: " .. tostring(line_count))
        if line_count > 1 then
          local header = "git." .. tostring(cmd)
          if type(config) == "table" then
            if config.header ~= nil then
              header = tostring(header) .. ": " .. tostring(config.header)
            end
          end
          send_block(header, msg)
          return 
        end
        (app.InfoBar()):Message("git." .. tostring(cmd) .. ": " .. tostring(msg))
      end
    end
  })
  local new_command
  new_command = function(directory)
    if type(directory) ~= 'string' or directory == '' then
      debug("filepath '" .. tostring(filepath) .. "' is not a valid editor path (need non-empty string): (got: " .. tostring(type(filepath)) .. ")")
      return nil, "Please run this in a file pane"
    end
    local exec
    exec = function(command, ...)
      if not (path_exists(directory)) then
        return nil, "directory " .. tostring(directory) .. " does not exist"
      end
      debug("Parent directory " .. tostring(directory) .. " exists, continuing ...")
      local base = cfg.GetGlobalOption(tostring(NAME) .. ".command")
      if base == "" then
        local _
        base, _ = shl.ExecCommand("command", "-v", "git")
        base = chomp(base)
        if base == '' or not base then
          return nil, "no git configured"
        end
      end
      debug("Found valid git path: " .. tostring(base))
      if not (path_exists(base)) then
        return nil, err.Error()
      end
      local out = shl.ExecCommand(base, "-P", "-C", directory, command, ...)
      return out
    end
    local exec_async
    exec_async = function(self, cmd, ...)
      if not (path_exists(directory)) then
        return nil, "directory " .. tostring(directory) .. " does not exist"
      end
      debug("Parent directory " .. tostring(directory) .. " exists, continuing ...")
      local base = cfg.GetGlobalOption(tostring(NAME) .. ".command")
      if base == "" then
        local _
        base, _ = shl.ExecCommand("command", "-v", "git")
        base = chomp(base)
        if base == '' or not base then
          return nil, "no git configured"
        end
      end
      debug("Found valid git path: " .. tostring(base))
      if not (path_exists(base)) then
        return nil, err.Error()
      end
      local resize_fn
      resize_fn = function(h)
        return h - (h / 3)
      end
      local pane = make_empty_hsplit(self, resize_fn, "git-" .. tostring(cmd))
      local on_emit
      on_emit = function(_str, _)
        pane.Buf:Write(_str)
      end
      local on_exit
      on_exit = function(_, _)
        pane.Buf:Write("\n[command has completed, ctrl-q to exit]\n")
      end
      local args = {
        ...
      }
      table.insert(args, 1, cmd)
      table.insert(args, 1, directory)
      table.insert(args, 1, "-C")
      table.insert(args, 1, "-P")
      shl.JobSpawn(base, args, on_emit, on_emit, on_exit)
      return "", nil
    end
    local exec_async_cb
    exec_async_cb = function(cmd, cb_args, on_stdout, on_stderr, on_exit, ...)
      if cb_args == nil then
        cb_args = { }
      end
      if not (path_exists(directory)) then
        return nil, "directory " .. tostring(directory) .. " does not exist"
      end
      debug("Parent directory " .. tostring(directory) .. " exists, continuing ...")
      local base = cfg.GetGlobalOption(tostring(NAME) .. ".command")
      if base == "" then
        local _
        base, _ = shl.ExecCommand("command", "-v", "git")
        base = chomp(base)
        if base == '' or not base then
          return nil, "no git configured"
        end
      end
      debug("Found valid git path: " .. tostring(base))
      if not (path_exists(base)) then
        return nil, err.Error()
      end
      on_stdout = assert(on_stdout, tostring(cmd) .. ": exec_async_cb requires an on_stdout callback")
      on_stderr = assert(on_stderr, tostring(cmd) .. ": exec_async_cb requires an on_stderr callback")
      on_exit = assert(on_exit, tostring(cmd) .. ": exec_async_cb requires an on_exit callback")
      local args = {
        ...
      }
      table.insert(args, 1, cmd)
      table.insert(args, 1, directory)
      table.insert(args, 1, "-C")
      table.insert(args, 1, "-P")
      debug("Launching: " .. tostring(base) .. " " .. tostring(str.Join(args, " ")))
      shl.JobSpawn(base, args, on_stdout, on_stderr, on_exit, unpack(cb_args))
    end
    local in_repo
    in_repo = function()
      local out, err = exec("rev-parse", "--is-inside-work-tree")
      if err then
        return send.in_repo(err)
      end
      return chomp(out) == 'true'
    end
    local top_level
    top_level = function()
      local out, err = exec("rev-parse", "--show-toplevel")
      if not (out) then
        return nil
      end
      return chomp(out)
    end
    local get_branches
    get_branches = function()
      local out, err = exec("branch", "-al")
      if err then
        send.get_branches("failed to get branches: " .. tostring(err))
        return nil, nil
      end
      local branches = { }
      local current = ''
      each_line(chomp(out), function(line)
        debug("Attempting to match: " .. tostring(line))
        local cur, name = line:match("^%s*(%*?)%s*([^%s]+)")
        if name then
          if cur == '*' then
            current = name
          end
        else
          name = cur
        end
        if not (name) then
          return 
        end
        debug("Found branch: " .. tostring(name))
        local revision
        revision, err = exec("rev-parse", name)
        if err and err ~= "" then
          debug("Failed to rev-parse " .. tostring(name) .. ": " .. tostring(err))
          return 
        end
        return table.insert(branches, {
          commit = chomp(revision),
          name = name
        })
      end)
      return branches, current
    end
    local known_label
    known_label = function(label)
      local out = exec("for-each-ref", "--format=%(refname:short)", "refs/heads", "refs/remotes")
      each_line((out or ""), function(line, _, _, final)
        if label == line or str.HasSuffix(line, "/" .. tostring(label)) then
          label = line
          return final(true)
        end
      end)
      local err
      out, err = exec("rev-parse", "--quiet", "--verify", label)
      if not ((err and err ~= "") or (out and out ~= "")) then
        return false, err
      end
      return chomp(out)
    end
    return {
      new = new,
      exec = exec,
      exec_async = exec_async,
      exec_async_cb = exec_async_cb,
      in_repo = in_repo,
      known_label = known_label,
      get_branches = get_branches,
      top_level = top_level
    }
  end
  local update_branch_status = (function()
    local ref_data_fmt = "--format=%(HEAD);%(refname:short);%(objectname:short);%(upstream:short)"
    local re_sha_sum = regexp.MustCompile("^\\s*([0-9a-zA-Z]{40}?)\\s*$")
    return function(self, finfo, cmd)
      GITLINE_ACTIVE = truthy(cfg.GetGlobalOption(tostring(NAME) .. ".updateinfo"))
      if not (GITLINE_ACTIVE) then
        return 
      end
      if not (finfo and (not self.Type.Scratch) and (self.Path ~= '')) then
        return 
      end
      if not (cmd) then
        local err
        cmd, err = new_command(finfo.dir)
        if not (cmd) then
          return send.updater((err .. " (to suppress this message, set " .. tostring(NAME) .. ".updateinfo to false)"))
        end
      end
      if not (cmd.in_repo()) then
        return 
      end
      if BUFFER_REPO[finfo.abs] then
        if BUFFER_REPO[finfo.abs].__updating then
          return 
        end
        if BUFFER_REPO[finfo.abs].branch then
          if REPO_STATUS[BUFFER_REPO[finfo.abs].branch] then
            if REPO_STATUS[BUFFER_REPO[finfo.abs].branch].__updating then
              return 
            end
          end
        end
      end
      local start_chain, parse_repo_root, parse_initial_commit
      local parse_ref_data, parse_detached_head, start_get_countstaged
      local parse_diff_string, finish_chain
      local set_empty
      set_empty = function(reason)
        debug("update_branch_status: Setting empty tableset for " .. tostring(finfo.abs) .. ": " .. tostring(reason))
        BUFFER_REPO[finfo.abs] = {
          repoid = false,
          branch = false
        }
      end
      local repoid = ''
      local branch = ''
      local repo_root = ''
      local repo_root_err = ''
      start_chain = function()
        debug("update_branch_status: Beginning update process for " .. tostring(self))
        return cmd.exec_async_cb("rev-parse", nil, (function(out)
          repo_root = repo_root .. out
        end), (function(err)
          repo_root_err = repo_root_err .. err
        end), parse_repo_root, "--show-toplevel")
      end
      local first_commit = ''
      local first_commit_err = ''
      parse_repo_root = function()
        if not (repo_root_err == '') then
          return set_empty("error encountered getting repository root: " .. tostring(repo_root_err))
        end
        if not (repo_root) then
          return set_empty("got nil repository root")
        end
        repo_root = chomp(repo_root)
        if repo_root == '' then
          return set_empty("got empty repository root")
        end
        return cmd.exec_async_cb("rev-list", nil, (function(out)
          first_commit = first_commit .. out
        end), (function(err)
          first_commit_err = first_commit_err .. err
        end), parse_initial_commit, "--parents", "HEAD", "--reverse")
      end
      local ref_data = ''
      local ref_data_err = ''
      parse_initial_commit = function()
        if not (first_commit_err == '') then
          return set_empty("error encountered getting first revision: " .. tostring(first_commit_err))
        end
        if not (first_commit and first_commit ~= '') then
          return set_empty("got empty initial commit")
        end
        local ok = each_line(chomp(first_commit), function(line, i, len, final)
          local _hash = re_sha_sum:FindString(line)
          if not (_hash and _hash ~= '') then
            return final(false)
          end
          first_commit = _hash
          return final(true)
        end)
        if not (ok) then
          return set_empty("failed to parse initial commit")
        end
        repoid = tostring(first_commit) .. ":" .. tostring(repo_root)
        if not (REPO_STATUS[repoid]) then
          REPO_STATUS[repoid] = { }
        end
        if not (BUFFER_REPO[finfo.abs]) then
          BUFFER_REPO[finfo.abs] = { }
        end
        BUFFER_REPO[finfo.abs].repoid = repoid
        return cmd.exec_async_cb("for-each-ref", nil, (function(out)
          ref_data = ref_data .. out
        end), (function(err)
          ref_data_err = ref_data_err .. err
        end), parse_ref_data, ref_data_fmt, "refs/heads")
      end
      local head_data = ''
      local diff_string = ''
      local head_data_err = ''
      local diff_string_err = ''
      parse_ref_data = function()
        if not (ref_data_err == '') then
          return set_empty("error encountered getting branch: " .. tostring(ref_data_err))
        end
        if not (ref_data and ref_data ~= '') then
          return set_empty("repository has no branches setup (got empty)")
        end
        local get_detached
        get_detached = function()
          branch = ''
          local branch_err = ''
          return cmd.exec_async_cb("branch", nil, (function(out)
            head_data = head_data .. out
          end), (function(err)
            head_data_err = head_data_err .. err
          end), parse_detached_head, "--contains", "HEAD")
        end
        local origin, branch, commit
        local dbg_msg = "failed to parse ref data: '" .. tostring(ref_data) .. "'. Checking for detached HEAD"
        if not (each_line(ref_data, function(line, i, c, final)
          debug("Line: " .. tostring(line) .. ", " .. tostring(string.sub(line, 1, 1)))
          if not (string.sub(line, 1, 1) == "*") then
            return 
          end
          branch, commit, origin = line:match("^%*;([^;]+);([^;]+);([^;]*)$")
          debug("Got: " .. tostring(branch) .. ", " .. tostring(origin) .. ", " .. tostring(commit))
          if origin and origin ~= '' then
            return final(true)
          end
          debug(dbg_msg)
          return final()
        end)) then
          return get_detached()
        end
        if not (REPO_STATUS[repoid][branch]) then
          REPO_STATUS[repoid][branch] = { }
        end
        local branch_tbl = REPO_STATUS[repoid][branch]
        local bufinf_tbl = BUFFER_REPO[finfo.abs]
        branch_tbl.name = branch
        branch_tbl.commit = commit
        branch_tbl.display = branch
        bufinf_tbl.repoid = repoid
        bufinf_tbl.branch = branch
        bufinf_tbl.branch_ptr = branch_tbl
        return cmd.exec_async_cb("rev-list", nil, (function(out)
          diff_string = diff_string .. out
        end), (function(err)
          diff_string_err = diff_string_err .. err
        end), parse_diff_string, "--left-right", "--count", tostring(origin) .. "..." .. tostring(branch))
      end
      parse_detached_head = function()
        local n = 'parse_detached_head'
        if not (head_data and head_data ~= '') then
          return set_empty(tostring(n) .. ": got empty branch list")
        end
        if not (head_data_err == '') then
          return set_empty(tostring(n) .. ": error encountered getting branch: " .. tostring(head_data))
        end
        local commit
        if not (each_line(chomp(head_data), function(line, i, len, final)
          local _hash = line:match('^%s*%*%s*%(%s*HEAD%s+detached%s+at%s+([0-9A-Za-z]+)%s*%)%s*$')
          if _hash then
            commit = _hash
            return final(true)
          end
        end)) then
          return set_empty("failed to parse state: " .. tostring(head_data))
        end
        if not (REPO_STATUS[repoid][commit]) then
          REPO_STATUS[repoid][commit] = { }
        end
        local branch_tbl = REPO_STATUS[repoid][commit]
        local bufinf_tbl = BUFFER_REPO[finfo.abs]
        branch_tbl.name = commit
        branch_tbl.commit = commit
        branch_tbl.display = "(detached HEAD)"
        bufinf_tbl.repoid = repoid
        bufinf_tbl.branch = commit
        bufinf_tbl.branch_ptr = branch_tbl
        return cmd.exec_async_cb("rev-list", nil, (function(out)
          diff_string = diff_string .. out
        end), (function(err)
          diff_string_err = diff_string_err .. err
        end), parse_diff_string, "--left-right", "--count", tostring(commit) .. "..." .. tostring(commit))
      end
      local count_staged = ''
      local count_staged_err = ''
      parse_diff_string = function()
        if not (diff_string_err == '') then
          return set_empty("error encountered getting diff string: " .. tostring(diff_string_err))
        end
        local a, b = 0, 0
        if not (diff_string and diff_string ~= '') then
          a, b = (chomp(diff_string)):match("^(%d+)%s+(%d+)$")
        end
        local branch_tbl = BUFFER_REPO[finfo.abs].branch_ptr
        branch_tbl.ahead = a
        branch_tbl.behind = b
        return cmd.exec_async_cb("diff", nil, (function(out)
          count_staged = count_staged .. out
        end), (function(err)
          count_staged_err = count_staged_err .. err
        end), finish_chain, "--name-only", "--cached")
      end
      finish_chain = function()
        if not (count_staged_err == '') then
          return set_empty("error encountered getting list of staged files: " .. tostring(count_staged_err))
        end
        local staged = select(2, (chomp(count_staged)):gsub("([^%s\r\n]+)", ''))
        local branch_tbl = BUFFER_REPO[finfo.abs].branch_ptr
        branch_tbl.staged = staged
        branch_tbl.__updating = false
        BUFFER_REPO[finfo.abs].__updating = false
        GITLINE_ACTIVE = true
      end
      return start_chain()
    end
  end)()
  local suppress = " (to suppress this message, set " .. tostring(NAME) .. ".gitgutter to false)"
  local update_git_diff_base
  update_git_diff_base = function(self, finfo, cmd)
    if not (truthy(cfg.GetGlobalOption(tostring(NAME) .. ".gitgutter"))) then
      return 
    end
    if not (truthy(cfg.GetGlobalOption("diffgutter"))) then
      return 
    end
    if not (finfo and (not self.Type.Scratch) and (self.Path ~= '')) then
      return 
    end
    if ACTIVE_UPDATES[finfo.abs] then
      return 
    end
    ACTIVE_UPDATES[finfo.abs] = true
    if not (cmd) then
      local err
      cmd, err = new_command(finfo.dir)
      if not (cmd) then
        return send.diffupdate(tostring(err) .. tostring(suppress))
      end
    end
    if not (cmd.in_repo()) then
      return 
    end
    local repo_relative_path = ''
    local top_level = ''
    local diff_base = ''
    local parse_top_level, start_chain, finish_chain
    start_chain = function()
      debug("update_git_diff_base: Starting git diff chain")
      return cmd.exec_async_cb("rev-parse", nil, (function(out)
        top_level = top_level .. out
      end), (function(out)
        top_level = top_level .. out
      end), parse_top_level, "--show-toplevel")
    end
    parse_top_level = function()
      repo_relative_path = str.TrimPrefix(finfo.abs, chomp(top_level))
      debug("update_git_diff_base: Got repo_relative: " .. tostring(repo_relative_path) .. " for " .. tostring(finfo.abs))
      return cmd.exec_async_cb("show", nil, (function(out)
        diff_base = diff_base .. out
      end), (function(out)
        diff_base = diff_base .. out
      end), finish_chain, ":./" .. tostring(repo_relative_path))
    end
    finish_chain = function()
      if not (diff_base and diff_base ~= '') then
        diff_base = self:Bytes()
      end
      self:SetDiffBase(diff_base)
      ACTIVE_UPDATES[finfo.abs] = false
    end
    return start_chain()
  end
  local make_commit_pane
  make_commit_pane = function(root, cmd, output, fn)
    local filepath = make_temp('commit')
    ioutil.WriteFile(filepath, output, 0x1B0)
    local commit_header = "[new commit: save and quit to finalize]"
    local commit_pane = make_empty_hsplit(root, (function(h)
      return h - (h / 3)
    end), commit_header, output, filepath)
    commit_pane.Buf.Type.Scratch = false
    commit_pane.Buf.Type.Readonly = false
    local callback = fn
    local diff_header = "[changes staged for commit]"
    local diff_output = cmd.exec("diff", "--cached")
    if diff_output ~= '' then
      local closed = false
      local diff_pane = make_empty_vsplit(commit_pane, (function(w)
        return w / 2
      end), diff_header, diff_output)
      diff_pane.Buf.Type.Scratch = false
      add_callback("onQuit", function(any)
        if (any == diff_pane) or (any == diff_pane.Buf) then
          closed = true
        end
        return closed
      end)
      callback = function(...)
        if not (closed) then
          diff_pane:ForceQuit()
        end
        closed = true
        return fn(...)
      end
    end
    local tab = (commit_pane:Tab())
    tab:SetActive(tab:GetPane(commit_pane:ID()))
    return table.insert(ACTIVE_COMMITS, {
      pane = commit_pane,
      file = filepath,
      done = false,
      root = root,
      callback = callback
    })
  end
  local branch_complete = (function()
    local ref_data_fmt = "--format=%(refname:short);%(objectname:short)"
    return function(self)
      local root = app.CurPane()
      if not (root) then
        return nil, nil
      end
      local _, dir
      _, dir, _, _ = get_path_info(root.Buf.Path)
      local cmd = new_command(dir)
      if not (cmd) then
        return nil, nil
      end
      if not (cmd.in_repo()) then
        return nil, nil
      end
      local out = cmd.exec('for-each-ref', ref_data_fmt, "refs/heads", "refs/remotes", "refs/tags")
      if not (out) then
        return nil, nil
      end
      local args, arg, place = get_arg(self)
      local branches = { }
      local suggestions = { }
      local completions = { }
      local added = { }
      each_line(out, function(line)
        local branch = line:match("^([^;]+);([^;]+)$")
        if not (branch) then
          return 
        end
        branch = branch:gsub("^[^/]+/", "")
        if added[branch] then
          return 
        end
        table.insert(branches, branch)
        added[branch] = true
      end)
      local c = self:GetActiveCursor()
      for _, branch in ipairs(branches) do
        if str.HasPrefix(branch, arg) and not (branch == arg) then
          table.insert(suggestions, branch)
          table.insert(completions, string.sub(branch, c.X - place))
        end
      end
      return completions, suggestions
    end
  end)()
  local repo_complete
  repo_complete = function(self)
    local root = app.CurPane()
    local c = self:GetActiveCursor()
    local _, dir
    _, dir, _, _ = get_path_info(root.Buf.Path)
    local cmd, err = new_command(dir)
    if not (cmd) then
      return nil, nil
    end
    if not (cmd.in_repo()) then
      return nil, nil
    end
    local repo_root = cmd.top_level()
    if not (repo_root) then
      return nil, nil
    end
    local args, arg, place = get_arg(self)
    local dirs = str.Split(arg, PATHSEP)
    local dir_str = str.Join((function()
      local _accum_0 = { }
      local _len_0 = 1
      for _index_0 = 1, #dirs do
        local d = dirs[_index_0]
        _accum_0[_len_0] = d
        _len_0 = _len_0 + 1
      end
      return _accum_0
    end)(), PATHSEP)
    local files = { }
    local err
    if #dirs > 1 then
      local _path = replace_home(dir_str .. PATHSEP)
      if not (str.HasPrefix(_path, PATHSEP)) then
        _path = repo_root .. PATHSEP .. _path
      end
      files, err = ioutil.ReadDir(_path)
    else
      files, err = ioutil.ReadDir(repo_root)
    end
    if err then
      return nil, nil
    end
    local suggestions = { }
    local completions = { }
    for _, f in iter_goarray(files) do
      local name = f:Name()
      if f:IsDir() then
        name = name .. PATHSEP
      end
      if str.HasPrefix(name, dirs[#dirs]) then
        table.insert(suggestions, name)
        if #dirs > 1 then
          name = dir_str .. name
        end
        table.insert(completions, string.sub(name, c.X - place))
      end
    end
    return completions, suggestions
  end
  return {
    update_branch_status = update_branch_status,
    update_git_diff_base = update_git_diff_base,
    branch_complete = branch_complete,
    repo_complete = repo_complete,
    init = function(self, finfo)
      if not (finfo) then
        return send.init(errors.need_file)
      end
      if is_scratch(self.Buf) then
        return send.init(errors.no_scratch)
      end
      local cmd, err = new_command(finfo.dir)
      if not (cmd) then
        return send.init(err)
      end
      if cmd.in_repo() then
        return send.init(errors.is_a_repo)
      end
      local out
      out, err = cmd.exec("init")
      if err then
        return send.init(err)
      end
      return send.init(out)
    end,
    init_help = [[      Usage: %pub%.init
        Initialize a repository in the current panes directory
    ]],
    diff = function(self, finfo, ...)
      if not (finfo) then
        return send.diff(errors.need_file)
      end
      if is_scratch(self.Buf) then
        return send.diff(errors.no_scratch)
      end
      local cmd, err = new_command(finfo.dir)
      if not (cmd) then
        return send.diff(err)
      end
      if not (cmd.in_repo()) then
        return send.diff(errors.not_a_repo)
      end
      local diff_all, diff_staged, header = false, false, ''
      local diff_args = { }
      if ... then
        local _list_0 = {
          ...
        }
        for _index_0 = 1, #_list_0 do
          local a = _list_0[_index_0]
          local _exp_0 = a
          if '--all' == _exp_0 or '-a' == _exp_0 then
            diff_all = true
          elseif '--staged' == _exp_0 or '-s' == _exp_0 then
            diff_staged = true
          end
        end
      end
      if diff_staged then
        table.insert(diff_args, "--cached")
        header = header .. "(staged) "
      end
      if not diff_all then
        local repo_relative_file = str.TrimPrefix(finfo.abs, cmd.top_level())
        repo_relative_file = str.TrimPrefix(repo_relative_file, "/")
        table.insert(diff_args, "./" .. repo_relative_file)
        header = header .. "REPO:./" .. tostring(repo_relative_file)
      else
        header = header .. "(showing all changes)"
      end
      local out
      out, err = cmd.exec("diff", unpack(diff_args))
      if chomp(out) == '' then
        out = "no changes to diff"
      end
      if err then
        return send.diff(err)
      end
      return send.diff(out, {
        header = header
      })
    end,
    diff_help = [[      Usage: %pub%.diff
        Git diff HEAD for the current file

      Options:
        -s --staged   Include staged files
        -a --all      Diff entire repository
    ]],
    fetch = function(self, finfo)
      if not (finfo) then
        return send.fetch(errors.need_file)
      end
      if is_scratch(self.Buf) then
        return send.fetch(errors.no_scratch)
      end
      local cmd, err = new_command(finfo.dir)
      if not (cmd) then
        return send.fetch(err)
      end
      if not (cmd.in_repo()) then
        return send.fetch(errors.not_a_repo)
      end
      local _
      _, err = cmd.exec_async(self, "fetch")
      if err then
        return send.fetch(err)
      end
    end,
    fetch_help = [[      Usage: %pub%.fetch
        Fetch latest changes from remotes
    ]],
    checkout = (function()
      local re_valid_label = regexp.MustCompile("^[a-zA-Z-_/.]+$")
      return function(self, finfo, label)
        if not (finfo) then
          return send.checkout(errors.need_file)
        end
        if is_scratch(self.Buf) then
          return send.checkout(errors.no_scratch)
        end
        local cmd, err = new_command(finfo.dir)
        if not (cmd) then
          return send.checkout(err)
        end
        if not (cmd.in_repo()) then
          return send.checkout(errors.not_a_repo)
        end
        if not (label ~= nil) then
          return send.checkout(errors.not_enough_args .. "(supply a branch/tag/commit)")
        end
        if not (re_valid_label:Match(label)) then
          return send.checkout(errors.bad_label_arg)
        end
        if not (cmd.known_label(label)) then
          return send.checkout(errors.unknown_label)
        end
        local out
        out, err = cmd.exec("checkout", label)
        if err then
          return send.checkout(err)
        end
        return send.checkout(out)
      end
    end)(),
    checkout_help = [[      Usage: %pub%.help <label>
        Checkout a specific branch, tag, or revision
    ]],
    list = function(self, finfo)
      if not (finfo) then
        return send.list(errors.need_file)
      end
      if is_scratch(self.Buf) then
        return send.list(errors.no_scratch)
      end
      local cmd, err = new_command(finfo.dir)
      if not (cmd) then
        return send.list(err)
      end
      if not (cmd.in_repo()) then
        return send.checkout(errors.not_a_repo)
      end
      local branches, current = cmd.get_branches()
      if not (branches) then
        return 
      end
      local output = ''
      output = output .. "Branches:\n"
      for _index_0 = 1, #branches do
        local branch = branches[_index_0]
        if branch.name == current then
          output = output .. "-> "
        else
          output = output .. "   "
        end
        output = output .. tostring(branch.name) .. " - rev:" .. tostring(branch.commit) .. "\n"
      end
      return send.list_branches(output)
    end,
    list_help = [[      Usage: %pub%.list
        List branches, and note the currently active branch
    ]],
    status = function(self, finfo)
      if not (finfo) then
        return send.status(errors.need_file)
      end
      if is_scratch(self.Buf) then
        return send.status(errors.no_scratch)
      end
      local cmd, err = new_command(finfo.dir)
      if not (cmd) then
        return send.status(err)
      end
      if not (cmd.in_repo()) then
        return send.status(errors.not_a_repo)
      end
      local status_out
      status_out, err = cmd.exec("status")
      if err then
        return send.status(err)
      end
      return send.status(status_out)
    end,
    status_help = [[      Usage: %pub%.status
        Show current status of the active repo
    ]],
    branch = (function()
      local re_valid_label = regexp.MustCompile("^[a-zA-Z-_/.]+$")
      return function(self, finfo, label)
        if not (finfo) then
          return send.branch(errors.need_file)
        end
        if is_scratch(self.Buf) then
          return send.branch(errors.no_scratch)
        end
        local cmd, err = new_command(finfo.dir)
        if not (cmd) then
          return send.branch(err)
        end
        if not (cmd.in_repo()) then
          return send.branch(errors.not_a_repo)
        end
        if not (re_valid_label:Match(label)) then
          return send.branch(errors.invalid_lbl)
        end
        do
          local rev = cmd.known_label(label)
          if rev then
            return send.branch(errors.invalid_arg .. ", please supply an unused label (" .. tostring(label) .. " is rev:" .. tostring(rev) .. ")")
          end
        end
        local branch_out
        branch_out, err = cmd.exec("branch", label)
        local out = "> git branch " .. tostring(label) .. "\n"
        out = out .. branch_out
        if not (err) then
          local chkout_out, _ = cmd.exec("checkout", label)
          out = out .. "> git checkout " .. tostring(label) .. "\n"
          out = out .. chkout_out
        end
        return send.branch(out)
      end
    end)(),
    branch_help = [[      Usage: %pub%.branch <label>
        Create a new local branch, and switch to it, also note that it performs a 
        git-fetch prior to making any changes.
    ]],
    commit = (function()
      local msg_line = regexp.MustCompile("^\\s*([^#])")
      local base_msg = "\n# Committing as:\n#   %name% - %email%\n#\n"
      base_msg = base_msg .. "# Please enter the commit message for your changes. Lines starting\n"
      base_msg = base_msg .. "# with '#' will be ignored, and an empty message aborts the commit.\n#\n"
      return function(self, finfo, msg)
        if not (finfo) then
          return send.commit(errors.need_file)
        end
        if is_scratch(self.Buf) then
          return send.commit(errors.no_scratch)
        end
        local cmd, err = new_command(finfo.dir)
        if not (cmd) then
          return send.commit(err)
        end
        if not (cmd.in_repo()) then
          return send.commit(errors.not_a_repo)
        end
        if msg then
          local commit_out
          commit_out, err = cmd.exec("commit", "-m", msg)
          if err then
            return send.commit(err)
          end
          return send.commit(commit_out)
        end
        local name
        name, err = cmd.exec("config", "user.name")
        if err then
          return send.commit(err)
        end
        local email
        email, err = cmd.exec("config", "user.email")
        if err then
          return send.commit(err)
        end
        local commit_msg_start = base_msg:gsub("%%name%%", chomp(name)):gsub("%%email%%", chomp(email))
        local status_out, _ = cmd.exec("status")
        each_line(chomp(status_out), function(line)
          commit_msg_start = commit_msg_start .. "# " .. tostring(line) .. "\n"
        end)
        add_callback("onQuit", function(pane, finfo)
          if not (#ACTIVE_COMMITS > 0) then
            return 
          end
          for i, commit in ipairs(ACTIVE_COMMITS) do
            local _continue_0 = false
            repeat
              do
                if not (commit.pane == pane) then
                  _continue_0 = true
                  break
                end
                if commit.ready then
                  commit.callback(pane.Buf, commit.file)
                  table.remove(ACTIVE_COMMITS, i)
                  return true
                end
                local info = app.InfoBar()
                if not (pane.Buf:Modified()) then
                  info:Message("Aborted commit (closed without saving)")
                  commit.callback(false)
                  os.Remove(commit.file)
                  table.remove(ACTIVE_COMMITS, i)
                  return 
                end
                if info.HasYN and info.HasPrompt then
                  info.YNCallback = function() end
                  info:AbortCommand()
                end
                info:YNPrompt("Would you like to save and commit? (y,n,esc)", function(yes, cancelled)
                  if cancelled then
                    return 
                  end
                  if not (yes) then
                    info:Message("Aborted commit (closed without saving)")
                    os.Remove(commit.file)
                    commit.callback(false)
                    pane:ForceQuit()
                  else
                    pane.Buf:Save()
                    pane:ForceQuit()
                    commit.callback(pane.Buf, commit.file)
                    os.Remove(commit.file)
                  end
                  for t, _temp in ipairs(ACTIVE_COMMITS) do
                    if _temp == commit then
                      table.remove(ACTIVE_COMMITS, t)
                      break
                    end
                  end
                end)
                return true
              end
              _continue_0 = true
            until true
            if not _continue_0 then
              break
            end
          end
        end)
        return make_commit_pane(self, cmd, commit_msg_start, function(buffer, file, _)
          if not (file) then
            return 
          end
          local commit_msg = ioutil.ReadFile(file)
          commit_msg = str.TrimSuffix(commit_msg, commit_msg_start)
          if commit_msg == "" then
            return send.commit("Aborting, empty commit")
          end
          local final_commit = ''
          each_line(chomp(commit_msg), function(line)
            if line == nil then
              return 
            end
            if msg_line:Match(line) then
              final_commit = final_commit .. tostring(line) .. "\n"
            end
          end)
          ioutil.WriteFile(file, final_commit, 0x1B0)
          if "" == chomp(final_commit) then
            return send.commit("Aborting, empty commit")
          end
          local commit_out
          commit_out, err = cmd.exec("commit", "-F", file)
          if err then
            return send.commit(err)
          end
          send.commit(commit_out)
          update_branch_status(buffer, finfo)
          return update_git_diff_base(buffer, finfo)
        end)
      end
    end)(),
    commit_help = [[      Usage: %pub%.commit [<commit message>]
        Begin a new commit. If a commit message is not provided, opens a new
        pane to enter the desired message into. Commit is initiated when the
        pane is saved and then closed.
    ]],
    push = (function()
      local re_valid_label = regexp.MustCompile("^[a-zA-Z-_/.]+$")
      return function(self, finfo, branch)
        if not (finfo) then
          return send.push(errors.need_file)
        end
        if is_scratch(self.Buf) then
          return send.push(errors.no_scratch)
        end
        local cmd, err = new_command(finfo.dir)
        if not (cmd) then
          return send.push(err)
        end
        if not (cmd.in_repo()) then
          return send.push(errors.not_a_repo)
        end
        if branch ~= nil then
          if not (re_valid_label:Match(branch)) then
            return send.push(errors.bad_label_arg)
          end
        else
          branch = "--all"
        end
        local _
        _, err = cmd.exec_async(self, "push", branch)
        if err then
          return send.push(err)
        end
      end
    end)(),
    push_help = [[      Usage: %pub%.push [<label>]
        Push local changes onto remote. A branch label is optional, and limits
        the scope of the push to the provided branch. Otherwise, all changes
        are pushed.
    ]],
    pull = function(self, finfo)
      if not (finfo) then
        return send.pull(errors.need_file)
      end
      if is_scratch(self.Buf) then
        return send.pull(errors.no_scratch)
      end
      local cmd, err = new_command(finfo.dir)
      if not (cmd) then
        return send.pull(err)
      end
      if not (cmd.in_repo()) then
        return send.pull(errors.not_a_repo)
      end
      local _
      _, err = cmd.exec_async(self, "pull")
      if err then
        return send.pull(err)
      end
    end,
    pull_help = [[      Usage: %pub%.pull
        Pull all changes from remote into the working tree
    ]],
    log = function(self, finfo)
      if not (finfo) then
        return send.log(errors.need_file)
      end
      if is_scratch(self.Buf) then
        return send.log(errors.no_scratch)
      end
      local cmd, err = new_command(finfo.dir)
      if not (cmd) then
        return send.log(err)
      end
      if not (cmd.in_repo()) then
        return send.log(errors.not_a_repo)
      end
      local count = 0
      local out
      out, err = cmd.exec("log")
      if err then
        return send.log
      end
      each_line(chomp(out), function(line)
        if re_commit:MatchString(line) then
          count = count + 1
        end
      end)
      return send.log(out, {
        header = tostring(count) .. " " .. tostring(w_commit(count))
      })
    end,
    log_help = [[      Usage: %pub%.log
        Show the commit log
    ]],
    stage = function(self, finfo, ...)
      if not (finfo) then
        return send.stage(errors.need_file)
      end
      if is_scratch(self.Buf) then
        return send.stage(errors.no_scratch)
      end
      local cmd, err = new_command(finfo.dir)
      if not (cmd) then
        return send.stage(err)
      end
      if not (cmd.in_repo()) then
        return send.stage(errors.not_a_repo)
      end
      local files = { }
      local _list_0 = {
        ...
      }
      for _index_0 = 1, #_list_0 do
        local _continue_0 = false
        repeat
          local file = _list_0[_index_0]
          if file == ".." then
            _continue_0 = true
            break
          end
          if file == "--all" or file == "-a" then
            files = {
              "."
            }
            break
          end
          file, err = replace_home(file)
          if err then
            return send.stage(err)
          end
          if not (path_exists(file) or path_exists(cmd.top_level() .. PATHSEP .. file)) then
            return send.stage(errors.invalid_arg .. ", file " .. tostring(file) .. " doesn't exist")
          end
          table.insert(files, file)
          _continue_0 = true
        until true
        if not _continue_0 then
          break
        end
      end
      if not (#files > 0) then
        return send.stage(errors.not_enough_args .. ", please supply a file")
      end
      return cmd.exec("add", unpack(files))
    end,
    stage_help = [[      Usage: %pub%.stage [<file1>, <file2>, ...] [<options>]
        Stage a file (or files) to commit.

      Options:
        -a --all   Stage all files
    ]],
    unstage = function(self, finfo, ...)
      if not (finfo) then
        return send.unstage(errors.need_file)
      end
      if is_scratch(self.Buf) then
        return send.unstage(errors.no_scratch)
      end
      local cmd, err = new_command(finfo.dir)
      if not (cmd) then
        return send.unstage(err)
      end
      if not (cmd.in_repo()) then
        return send.unstage(errors.not_a_repo)
      end
      local files = { }
      local all = false
      local _list_0 = {
        ...
      }
      for _index_0 = 1, #_list_0 do
        local _continue_0 = false
        repeat
          local file = _list_0[_index_0]
          if file == ".." then
            _continue_0 = true
            break
          end
          if file == "--all" or file == "-a" then
            files = { }
            all = true
            break
          end
          file, err = replace_home(file)
          if err then
            return send.unstage(err)
          end
          if not (path_exists(file) or path_exists(cmd.top_level() .. PATHSEP .. file)) then
            return send.unstage(errors.invalid_arg .. "(file " .. tostring(file) .. " doesn't exist)")
          end
          table.insert(files, file)
          _continue_0 = true
        until true
        if not _continue_0 then
          break
        end
      end
      if not ((#files > 0) or all) then
        return send.unstage(errors.not_enough_args .. ", please supply a file")
      end
      return cmd.exec("reset", "--", unpack(files))
    end,
    unstage_help = [[      Usage: %pub%.unstage [<file1>, <file2>, ...] [<options>]
        Unstage a file (or files) to commit.

      Options:
        -a --all   Unstage all files
    ]],
    rm = function(self, finfo, ...)
      if not (finfo) then
        return send.rm(errors.need_file)
      end
      if is_scratch(self.Buf) then
        return send.rm(errors.no_scratch)
      end
      local cmd, err = new_command(finfo.dir)
      if not (cmd) then
        return send.rm(err)
      end
      if not (cmd.in_repo()) then
        return send.add(errors.not_a_repo)
      end
      local files = { }
      local _list_0 = {
        ...
      }
      for _index_0 = 1, #_list_0 do
        local _continue_0 = false
        repeat
          local file = _list_0[_index_0]
          if file == ".." then
            _continue_0 = true
            break
          end
          if file == "." then
            files = {
              "."
            }
            break
          end
          file, err = replace_home(file)
          if err then
            return send.rm(err)
          end
          if not (path_exists(file)) then
            return send.rm(errors.invalid_arg .. "(file " .. tostring(file) .. " doesn't exist)")
          end
          table.insert(files, file)
          _continue_0 = true
        until true
        if not _continue_0 then
          break
        end
      end
      if not (#files > 0) then
        return send.rm(errors.not_enough_args .. ", please supply a file")
      end
      return cmd.exec("rm", unpack(files))
    end,
    rm_help = [[      Usage: %pub%.rm [<file1>, <file2>, ...]
        Stage the removal of a file (or files) from the git repo.
    ]],
    debug = function(self, finfo, ...)
      if not (finfo) then
        return send.debug(errors.need_file)
      end
      local debug_output = ''
      local cmd, err = new_command(finfo.dir)
      if not (cmd) then
        return send.debug(err)
      end
      local _, branch = cmd.get_branches()
      if not (branch) then
        branch = "Error"
      end
      debug_output = debug_output .. "File: " .. tostring(finfo.abs) .. "\n"
      debug_output = debug_output .. "Name: " .. tostring(finfo.name) .. "\n"
      debug_output = debug_output .. "PWD: " .. tostring(finfo.pwd) .. "\n"
      debug_output = debug_output .. "Directory: " .. tostring(finfo.dir) .. "\n"
      debug_output = debug_output .. "Absolute Path: " .. tostring(finfo.abs) .. "\n"
      debug_output = debug_output .. "In Repo: " .. tostring(cmd.in_repo() or false) .. "\n"
      debug_output = debug_output .. "Branch: " .. tostring(branch) .. "\n"
      debug_output = debug_output .. "\n"
      debug_output = debug_output .. "_G.ACTIVE_UPDATES\n"
      for k, v in pairs(ACTIVE_UPDATES) do
        debug_output = debug_output .. "  Updating Diff: " .. tostring(k) .. ": " .. tostring(v) .. "\n"
      end
      debug_output = debug_output .. "_G.ACTIVE_COMMITS\n"
      for k, v in pairs(ACTIVE_COMMITS) do
        debug_output = debug_output .. "  Active Commits: " .. tostring(k) .. ": " .. tostring(v) .. "\n"
      end
      debug_output = debug_output .. "_G.BUFFER_REPO\n"
      for k, v in pairs(BUFFER_REPO) do
        debug_output = debug_output .. "  File: " .. tostring(k) .. "\n"
        debug_output = debug_output .. "    " .. tostring(v.repoid) .. "\n"
        debug_output = debug_output .. "    " .. tostring(v.branch) .. "\n"
      end
      debug_output = debug_output .. "_G.REPO_STATUS\n"
      for k, v in pairs(REPO_STATUS) do
        debug_output = debug_output .. "  Repo: " .. tostring(k) .. "\n"
        for b, data in pairs(REPO_STATUS[k]) do
          debug_output = debug_output .. "    Branch: " .. tostring(b) .. "\n"
          debug_output = debug_output .. "      a:" .. tostring(data.ahead) .. ", b:" .. tostring(data.behind) .. ", "
          debug_output = debug_output .. "c:" .. tostring(data.commit) .. ", s:" .. tostring(data.staged) .. "\n"
        end
      end
      debug_output = debug_output .. "_G.CALLBACKS_SET\n"
      for k, v in pairs(CALLBACKS_SET) do
        for cb, fn in pairs(CALLBACKS_SET[k]) do
          debug_output = debug_output .. "  " .. tostring(k) .. ": " .. tostring(fn) .. "\n"
        end
      end
      debug_output = debug_output .. "_M: " .. tostring(_M or 'none') .. "\n"
      debug_output = debug_output .. "_G\n"
      for k, v in pairs(_G) do
        debug_output = debug_output .. "  " .. tostring(k) .. ": " .. tostring(v) .. "\n"
        if k == _M._NAME then
          for k2, v2 in pairs(_G[k]) do
            debug_output = debug_output .. "    " .. tostring(k2) .. ": " .. tostring(v2) .. "\n"
          end
        end
      end
      return send.debug(debug_output)
    end,
    debug_help = [[      Usage: %pub%.debug
        Dumps plugin operational data for easy viewing
    ]]
  }
end)()
numahead = function(self)
  if not (GITLINE_ACTIVE) then
    return "-"
  end
  local abs = get_path_info(self.Path)
  if not (abs and BUFFER_REPO[abs] and BUFFER_REPO[abs].branch_ptr) then
    return "-"
  end
  return tostring(BUFFER_REPO[abs].branch_ptr.ahead or "-")
end
numbehind = function(self)
  if not (GITLINE_ACTIVE) then
    return "-"
  end
  local abs = get_path_info(self.Path)
  if not (abs and BUFFER_REPO[abs] and BUFFER_REPO[abs].branch_ptr) then
    return "-"
  end
  return tostring(BUFFER_REPO[abs].branch_ptr.behind or "-")
end
numstaged = function(self)
  if not (GITLINE_ACTIVE) then
    return "-"
  end
  local abs = get_path_info(self.Path)
  if not (abs and BUFFER_REPO[abs] and BUFFER_REPO[abs].branch_ptr) then
    return "-"
  end
  return tostring(BUFFER_REPO[abs].branch_ptr.staged or "-")
end
oncommit = function(self)
  if not (GITLINE_ACTIVE) then
    return "-"
  end
  local abs = get_path_info(self.Path)
  if not (abs and BUFFER_REPO[abs] and BUFFER_REPO[abs].branch_ptr) then
    return "-"
  end
  return tostring(BUFFER_REPO[abs].branch_ptr.commit or "-")
end
onbranch = function(self)
  if not (GITLINE_ACTIVE) then
    return "-"
  end
  local abs = get_path_info(self.Path)
  if not (abs and BUFFER_REPO[abs] and BUFFER_REPO[abs].branch_ptr) then
    return "-"
  end
  return tostring(BUFFER_REPO[abs].branch_ptr.display or "-")
end
preinit = function()
  add_config("command", "", [[    The absolute path to the command to use for git operations (type: string) 
  ]])
  add_config("updateinfo", true, [[    Update tracked branch information during select callbacks (type: boolean)

    Note: Required for statusline
  ]])
  add_config("gitgutter", true, [[    Enable or disable updating the diff gutter with git changes (type: boolean)

    Note: To use this, ensure the diff plugin is installed and diffgutter enabled!
  ]])
  add_config("cleanstale", true, [[    Enable or disable whether this plugin deletes it's old tempfiles on startup (type: boolean)
  ]])
  add_statusinfo("numahead", numahead, [[    The number of commits ahead of your branches origin (type: number)
  ]])
  add_statusinfo("numbehind", numbehind, [[    The number of commits behind of origin your branches tree is (type: number)
  ]])
  add_statusinfo("numstaged", numstaged, [[    The number of files staged in the local branch (type: number)
  ]])
  add_statusinfo("onbranch", onbranch, [[    The current branch of a pane
  ]])
  add_statusinfo("oncommit", oncommit, [[    The latest commit short hash
  ]])
  if truthy(cfg.GetGlobalOption(tostring(NAME) .. ".cleanstale")) then
    debug("Clearing stale temporary files ...")
    local pfx = tostring(NAME) .. "."
    local dir = path.Join(tostring(cfg.ConfigDir), "tmp")
    local files, err = ioutil.ReadDir(dir)
    if not (err) then
      for _index_0 = 1, #files do
        local f = files[_index_0]
        debug("Does " .. tostring(f:Name()) .. " have the prefix " .. tostring(pfx) .. "?")
        if str.HasPrefix(f:Name(), pfx) then
          local filepath = path.Join(dir, f:Name())
          debug("Clearing " .. tostring(filepath))
          os.Remove(filepath)
        end
      end
    end
  end
end
init = function()
  debug("Initializing " .. tostring(NAME))
  local cmd = tostring(cfg.GetGlobalOption(tostring(NAME) .. ".command"))
  if cmd == "" then
    local _
    cmd, _ = shl.ExecCommand("command", "-v", "git")
    if cmd == '' or not cmd then
      app.TermMessage(tostring(NAME) .. ": git not present in $PATH or set, plugin will not work correctly")
    else
      cfg.SetGlobalOption(tostring(NAME) .. ".command", chomp(cmd))
    end
  end
  add_command("init", git.init, {
    callbacks = {
      git.update_branch_status,
      git.update_git_diff_base
    }
  })
  add_command("pull", git.pull, {
    completer = git.branch_complete,
    callbacks = {
      git.update_branch_status,
      git.update_git_diff_base
    }
  })
  add_command("push", git.push, {
    completer = git.branch_complete,
    callbacks = {
      git.update_branch_status,
      git.update_git_diff_base
    }
  })
  add_command("branch", git.branch, {
    callbacks = {
      git.update_branch_status,
      git.update_git_diff_base
    }
  })
  add_command("fetch", git.fetch, {
    completer = git.branch_complete,
    callbacks = {
      git.update_branch_status,
      git.update_git_diff_base
    }
  })
  add_command("checkout", git.checkout, {
    completer = git.branch_complete,
    callbacks = {
      git.update_branch_status,
      git.update_git_diff_base
    }
  })
  add_command("stage", git.stage, {
    completer = git.repo_complete,
    callbacks = {
      git.update_branch_status,
      git.update_git_diff_base
    }
  })
  add_command("unstage", git.unstage, {
    completer = git.repo_complete,
    callbacks = {
      git.update_branch_status,
      git.update_git_diff_base
    }
  })
  add_command("rm", git.rm, {
    completer = git.repo_complete,
    callbacks = {
      git.update_branch_status,
      git.update_git_diff_base
    }
  })
  if os.Getenv("MICROGIT_DEBUG") == "1" then
    add_command("debug", git.debug, {
      callbacks = {
        git.update_branch_status,
        git.update_git_diff_base
      }
    })
  end
  add_command("commit", git.commit)
  add_command("list", git.list)
  add_command("log", git.log)
  add_command("status", git.status)
  add_command("diff", git.diff)
  return generate_help()
end
onBufPaneOpen = function(self)
  debug("Caught onBufPaneOpen bufpane:" .. tostring(self))
  local _finfo
  local abs, dir, name, pwd = get_path_info(self.Buf.Path)
  if pwd then
    _finfo = {
      dir = dir,
      abs = abs,
      name = name,
      pwd = pwd
    }
  end
  git.update_branch_status(self.Buf, _finfo)
  git.update_git_diff_base(self.Buf, _finfo)
end
onSave = function(self)
  local _finfo
  local abs, dir, name, pwd = get_path_info(self.Buf.Path)
  if pwd then
    _finfo = {
      dir = dir,
      abs = abs,
      name = name,
      pwd = pwd
    }
  end
  git.update_branch_status(self.Buf, _finfo)
  git.update_git_diff_base(self.Buf, _finfo)
  if not (#ACTIVE_COMMITS > 0) then
    return 
  end
  for i, commit in ipairs(ACTIVE_COMMITS) do
    if commit.pane == self then
      debug("Marking commit " .. tostring(i) .. " as ready ...")
      commit.ready = true
      break
    end
  end
end
onQuit = function(self)
  local abs, parent, name, pwd = get_path_info(self.Path)
  if abs and BUFFER_REPO[abs] then
    BUFFER_REPO[abs] = nil
  end
  return run_callbacks("onQuit", self, {
    abs = abs,
    pwd = pwd,
    name = name,
    dir = parent
  })
end
