module Berg
  class Key
    def initialize(&block)
      @block = block
    end

    def self.locate(object, &block)
      new(&block).locate(object, "").query
    end

    def locate(object, current)
      case object
      when Array
        object.each_with_index do |rest, index|
          if (result = locate(rest, current + "[#{index}]")).found?
            return result
          end
        end
      when Hash
        object.each_pair do |key, value|
          if (result = locate(value, current + ".#{key}")).found?
            return result
          end
        end
      when TrueClass, FalseClass, NilClass, Fixnum, String
        return @block.call(object) ? Found.new(current) : NotFound.new
      when Found, NotFound
        return object
      else
        raise "Type #{object.class} not supported"
      end

      return NotFound.new
    end
  end
end