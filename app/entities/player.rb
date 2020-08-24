# frozen_string_literal: true

class Player
  ATTRIBUTES = %i[nombre nivel goles sueldo bono sueldo_completo equipo]
  attr_accessor(*ATTRIBUTES)
  attr_reader :individual_bonus_percentage

  def initialize(*attrs)
    attrs[0].slice(*ATTRIBUTES).each do |attr, value|
      instance_variable_set "@#{attr}".to_sym, value
    end
  end

  def calculate_individual_bonus_percentage(ruleset)
    score_per_month = ruleset[nivel]
    @individual_bonus_percentage =
      if goles > score_per_month
        1
      else
        goles / score_per_month.to_f
      end
    @individual_bonus_percentage
  end

  def calculate_full_salary(ruleset, team_bonus_percentage)
    @team_bonus_percentage = team_bonus_percentage
    @sueldo_completo = sueldo + (bono * bonus_percentage(ruleset))
    @sueldo_completo
  end

  def to_h
    ATTRIBUTES.each_with_object({}) do |key, hash|
      hash[key] = send(key)
    end
  end

  def to_json(*options)
    to_h.to_json(*options)
  end

  private
    def bonus_percentage(ruleset)
      (calculate_individual_bonus_percentage(ruleset) +
      @team_bonus_percentage).to_f / 2
    end
end
