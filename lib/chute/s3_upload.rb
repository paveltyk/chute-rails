require 'httparty'

module Chute
  class S3Upload
    include HTTParty
    format :json

    attr_accessor :date
    attr_accessor :signature
    attr_accessor :content_type
    attr_accessor :md5
    attr_accessor :upload_url
    attr_accessor :file_path

    def initialize(options)
      %w{date signature content_type md5 upload_url file_path}.each do |attribute|
        send("#{attribute}=", options.send(attribute))
      end
    end

    def upload
      file = File.open(file_path, 'r')
      response = self.class.put(upload_url, body: file.read, headers: headers)
      file.close

      response
    end

    def headers
      { 'Date'           => date,
        'Authorization'  => signature,
        'Content-Type'   => content_type,
        'Content-Length' => md5,
        'x-amz-acl'      => 'public-read' }
    end
  end
end
