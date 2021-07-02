module HuaweiCli
  class Login
    def initialize(connection)
      @connection = connection
    end

    def run
      csrf_token
    end

    def csrf_token
      doc = http.get('/html/index.html') 
      puts doc.inspect
    end
  end
end
