require 'rails_helper'
RSpec.describe PathPopulateWorker, type: :worker do
  subject { described_class }

  context 'with available path list' do
    before do
      allow_any_instance_of(Paths::GetAvailable).to receive(:call).and_return(['path1', 'path2'])
    end

    context 'with duplicated path' do
      before do
        create(:short_uri, path: 'path1')
        subject.perform_async(true)
      end

      it { expect(subject).to have_enqueued_sidekiq_job(true) }
    end

    context 'without duplicated path' do
      before do
        subject.perform_async(true)
      end

      it { expect(subject).to have_enqueued_sidekiq_job(true) }
    end
  end

  context 'without available path list' do
    before do
      allow_any_instance_of(Paths::GetAvailable).to receive(:call).and_return([])
    end

    context 'with duplicated path' do
      # create(:short_uri, path: 'path1')
    end

    context 'without duplicated path' do
    end
  end
end
