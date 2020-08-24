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
end
