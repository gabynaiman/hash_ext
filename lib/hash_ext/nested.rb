class Hash
  class Nested < Hash

    include DeepFreezable

    def [](key)
      if key? key
        super(key)
      else
        self[key] = Nested.new
      end
    end

  end
end