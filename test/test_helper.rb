$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "berg"

require "minitest/reporters"
require "minitest/autorun"
require "minitest/spec"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new