# frozen_string_literal: true

class Team
  attr_accessor :name, :players, :ruleset

  def initialize(name, players = [], ruleset = Ruleset.new)
    @name = name
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
    result > 1 ? 1.0 : result
  end

  def players_with_salaries
    team_percentage = bonus_percentage
    players.map do |player|
      player.calculate_full_salary(@ruleset, team_percentage)
      player
    end
  end
end
