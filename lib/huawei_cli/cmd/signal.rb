module HuaweiCli
  module Cmd
    class Signal
      def initialize(connection)
        @connection = connection
      end

      def run
        puts "POUET"
      end
    end
  end
end
