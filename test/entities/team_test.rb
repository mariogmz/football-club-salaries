# frozen_string_literal: true

class TeamTest < ApiTest
  def setup
    super
    @team = Team.new(players_list)
  end

  def test_team_score
    score = players_data.inject(0) do |sum, player|
      sum + player[:goles]
    end
    assert_equal score, @team.team_score
  end

  private
    def players_list
      players_data.map do |attributes|
        Player.new(attributes)
      end
    end

    def players_data
      [
        {
           nombre: "Juan Perez",
           nivel: "C",
           goles: 10,
           sueldo: 50000,
           bono: 25000,
           sueldo_completo: nil,
           equipo: "rojo"
        },
        {
           nombre: "EL Cuauh",
           nivel: "Cuauh",
           goles: 30,
           sueldo: 100000,
           bono: 30000,
           sueldo_completo: nil,
           equipo: "rojo"
        }
      ]
    end
end
