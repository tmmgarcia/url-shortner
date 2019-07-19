require 'rails_helper'

RSpec.describe ShortUri, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:original_uri) }
    it { is_expected.to validate_presence_of(:path) }

    context 'with valid parameters' do
      it { expect(build(:short_uri).valid?).to be_truthy }
    end

    context 'with invalid parameters' do
      it { expect(ShortUri.new.valid?).to be_falsey }
      it { expect(build(:short_uri, original_uri: 'invalid_url').valid?).to be_falsey }
    end
  end

  describe 'database columns' do
    it { is_expected.to have_db_column(:original_uri).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:path).of_type(:string).with_options(null: false)  }
    it { is_expected.to have_db_column(:times_clicked).of_type(:integer).with_options(default: 0)  }
  end
end
