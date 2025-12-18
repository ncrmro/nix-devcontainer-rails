require 'rails_helper'

RSpec.describe "Hello endpoint", type: :request do
  describe "GET /hello" do
    it "returns default greeting" do
      get '/hello'
      expect(response).to have_http_status(200)
      expect(response.body).to eq("Hello, World!")
    end

    it "returns greeting with custom parameter" do
      get '/hello?what=nix'
      expect(response).to have_http_status(200)
      expect(response.body).to eq("Hello, nix!")
    end
  end
end
