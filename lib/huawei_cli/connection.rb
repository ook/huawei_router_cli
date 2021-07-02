require 'http'

module HuaweiCli
  class Connection
    def initialize(host)
      @host = host
    end

    def get(path)
      http.get(path)
    end

    def http
      @http ||= HTTP.persistent(@host)
    end

    def close
      @http.close if @http
      @http = nil
    end

  end
end
