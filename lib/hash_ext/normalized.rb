class Hash
  class Normalized < Hash

    include DeepFreezable

    def self.subclass(&block)
      Class.new(self) do
        define_method :initialize do |hash={}|
          super hash, &block
        end
      end
    end

    def initialize(hash={}, &block)
      @normalization_block = block
      update hash
    end

    def [](key)
      super normalize_key(key)
    end

    def []=(key, value)
      super normalize_key(key), normalize_value(value)
    end
    alias_method :store, :[]=

    def delete(key)
      super normalize_key(key)
    end

    def update(hash, &block)
      hash.each do |key, value|
        new_val = block && key?(key) ? block.call(key, self[key], value) : value
        store key, new_val
      end
      self
    end
    alias_method :merge!, :update

    def merge(hash, &block)
      dup.update hash, &block
    end

    def key?(key)
      super normalize_key(key)
    end
    alias_method :include?, :key?
    alias_method :has_key?, :key?
    alias_method :member?, :key?

    def fetch(key, *args, &block)
      super normalize_key(key), *args, &block
    end

    def dig(*keys)
      normalized_keys = keys.map { |k| normalize_key(k) }
      normalized_keys.inject(self) do |target, key|
        target ? target[key] : nil
      end
    end

    def to_h
      each_with_object({}) do |(key, value), hash|
        hash[key] = value_to_h value
      end
    end

    private

    def normalize_key(key)
      @normalization_block.call key
    end

    def normalize_value(value)
      if value.is_a? self.class
        value
      elsif value.kind_of? Hash
        self.class.new value, &@normalization_block
      elsif value.kind_of? Array
        value.map { |v| normalize_value v }
      else
        value
      end
    end

    def value_to_h(value)
      if value.kind_of? Hash
        value.to_h
      elsif value.kind_of? Array
        value.map { |v| value_to_h v }
      else
        value
      end
    end

  end
end