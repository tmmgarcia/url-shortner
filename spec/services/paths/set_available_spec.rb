require 'rails_helper'

RSpec.describe Paths::SetAvailable, type: :service do
  subject { described_class }
  let(:path_list) { (1..10).map { |p| "path#{p}" } }
  let(:service) { subject.new(path_list: path_list) }

  before do
    ENV['PATH_KEY'] = "key"
    $redis.smembers(ENV['PATH_KEY'])
  end

  describe '#call' do
    it { expect(service.call).to be_truthy }
  end
end
