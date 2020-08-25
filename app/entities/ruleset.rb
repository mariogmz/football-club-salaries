# frozen_string_literal: true

class Ruleset
  DEFAULT = {
    "A" => 5,
    "B" => 10,
    "C" => 15,
    "Cuauh" => 20
  }
  attr_reader :rules

  def initialize(rules = DEFAULT)
    @rules = parse(rules || DEFAULT)
  end

  # Adds a new rule given a level (Hash Key) and the goals per month value
  # This can also override an existing level
  def add_rule(level, goals_per_month)
    @rules[level.to_s] = goals_per_month
  end

  # Delegates methods to the rules hash
  def method_missing(m, *args, &block)
    if rules.respond_to?(m)
      rules.send(m, *args)
    else
      super
    end
  end

  private
    def parse(rules)
      return if rules.nil?
      return JSON.parse(rules) if rules.is_a? String
      rules.transform_keys(&:to_s)
    end
end
