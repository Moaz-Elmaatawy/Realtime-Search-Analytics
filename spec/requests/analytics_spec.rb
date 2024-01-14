require 'rails_helper'

RSpec.describe "Analytics", type: :request do
  describe "GET /analytics" do
    it "loads the analytics page" do
      get analytics_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /analytics for user-specific searches" do
    before do
      10.times do |i|
        SearchQuery.create(query: "Query #{i}", user_identifier: "123.123.123.#{i}")
      end
    end

    it "returns user-specific searches if user_identifier is provided" do
      get analytics_path, params: { user_identifier: '123.123.123.1' }
      expect(response).to be_successful
    end
  end

  describe "GET /analytics with no data" do
    it "handles empty search queries" do
      get analytics_path
      expect(response).to have_http_status(:success)
      expect(response.body).to match(/<ul>\s*<\/ul>/m)
    end
  end

  describe "GET /analytics for a specific user with no data" do
    it "returns empty searches for a user with no queries" do
      get analytics_path, params: { user_identifier: '123.123.123.999' }
      expect(response).to have_http_status(:success)
      expect(response.body).to match(/<ul>\s*<\/ul>/m)
    end
  end
  
end
