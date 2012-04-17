module Chute
  class Request
    class << self
      ['get', 'post', 'put', 'delete'].each do |request_method|
        define_method(request_method) do |url, data = {}|
          Connection.request(request_method, url, data)
        end
      end
    end
  end
end
