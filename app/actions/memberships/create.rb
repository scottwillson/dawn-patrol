module Memberships
  class Create
    def initialize(attributes = {})
      @attributes = attributes
    end

    def do_it!
      Memberships::New.new(@attributes).do_it!.save!
    end
  end
end
