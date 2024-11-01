{
  config,
  pkgs,
  ...
}:
{
  # Configure mako
  services.mako = {
    enable = true;
    height = 30;
    width = 60;
    textColor = "cdd6f4";
    borderColor = "#f38ba8";
    backgroundColor = "#1e1e2e";
    layer = "overlay";
    sort = "+priority";
    font = "Courier";
    groupBy = "app-name";
  };
}
