module Berg
  class Key
    include Berg::Base

    def initialize(&block)
      @block = block
    end

    def self.locate(object, &block)
      new(&block).locate(object)
    end

    def locate(object, trace = "")
      case object
      when Array
        object.each_with_index do |rest, index|
          if (result = locate(rest, add(trace, "[#{index}]"))).found?
            return result
          end
        end
      when Hash
        object.each_pair do |key, value|
          if (result = locate(value, add(trace, key))).found?
            return result
          end
        end
      when TrueClass, FalseClass, NilClass, Fixnum, String
        return @block.call(object) ? Found.new(trace) : NotFound.new
      when Found, NotFound
        return object
      else
        raise "Type #{object.class} not supported"
      end

      return NotFound.new
    end
  end
end