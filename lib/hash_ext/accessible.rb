class Hash
  class Accessible < Indifferent

    def self.make_accessible(value)
      if value.kind_of? Hash
        self.new value
      elsif value.kind_of? ::Array
        Accessible::Array.new value
      else
        value
      end
    end

    class Array < SimpleDelegator

      def initialize(array)
        super array.map { |v| Accessible.make_accessible v }
      end

      def push(value)
        super Accessible.make_accessible(value)
      end
      alias_method :<<, :push

    end

    def []=(key, value)
      super key, Accessible.make_accessible(value)
    end

    private

    def method_missing(method, *args, &block)
      if method.to_s.end_with? '='
        key = method[0..-2]
        self[key] = args[0]
      else
        self[method]
      end
    end

  end
end