require 'rails_helper'

RSpec.describe ShortUris::Searcher, type: :service do
  subject { described_class }

  describe '#call' do
    let(:existing_path) { 'some_path' }

    context 'when path exists' do
      let(:service) { subject.new(path: existing_path) }
      before do
        create(:short_uri, path: existing_path)
      end

      it { expect(service.call).to be true }
    end

    context 'when path does not exist' do
      let(:service) { subject.new(path: 'some_other_path') }

      it { expect(service.call).to be false }
    end
  end
end
