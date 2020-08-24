# frozen_string_literal: true

require "test_helper"

class PlayerTest < ApiTest
  def setup
    super
    @player = described_class.new(player_attributes)
  end

  def test_to_h
    assert_equal player_attributes, @player.to_h
  end

  def test_to_json
    assert_kind_of String, @player.to_json
    assert_equal player_attributes.to_json, @player.to_json
  end

  def test_goal
    @player.nivel = "X"
    result = @player.goal(ruleset)
    assert_kind_of Integer, result
    assert_equal ruleset["X"], result
  end

  def test_individual_bonus_percentage
    @player.nivel = "X"
    @player.goles = 19
    @player.sueldo = 50000
    assert_equal 0.95, @player.calculate_individual_bonus_percentage(ruleset)
  end

  def test_calculate_full_salary
    @player.nivel = "X"
    @player.goles = 19
    @player.sueldo = 50000
    @player.bono = 10000
    team_bonus_percentage = 0.96
    assert_equal 59550, @player.calculate_full_salary(ruleset, team_bonus_percentage)
  end

  private
    def player_attributes
      {
         nombre: "El Rulo",
         nivel: "B",
         goles: 9,
         sueldo: 30000,
         bono: 15000,
         sueldo_completo: nil,
         equipo: "rojo"
      }
    end

    def ruleset
      @ruleset ||= Ruleset.new({
        "X": 20
      })
    end
end
