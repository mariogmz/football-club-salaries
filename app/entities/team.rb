# frozen_string_literal: true

class Team
  attr_accessor :name, :players, :ruleset

  def initialize(players = [], ruleset = Ruleset.new)
    @players = players
    @ruleset = ruleset
  end

  def score
    players.map(&:goles).reduce(:+)
  end

  def goal
    players.map { |player| player.goal(ruleset) }.reduce(:+)
  end

  def bonus_percentage
    result = score.to_f / goal
    result > 1 ? 1 : result
  end
end
