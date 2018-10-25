require "securerandom"
require "json"

RSpec.shared_context "initialized client" do
  let!(:username) { "username" }
  let!(:sitename) { "sitename" }
  let!(:password) { "password" }
  let!(:host)     { "https://secure.p01.eloqua.com" }
  let!(:host_information) do
    {
      site: { name:     sitename },
      user: { username: username },
      urls: { base:     host },
    }
  end

  subject(:client) { Eloquant::Client.new(username: username, password: password, sitename: sitename) }

  before do
    stub_request(:get, "#{host}/id").to_return(json_stub(host_information))
  end
end
