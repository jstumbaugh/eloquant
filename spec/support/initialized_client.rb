require "securerandom"
require "json"

RSpec.shared_context "initialized client" do
  let(:host)          { "login.eloqua.com" }
  let(:client_id)     { SecureRandom.uuid }
  let(:client_secret) { SecureRandom.hex }
  let(:authentication_stub) do
    { access_token: SecureRandom.uuid, token_type: "bearer", expires_in: 3600, refresh_token: SecureRandom.uuid }
  end

  subject(:client) { Eloquant::Client.new(host: host, client_id: client_id, client_secret: client_secret) }

  before do
    stub_request(:get, "https://#{host}/auth/oauth2/token")
      .with(query: { grant_type: "authorization_code", code: SecureRandom.uuid, redirect_uri: "https://client.example.com/cb" })
      .to_return(json_stub(authentication_stub))
  end
end
