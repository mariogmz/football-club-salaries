# frozen_string_literal: true

require "test_helper"

class SalariesServiceTest < ApiTest
  def test_initializes_teams_and_players
    @service = SalariesService.new(request_body)

    assert_kind_of Array, @service.teams
    assert @service.teams.size > 0
    @service.teams.each do |team|
      assert_kind_of Team, team
      assert_not team.name.nil?
      assert_not team.players.nil?
      assert_not team.ruleset.nil?
    end
  end

  private
    def request_body
      fixture("players_list_with_teams.json")
    end
end
