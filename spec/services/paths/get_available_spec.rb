require 'rails_helper'

RSpec.describe Paths::GetAvailable, type: :service do
  subject { described_class }
  let(:path_list) { (1..10).map { |p| "path#{p}" } }
  let(:service) { subject.new }

  before do
    ENV['MIN_AVALIABLE_PATH_SIZE'] = "5"
    allow($redis).to receive(:smembers).and_return(path_list)
  end

  describe '#call' do
    it { expect(service.call).to be_truthy }
  end

  describe '#path' do
    it { expect(path_list.include?(service.path)).to be_truthy }
  end

  describe '#populate_needed?' do
    it { expect(service.populate_needed?).to be_falsey }
  end

  describe '#available_list' do
    it do
      service.call
      expect(service.available_list.size).to eq(path_list.size)
    end
  end
end
