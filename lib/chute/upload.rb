module Chute
  class Uploads < ChuteObject
    class << self
      def generate_token(id)
        Request.get("/uploads/#{id}/token")
      end

      def complete(id)
        Request.post("/uploads/#{id}/complete")
      end
    end
  end
end
