# frozen_string_literal: true

require "test_helper"

class SalariesServiceTest < ApiTest
  def setup
    super
    @service = SalariesService.new(request_body)
  end

  def test_initializes_teams_and_players
    assert_kind_of Array, @service.teams
    assert @service.teams.size > 0
    @service.teams.each do |team|
      assert_kind_of Team, team
      assert_not team.name.nil?
      assert_not team.players.nil?
      assert_not team.ruleset.nil?
    end
  end

  def test_players_salaries
    result = @service.players_salaries
    assert_kind_of Array, result
    result.each do |player|
      assert_kind_of Player, player
    end
  end

  private
    def request_body
      fixture("players_list_with_teams.json")
    end
end
