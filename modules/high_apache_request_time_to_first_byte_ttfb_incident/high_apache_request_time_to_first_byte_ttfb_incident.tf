resource "shoreline_notebook" "high_apache_request_time_to_first_byte_ttfb_incident" {
  name       = "high_apache_request_time_to_first_byte_ttfb_incident"
  data       = file("${path.module}/data/high_apache_request_time_to_first_byte_ttfb_incident.json")
  depends_on = [shoreline_action.invoke_apache_config_update]
}

resource "shoreline_file" "apache_config_update" {
  name             = "apache_config_update"
  input_file       = "${path.module}/data/apache_config_update.sh"
  md5              = filemd5("${path.module}/data/apache_config_update.sh")
  description      = "Optimize Apache server configuration: This can involve tweaking settings such as the number of worker threads or processes, adjusting the KeepAliveTimeout value, and increasing the number of concurrent requests that the server can handle."
  destination_path = "/agent/scripts/apache_config_update.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_apache_config_update" {
  name        = "invoke_apache_config_update"
  description = "Optimize Apache server configuration: This can involve tweaking settings such as the number of worker threads or processes, adjusting the KeepAliveTimeout value, and increasing the number of concurrent requests that the server can handle."
  command     = "`chmod +x /agent/scripts/apache_config_update.sh && /agent/scripts/apache_config_update.sh`"
  params      = ["NEW_VALUE","OLD_VALUE"]
  file_deps   = ["apache_config_update"]
  enabled     = true
  depends_on  = [shoreline_file.apache_config_update]
}

