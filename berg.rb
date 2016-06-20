require "json"
require "pp"

object = JSON.parse(File.read("data.json"))

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

  class Value
    # def initialize(object, query)
    #   @object = object
    #   @query = query
    # end

    ARRAY_ID = /\[(\d+)\]/

    def locate(object, query)
      latest = object
      query.split(/\.|(\[\d+\])/).reject(&:empty?).inject("") do |result, key|
        found = case key
        when ARRAY_ID
          latest[$1.to_i]
        else
          latest[key] || latest[key.to_sym]
        end

        result = add(result, key)
        found or raise "#{latest.class} does not respond to '#{key}' in '#{result}'"
        latest = found
        result
      end

      latest
    end

    def add(current, key)
      current << (key.match(ARRAY_ID) ? key : ".#{key}")
    end
  end

  class Found < Struct.new(:query)
    def found?; true; end
  end

  class NotFound
    def found?; false; end
    def query; nil end
  end
end

result1 = Berg::Key.locate(object) do |leaf|
  leaf.to_s.downcase.include?("fire in the rain")
end

result2 = Berg::Value.new.locate(object, ".context.dispatcher.stores.PageStore.pages./nrj/latlista.data[1].modules[2].content[0].title")

pp [result1, result2]