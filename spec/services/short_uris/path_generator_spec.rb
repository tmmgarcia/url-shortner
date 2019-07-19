require 'rails_helper'

RSpec.describe ShortUris::PathGenerator, type: :service do
  subject { described_class.new }

  describe '#call' do
    it { expect(subject.call).to be_truthy }

    context 'with mocked SecureRandom' do
      let(:expected_path) { 'RANDOM' }

      before do
        allow(SecureRandom).to receive(:urlsafe_base64).and_return(expected_path)
      end

      it { expect(subject.call).to eq(expected_path) }
    end
  end
end
