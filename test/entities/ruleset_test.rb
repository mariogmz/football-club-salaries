# frozen_string_literal: true

require "test_helper"

class RulesetTest < ApiTest
  def setup
    super
  end

  def test_initializes_default_rules
    @ruleset = Ruleset.new
    assert_equal Ruleset::DEFAULT, @ruleset.rules
  end

  def test_can_receive_rules_as_json
    json_rules = Ruleset::DEFAULT.to_json
    @ruleset = Ruleset.new(json_rules)
    assert_equal Ruleset::DEFAULT, @ruleset.rules
  end

  def test_adds_rules
    @ruleset = Ruleset.new({})
    @ruleset.add_rule("X", 100)
    assert @ruleset.key? "X"
    assert_equal 100, @ruleset["X"]
  end
end
