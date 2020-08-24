# frozen_string_literal: true

module API::Routes
  class Salaries < Grape::API
    resource :salaries do
        params do
          requires :jugadores, type: Array[JSON] do
            requires :nombre, type: String
            requires :nivel, type: String, values: %w[A B C Cuauh]
            requires :goles, type: Integer
            requires :sueldo, type: Integer
            requires :bono, type: Integer
            optional :sueldo_completo, type: Integer, default: nil
            requires :equipo, type: String
          end
        end

        desc "Returns players list including full salary calculation results"
        post :/ do
          { jugadores: [] }
        end
      end
  end
end
