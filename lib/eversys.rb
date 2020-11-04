require "net/http"
require "json"

require "eversys/base"
require "eversys/client"
require "eversys/machine"
require "eversys/request_builder"
require "eversys/response/response_handler"
require "eversys/version"

module Eversys
  API_VERSION = "v3"
  API_HOST = "https://api.eversys-telemetry.com/"
end
