# frozen_string_literal: true

require_relative "huawei_cli/connection"
require_relative "huawei_cli/login"
require_relative "huawei_cli/version"

require_relative "huawei_cli/cmd/ping"
require_relative "huawei_cli/cmd/signal"

module HuaweiCli
  class Error < StandardError; end

  cnx = Connection.new(ENV['H_HOST'])
end
