class Hash
  class Nested < Hash

    def [](key)
      if key? key 
        super(key)
      else
        self[key] = Nested.new
      end
    end

  end
end