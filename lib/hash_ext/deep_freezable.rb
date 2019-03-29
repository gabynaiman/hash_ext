class Hash
  module DeepFreezable

    def deep_freeze
      each_value { |v| deep_freeze_value v }
      freeze
    end

    def deep_freeze_value(value)
      if value.respond_to? :deep_freeze
        value.deep_freeze
      else
        if value.is_a? Hash
          value.each_value { |v| deep_freeze_value v }
        elsif value.respond_to? :each
          value.each { |v| deep_freeze_value v }
        end
        value.freeze
      end
    end

    private :deep_freeze_value

  end
end