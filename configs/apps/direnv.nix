{config, ...}: {
  programs.direnv = {
    enable = true;
    config = {
      global = {
        load_dotenv = true;
      };
      whitelist = {
        prefix = [
          "${config.home.homeDirectory}/src/backwardspy"
          "${config.home.homeDirectory}/src/binkhq"
        ];
      };
    };
  };
}
