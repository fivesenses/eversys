require "rubygems"
require "bundler"
require "test/unit"
require "mocha/test_unit"

require "simplecov"
require "simplecov-cobertura"

require "webmock"
require "webmock/test_unit"

SimpleCov.configure do
  add_filter %r{^/opt/hostedtoolcache/}
  load_profile "test_frameworks"
end

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::CoberturaFormatter
]

# Start SimpleCov before including the library
SimpleCov.start
require "eversys"

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems"
  exit e.status_code
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))

class Test::Unit::TestCase; end

def api_client
  Eversys::Client.new({
    api_host: "https://api.eversys-telemetry.com/",
    api_version: "v3",
    test_mode: true
  })
end

def fixture_path
  File.expand_path("fixtures", __dir__)
end

def stub_get(path)
  stub_request(:get, api_url(path))
end

def stub_post(path)
  stub_request(:post, api_url(path))
end

def stub_patch(path)
  stub_request(:patch, api_url(path))
end

def stub_delete(path)
  stub_request(:delete, api_url(path))
end

def fixture(file)
  File.new(fixture_path + "/" + file)
end

def api_url(url)
  "https://api.eversys-telemetry.com/v3/#{url}"
end

def stub_headers
  {
    "Accept" => "*/*",
    "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
    "Content-Type" => "application/json",
    "Host" => "api.eversys-telemetry.com",
    "User-Agent" => "Ruby"
  }
end
