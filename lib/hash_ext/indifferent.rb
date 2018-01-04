class Hash
  class Indifferent < Normalized

    def initialize(hash={})
      super hash
    end

    private

    def normalize_key(key)
      key.to_sym
    end

  end
end