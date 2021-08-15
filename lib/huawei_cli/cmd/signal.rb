module HuaweiCli
  module Cmd
    class Signal
      PATH = '/api/'
      NEED_SESSION = true
      def initialize(connection, _opts)
        @connection = connection
      end

      def run
        response = @connection.get('/api/device/signal')
        @connection.followup_header(response)
        puts response.to_s
      end

    end
  end
end
