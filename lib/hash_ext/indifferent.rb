class Hash
  class Indifferent < Normalized

    def initialize(hash={})
      super hash
    end

    private

    def normalize_key(key)
      key.kind_of?(String) ? key.to_sym : key
    end

  end
end