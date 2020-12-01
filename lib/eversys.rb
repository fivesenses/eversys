require "net/http"
require "json"

require "eversys/base"
require "eversys/errors"
require "eversys/client"
require "eversys/machine"
require "eversys/product"
require "eversys/request_builder"
require "eversys/response/response_handler"
require "eversys/statistics"
require "eversys/version"

module Eversys
  API_VERSION = "v3"
  API_HOST = "https://api.eversys-telemetry.com/"
end
