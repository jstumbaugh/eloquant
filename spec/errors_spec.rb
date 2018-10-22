RSpec.describe Eloquant::Errors do
  describe ".find_by_response_code" do
    subject { described_class.find_by_response_code(code) }

    context "when the code is" do
      context "unknown" do
        let(:code) { 7331 }

        it { is_expected.to eq(Eloquant::Errors::Error) }
      end
    end
  end
end
