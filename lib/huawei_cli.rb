# frozen_string_literal: true

require_relative "huawei_cli/version"
require_relative "huawei_cli/connection"
require_relative "huawei_cli/login"

module HuaweiCli
  class Error < StandardError; end
  # Your code goes here...
  cnx = Connection.new(ENV['H_HOST'])

end
