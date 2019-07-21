require 'rails_helper'

RSpec.describe ShortUris::PathGenerator, type: :service do
  subject { described_class.new }

  describe '#call' do
    it { expect(subject.call).to be_truthy }

    context 'with mocked SecureRandom' do
      let(:mocked) { double(populate_needed?: false, path: 'RANDOM') }

      before do
        allow_any_instance_of(Paths::GetAvailable).to receive_messages(
          call: mocked.path,
          path: mocked.path,
          populate_needed?: mocked.populate_needed?
        )
      end

      it { expect(subject.call).to eq(mocked.path) }
    end
  end
end
