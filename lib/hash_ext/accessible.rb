class Hash
  class Accessible < Indifferent

    private

    def method_missing(method, *args, &block)
      if method.to_s.end_with? '='
        key = method[0..-2]
        self[key] = make_accessible args[0]
      else
        make_accessible self[method]
      end
    end

    def make_accessible(value)
      if value.kind_of? Hash
        self.class.new value
      elsif value.kind_of? Array
        value.map { |v| make_accessible v }
      else
        value
      end
    end

  end
end