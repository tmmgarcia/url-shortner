require 'rails_helper'

RSpec.describe ShortUris::Redirecter, type: :service do
  subject { described_class }

  describe '#call' do
    let(:original_uri) { 'https://www.google.com/' }
    let(:service) { subject.new(short_uri: short_uri) }
    let(:short_uri) { create(:short_uri, original_uri: original_uri) }

    context 'when times clicked is 0' do
      it { expect { service.call }.to change { short_uri.times_clicked }.from(0).to(1) }
      it { expect { service.call }.to change { short_uri.times_clicked }.by(1) }
      it { expect(service.call).to eq(original_uri) }
    end

    context 'when times clicked is greater than 0' do
      let(:current_times_clicked) do
        short_uri.update!(times_clicked: rand(10))
        short_uri.times_clicked
      end

      it { expect { service.call }.to change { short_uri.times_clicked }.from(current_times_clicked).to(current_times_clicked+1) }
      it { expect { service.call }.to change { short_uri.times_clicked }.by(1) }
      it { expect(service.call).to eq(original_uri) }
    end
  end
end
