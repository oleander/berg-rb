module Berg
  class Value
    include Berg::Base

    def initialize(object, query, debug = false)
      @object = object
      @query = query
      @debug = debug
    end

    def self.locate(object, query, debug = false)
      new(object, query, debug).locate
    end

    def locate
      result, _ = keys.inject([@object, ""]) do |(latest, trace), key|
        found = case key
        when Base::ARRAY_ID
          latest[$1.to_i]
        else
          latest[key] || latest[key.to_sym]
        end

        trace = add(trace, key)

        unless found
          fail "#{latest.class} doesn't contain key '#{key}' in '#{trace}'" if @debug
          return NotFound.new unless found
        end

        [found, trace]
      end

      return Found.new(result)
    end

    private

    def keys
      @query.split(/\.|(\[-?\d+\])/).reject(&:empty?)
    end
  end
end