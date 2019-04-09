# noinspection RubyResolve,RubyResolve
require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'HLO'

class ClientTest < Minitest::Test
  def test_HLO_R1
    assert_equal 'Hello, World!', Hello.new.hello('World'), 'App says hello to the world'
  end

  def test_HLO_R2
    assert_equal 'Hello, John!', Hello.new.hello('John'), 'App says hello to the name passed as String argument'
  end
end

