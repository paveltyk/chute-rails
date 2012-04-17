module Chute
  class Parcels < ChuteObject
    class << self
      def create(data)
        Request.post("/parcels", data)
      end

      def find(id)
        Request.get("/parcels/#{id}")
      end

      def complete(id)
        Request.post("/parcels/#{id}/complete")
      end
    end
  end
end
