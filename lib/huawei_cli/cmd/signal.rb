module HuaweiCli
  module Cmd
    class Signal
      PATH = '/api/'
      NEED_SESSION = true
      def initialize(connection)
        @connection = connection
      end

      def run
        @connection.get('')
      end

    end
  end
end
