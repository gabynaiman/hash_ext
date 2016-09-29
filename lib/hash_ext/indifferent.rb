class Hash
  Indifferent = Normalized.subclass { |key| key.kind_of?(String) ? key.to_sym : key }
end