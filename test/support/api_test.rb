# frozen_string_literal: true

class ApiTest < Minitest::Test
  include Rack::Test::Methods

  def app
    @app ||= API::Root.new
  end

  def described_class
    Object.const_get(self.class.to_s.sub("Test", ""))
  end

  def fixture(filename)
    File.read(File.expand_path("../fixtures/#{filename}", __dir__))
  end
end
