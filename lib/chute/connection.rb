require 'httparty'

module Chute
  class Connection
    include HTTParty
    format :json

    class << self
      def base_uri
        Chute.api_endpoint
      end

      def headers
        { 'Authorization' => Chute._authorization,
          'Content-Type'  => 'application/json',
          'Accepts'       => 'application/json' }
      end

      def request(request_method, path, body = "")
        body        = JSON.unparse(body) unless body === String
        options     = body.blank? ? { headers: headers } : { headers: headers, body: body }
        request_url = [base_uri, path].join

        begin
          response = send(request_method, request_url, options)
          if Rails.env.development?
            Rails.logger.info "----------------------------------------"
            Rails.logger.info y "Request url: #{request_url}"
            Rails.logger.info y response.parsed_response
            Rails.logger.info "----------------------------------------"
          end
          parse(response)

        rescue Errno::ECONNREFUSED
          p 'Service Unavailable'
          raise ChuteApiUnavailableException.new('Could not connect to the Server')
          Response.with_code_and_error(503, 'Service Unavailable')

        rescue MultiJson::DecodeError
          p 'Internal Server Error'
          raise ChuteApiInternalException.new('Chute API Exception')
          Response.with_code_and_error(500, 'Internal Server Error')

        rescue Exception => ex
          p 'Unknown Error'
          raise
        end
      end

      def parse(object)
        Response.new(object)
      end
    end
  end

  class ChuteApiUnavailableException < Exception ; end
  class ChuteApiInternalException < Exception ; end
end
