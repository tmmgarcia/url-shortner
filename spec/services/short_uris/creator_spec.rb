require 'rails_helper'

RSpec.describe ShortUris::Creator, type: :service do
  subject { described_class }

  describe '#call' do
    context 'when original uri is valid' do
      let(:original_uri) { 'https://devs.gapfish.com/' }

      context 'when path already exists' do
        let(:existing_path) { 'existing_path' }
        let(:service) { subject.new(original_uri: original_uri) }

        before do
          first_attempt_fails    = true
          second_attempt_succeed = false
          allow(ShortUris::Searcher.new(path: existing_path)).to receive(:call).and_return(first_attempt_fails, second_attempt_succeed)
        end

        it {
          expect { service.call }
        .to change {
          ShortUri.count
        }.by(1) }

        it {
          expect { service.call }
        .to change {
          service.short_uri
        }.from(nil).to(ShortUri) }
      end

      context 'when path does not exist' do
        let(:service) { subject.new(original_uri: original_uri) }

        it {
          expect { service.call }
        .to change {
          ShortUri.count
        }.by(1) }

        it {
          expect { service.call }
        .to change {
          service.short_uri
        }.from(nil).to(ShortUri) }
      end
    end

    context 'when original uri is invalid' do
      let(:original_uri) { 'gapfish' }

      let(:service) { subject.new(original_uri: original_uri) }

      it {
        expect { service.call }
      .not_to change {
        ShortUri.count
      }}
    end

    context 'when short uri is present' do
      let(:service) { subject.new(original_uri: 'https://devs.gapfish.com/') }

      before do
        dummy_short_uri = ShortUri.new
        expect_any_instance_of(described_class).to receive(:short_uri).and_return(dummy_short_uri)
      end

      it {
        expect { service.call
      }.to raise_error(
        RuntimeError, "Invalid call to #call"
      )}
    end
  end

  describe '#errors' do
    let(:service) { subject.new(original_uri: original_uri) }

    context 'when original uri is valid' do
      let(:original_uri) { 'https://devs.gapfish.com/' }

      it 'does not have any errors' do
        service.call
        expect(service.errors.any?).to be_falsey
      end
    end

    context 'when original uri is invalid' do
      let(:original_uri) { 'gapfish' }

      it 'has errors' do
        service.call
        expect(service.errors.any?).to be_truthy
      end

      it 'has invalid url error message' do
        errors = service.call.errors
        expect(errors.messages).to include(:original_uri=>["is an invalid URL"])
      end
    end
  end

  describe '#success?' do
    let(:service) { subject.new(original_uri: original_uri) }

    context 'when original uri is valid' do
      let(:original_uri) { 'https://devs.gapfish.com/' }

      it 'returns true' do
        service.call
        expect(service.success?).to be_truthy
      end
    end

    context 'when original uri is invalid' do
      let(:original_uri) { 'gapfish' }

      it 'returns false' do
        service.call
        expect(service.success?).to be_falsey
      end
    end
  end
end
