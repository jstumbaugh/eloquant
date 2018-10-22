require "./spec/support/initialized_client"

RSpec.describe Eloquant::Client do
  include_context "initialized client", include_shared: true

  it "uses an existing Faraday connection when provided" do
    logger_double = instance_double("::Logger", debug: "Debugging", info: "Info")

    conn = Faraday.new do |builder|
      builder.response :logger, logger_double
      builder.adapter :test do |stub|
        stub.get("/fish") { |env| [200, {}, "salmon"] }
      end
    end

    client = Eloquant::Client.new(host: host, client_id: client_id, client_secret: client_secret, connection: conn)

    expect(client.connection.get("/fish").body).to eq("salmon")
    expect(logger_double).to have_received(:debug).at_least(:once)
    expect(logger_double).to have_received(:info).at_least(:once)
  end

end
