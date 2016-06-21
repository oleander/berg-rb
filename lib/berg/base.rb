module Berg
  module Base
    ARRAY_ID = /\[(-?\d+)\]/

    def add(trace, key)
      trace + (key.match(ARRAY_ID) ? key : ".#{key}")
    end
  end
end
