class Hash
  class Builder
    
    def initialize
      @hash = {}
      @scopes = []
    end

    def build
      yield self
      @hash
    end

    def method_missing(method, *args, &block)
      if block
        @scopes.push method
        block.call
        @scopes.pop
      else
        current_scope = @scopes.inject(@hash) { |h,s| h[s] ||= {} }
        current_scope[method] = args.first
      end
    end

    def self.build(&block)
      new.build(&block)
    end

  end
end