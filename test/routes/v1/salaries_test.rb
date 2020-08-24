# frozen_string_literal: true

require "test_helper"

class SalariesTest < AuthenticatedApiTest
  def test_index
    post_index
    assert_equal 201, last_response.status
  end

  def test_index_has_players_list
    post_index
    assert parsed_response.key? "jugadores"
    assert_kind_of Array, parsed_response["jugadores"]
  end

  def test_index_throws_error_on_failure
    post path, {}.to_json

    assert_equal 400, last_response.status
    assert parsed_response.key? "error"
  end

  private
    def path
      "/api/v1/salaries"
    end

    def sample_post_body
      JSON.parse(fixture("players_list.json")).to_json
    end

    def post_index
      post path, sample_post_body
    end

    def parsed_response
      JSON.parse(last_response.body)
    end
end
