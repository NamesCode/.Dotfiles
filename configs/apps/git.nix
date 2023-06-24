{...}: {
  programs.git = {
    enable = true;
    difftastic = {
      enable = true;
      background = "dark";
    };
    lfs.enable = true;
    userEmail = "lasagna@garfunkles.space";
    userName = "Name";
    extraConfig = {
      user.signingKey = "A0369D63ADECF4721D765B9797174968DAA9C254";
      commit.gpgSign = true;
      tag.gpgSign = true;
      pull.rebase = true;
      push = {
        autoSetupRemote = true;
        gpgSign = "if-asked";
      };
      init.defaultBranch = "main";
    };
  };
}
