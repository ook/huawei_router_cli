require 'http'

module HuaweiCli
  class Connection
    def initialize(host)
      @host = host
    end

    def get(path)
      raise 'implement me please'
    end

    def http
      @http ||= HTTP.persistent(@host)
    end
  end
end
