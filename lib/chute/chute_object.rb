module Chute
  class ChuteObject
    attr_accessor :data

    class << self
      def parse(object)
        case object
        when Array
          object.collect do |_obj|
            ChuteObject.parse(_obj)
          end
        when Hash
          chute_object = ChuteObject.new
          chute_object.data = object

          object.collect do |key, value|
            chute_object.data = object

            unless chute_object.respond_to?(:key)
              chute_object.class.send(:define_method, key) do
                ChuteObject.parse(data[key])
              end
            end
          end

          chute_object
        else
          object
        end
      end
    end

    def to_param
      id.to_s
    end

    def as_json(options = {})
      data
    end
  end
end
