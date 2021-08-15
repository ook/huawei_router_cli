module HuaweiCli
  module Cmd
    # Loop: fake command so we can iterate indefinitly on the next command
    class Loop
      def initialize(connection, opts)
        @connection = connection
        @opts = opts
        @cmd = fetch_cmd(@connection, @opts)
      end

      def run
        loop do
          @cmd.run
          Ping.new(@connection, nil).run
          sleep(5)
          puts
        end
      end
    end
  end
end
