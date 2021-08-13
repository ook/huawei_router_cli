module HuaweiCli
  module Cmd
    class Signal
      PATH = '/api/'
      NEED_SESSION = true
      def initialize(connection)
        @connection = connection
      end

      def run
        loop do
          response = @connection.get('/api/device/signal')
          @connection.followup_header(response)
          # puts "\e[H\e[2J"
          puts response.to_s
          Ping.new(@connection).run
          sleep(5)
          puts
        end
      end

    end
  end
end
