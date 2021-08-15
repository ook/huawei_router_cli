require 'http'

module HuaweiCli
  class Connection
    attr_reader :token
    def initialize(host)
      @host = host

      @connected = false
    end

    def populateHeaders(token:, sessInfo:)
      @token = token
      @sessInfo = sessInfo

      @headers = { '__RequestVerificationToken': @token }
      @cookies = { 'Cookie': "SessionID=#{@sessInfo};SessionID=#{@sessInfo}" }
    end

    def followup_header(response)
      @token = response.headers["__RequestVerificationTokenone"] if response.headers["__RequestVerificationTokenone"]

      response.cookies.each do |e|
        if e.name == 'SessionID'
          @cookies = { 'Cookie': "SessionID=#{e.value};SessionID=#{e.value}" }
          break
        end
      end
    end

    def get(path, need_connection: true)
      if need_connection && !@connected
        Login.new(self).run(password: ENV["HC_PASSWORD"])
        @connected = true
      end
      req = http
      req = req.cookies(@cookies) if @cookies
      req = req.headers(@headers) if @headers

      # Huawei is totally broken, just can't verify it
      req.get(path, ssl_context: ssl_verify_none_ctx)
    end

    def post(path, need_connection: true, body: nil)
      if need_connection && !@connected
        Login.new(self).run(password: ENV["HC_PASSWORD"])
        @connected = true
      end
      req = http.headers('content-type':'text/xml' )
      req = req.cookies(@cookies) if @cookies
      req = req.headers("__RequestVerificationToken" => @token) if @token
      req.post(path, ssl_context: ssl_verify_none_ctx, body: body)
    end

    def ssl_verify_none_ctx
      @ssl_verify_none_ctx ||= OpenSSL::SSL::SSLContext.new.tap {|c| c.verify_mode = OpenSSL::SSL::VERIFY_NONE }
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
