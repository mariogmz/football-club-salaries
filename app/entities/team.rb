# frozen_string_literal: true

class Team
  attr_accessor :name, :players, :ruleset, :bonus_percentage

  def initialize(players = [], ruleset = Ruleset.new)
    @players = players
    @ruleset = ruleset
  end

  def team_score
    players.map(&:goles).reduce(:+)
  end
end
