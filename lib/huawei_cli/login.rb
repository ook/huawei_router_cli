require 'base64'
require 'digest'

module HuaweiCli
  # Login translated from https://github.com/aalteirac/router_monitor/blob/master/b715_api.js
  class Login
    def initialize(connection)
      @connection = connection
    end

    def run(user: 'admin', password:)
      raise "Missing password" if password.nil?
      # salted_password = hash_256_b64(user + hash_256_b64(password) + token)
      @connection.populateHeaders(ses_tok_info)
      salted_password = hash_256_b64(user + hash_256_b64(password) + @connection.token)
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><request><Username>#{user}</Username><password_type>4</password_type><Password>#{salted_password}</Password></request>"

      response = @connection.post('/api/user/login', need_connection: false, body: body)
      raw_body = response.body.to_s
      @connection.followup_header(response)
    end

    def ses_tok_info
      response = @connection.get('/api/webserver/SesTokInfo', need_connection: false).flush
      raw_body = response.body.to_s
      m = raw_body.match(/TokInfo>(?<token>[^<]+)<\/TokInfo><SesInfo>(?<sessInfo>[^<]+)<\/SesInfo>/)
      { token: m[:token], sessInfo: m[:sessInfo] }
    end

    def hash_256_b64(text)
      Base64.strict_encode64(Digest::SHA256.hexdigest(text))
    end

  end
end
