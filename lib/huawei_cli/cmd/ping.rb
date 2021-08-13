module HuaweiCli
  module Cmd
    class Ping
      def initialize(connection)
        @connection = connection
      end

      def run(quiet: true)
        response = @connection.get('/api/user/state-login')
        puts "PING" unless quiet
        @connection.followup_header(response)
        puts response.to_s unless quiet
        puts unless quiet
        puts unless quiet
      end
    end
  end
end
