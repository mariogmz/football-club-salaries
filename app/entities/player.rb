# frozen_string_literal: true

class Player
  ATTRIBUTES = %i[nombre nivel goles sueldo bono sueldo_completo equipo]
  attr_accessor(*ATTRIBUTES)

  def initialize(*attrs)
    attrs[0].slice(*ATTRIBUTES).each do |attr, value|
      instance_variable_set "@#{attr}".to_sym, value
    end
  end

  def to_h
    ATTRIBUTES.each_with_object({}) do |key, hash|
      hash[key] = send(key)
    end
  end

  def to_json(*options)
    to_h.to_json(*options)
  end
end
