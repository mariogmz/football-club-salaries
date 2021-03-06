# frozen_string_literal: true

class SalariesService
  attr_reader :teams

  def initialize(players_list, teams_rulesets = nil)
    @players_list = players_list
    @teams_rulesets = parse_teams_rulesets(teams_rulesets)
    @teams = initialize_teams
  end

  def players_salaries
    teams.map(&:players_with_salaries).flatten
  end

  private
    def parse_teams_rulesets(teams_rulesets)
      return if teams_rulesets.nil?

      teams_rulesets.each_with_object({}) do |team_ruleset, hash|
        hash[team_ruleset[:nombre].to_sym] = team_ruleset[:metas]
      end
    end

    def ruleset_hash(name)
      return if @teams_rulesets.nil?

      @teams_rulesets[name.to_sym].each_with_object({}) do |ruleset, hash|
        hash[ruleset[:nivel]] = ruleset[:goles]
      end
    end

    def teams_hash
      @players_list.each_with_object({}) do |player_hash, teams_hash|
        team = player_hash[:equipo]
        teams_hash[team] = [] unless teams_hash.key? team
        teams_hash[team] << Player.new(player_hash)
      end
    end

    def initialize_teams
      teams_hash.map do |team_name, players|
        ruleset = Ruleset.new(ruleset_hash(team_name))
        Team.new(team_name.to_s, players, ruleset)
      end
    end
end
