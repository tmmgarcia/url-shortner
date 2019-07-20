require 'rails_helper'

RSpec.describe ShortUrisController, type: :request do
  describe "GET #index" do
    before do
      get root_url
    end

    it { expect(response).to be_successful }
    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to include("Hey! This the URI shortener service!") }
  end

  describe "GET #new" do
    before do
      get new_short_uri_url
    end

    it { expect(response).to be_successful }
    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to include("Shorten!") }
    it { expect(response.body).to include("Enter an url") }
  end

  describe "POST #create" do
    context 'when parameters are correct' do
      let(:original_uri) { build(:short_uri).original_uri }

      before do
        post short_uris_url, params: { short_uri: { original_uri: original_uri } }
        follow_redirect!
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to include("This is your shorted URL") }
      it { expect(response.body).to include(original_uri) }
    end

    context 'when parameters are wrong' do
      let(:original_uri) { 'foo' }

      before do
        post short_uris_url, params: { short_uri: { original_uri: original_uri } }
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to include("is an invalid URL") }
    end
  end

  describe "GET #show" do
    let(:short_uri) { create(:short_uri) }

    before do
      get short_uri_url(short_uri)
    end

    it { expect(response).to be_successful }
    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to include("This is your shorted URL") }
    it { expect(response.body).to include("This is your shorted URL") }
    it { expect(response.body).to include(short_uri.original_uri) }
    it { expect(response.body).to include(short_uri.path) }
    it { expect(response.body).to include(short_uri.times_clicked.to_s) }
  end

  describe "GET #path" do
    let(:short_uri) { create(:short_uri)}

    before do
      get "/#{short_uri.path}"
    end

    it { expect(response).to have_http_status(:found) }
    it { expect(response.body).to include(short_uri.original_uri) }
  end
end
