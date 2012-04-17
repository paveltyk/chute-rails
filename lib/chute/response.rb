module Chute
  class Response < Object

    attr_accessor :code
    attr_accessor :data
    attr_accessor :meta
    attr_accessor :pagination
    attr_accessor :parent
    attr_accessor :errors

    class << self
      def new(data = nil)
        object = super()
        return object unless data

        object.code = data.response.code.to_i

        if object.success?
          if data.parsed_response
            object.data       = ChuteObject.parse(data.parsed_response['data'])
            object.data       = ChuteObject.parse(data.parsed_response['uploads'])    unless data.parsed_response['uploads'].blank?
            object.data       = ChuteObject.parse(data.parsed_response['asset'])      unless data.parsed_response['asset'].blank?
            object.data       = ChuteObject.parse(data.parsed_response)               if data.parsed_response['signature'].present?

            object.meta       = ChuteObject.parse(data.parsed_response['meta'])       unless data.parsed_response['meta'].blank?
            object.pagination = ChuteObject.parse(data.parsed_response['pagination']) unless data.parsed_response['pagination'].blank?
            object.parent     = ChuteObject.parse(data.parsed_response['parent'])     unless data.parsed_response['parent'].blank?
          end
        else
          object.errors = data.parsed_response['errors']
        end

        object
      end

      def with_code_and_error(code, error)
        object        = Response.new
        object.code   = code
        object.errors = [error]
        object
      end
    end

    def success?
      [200, 201].include?(code)
    end

    def method_missing(meth, *args, &block)
      data.send(meth, *args, &block)
    end

  end
end
