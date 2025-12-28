{
  lib,
  config,
  ...
}: {
  options.my.nextcloud.enable = lib.mkEnableOption "nextcloud";
  config = lib.mkIf config.my.nextcloud.enable {
    environment.etc."nextcloud-admin-pass".text = "password123";
    services.paperless = {
      # user = "${homelab_user}";
      enable = true;
      settings = {
        PAPERLESS_OCR_LANGUAGES = "deu+eng";
        PAPERLESS_SECRET_KEY = "<redacted>";
        PAPERLESS_TIME_ZONE = "Europe/Berlin";
        PAPERLESS_OCR_LANGUAGE = "deu";
        PAPERLESS_ACCOUNT_SESSION_REMEMBER = "True";
        PAPERLESS_FILENAME_FORMAT = "{{ created_year }}/{{ doc_pk }}_{{ title }}";
        PAPERLESS_CONSUMER_POLLING = 300;
        # Nginx configuration
        # PAPERLESS_URL = "https://${config.networking.hostName}.${tailnet-name}";
        USE_X_FORWARD_HOST = true;
        USE_X_FORWARD_PORT = true;
        PAPERLESS_PROXY_SSL_HEADER = ["HTTP_X_FORWARDED_PROTO" "https"];
        PAPERLESS_FORCE_SCRIPT_NAME = "/paperless";
      };
      exporter = {
        enable = true;
        directory = "/mnt/backups/paperless";
        onCalendar = "weekly";
      };
    };
  };
}
