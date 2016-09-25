uri = URI.parse('redis://redistogo:a76eeb6adc6cc8d59c02ae539adcf9b4@viperfish.redistogo.com:11943/')
Redis.current = Redis.new(host: uri.host, port: uri.port, password: uri.password)
