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
      @http ||= begin
        ctx = OpenSSL::SSL::SSLContext.new
        ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
        HTTP.persistent(@host, ssl_context: ctx)
      end
    end

    def close
      @http.close if @http
      @http = nil
    end

  end
end
