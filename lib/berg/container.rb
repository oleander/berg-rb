module Berg
  class Found < Struct.new(:value)
    def found?; true; end
  end

  class NotFound
    def found?; false; end
    def value; nil end
  end
end