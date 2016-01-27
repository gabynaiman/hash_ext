class Hash
  class Sorted

    extend Forwardable
    include Enumerable

    def_delegators :@hash, :[], :[]=, :value?, :fetch, :values_at,
                           :key?, :include?, :empty?,
                           :delete, :delete_if, :clear, 
                           :merge, :merge!, :update, :store, :replace,
                           :count, :size, :length,
                           :==, :eql, :hash
    
    def_delegators :to_h, :to_a, :to_s, :inspect, 
                          :select, :reject, :flatten,
                          :as_json, :to_json

    def initialize(hash={}, direction=:asc, &sort_criteria)
      @hash = hash
      @direction = direction
      @sort_criteria = sort_criteria
    end

    def keys
      sorted_keys = @hash.sort_by(&sort_criteria).map { |k,v| k }
      direction == :asc ? sorted_keys : sorted_keys.reverse
    end

    def values
      keys.map { |k| self[k] }
    end

    def each
      return enum_for(:each) unless block_given?
      keys.each { |k| yield k, self[k]}
    end
    alias_method :each_pair, :each

    def each_key
      return enum_for(:each_key) unless block_given?
      keys.each { |k| yield k }
    end

    def each_value
      return enum_for(:each_value) unless block_given?
      keys.each { |k| yield self[k] }
    end

    def to_h
      each_with_object({}) { |(k,v),h| h[k] = v }
    end

    private

    attr_reader :direction, :sort_criteria

    class << self
    
      def ascending(hash={}, &sort_criteria)
        new hash, :asc, &sort_criteria
      end
      alias_method :asc, :ascending

      def descending(hash={}, &sort_criteria)
        new hash, :desc, &sort_criteria
      end
      alias_method :desc, :descending

      private :new

    end

  end
end