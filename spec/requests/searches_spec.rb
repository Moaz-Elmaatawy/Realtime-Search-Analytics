require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "GET /" do
    it "loads the search page" do
      get new_search_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /searches" do
    it "handles the search query" do
      post searches_path, params: { query: "test" }, headers: { "ACCEPT" => "application/json" }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /searches with different queries" do
    it "handles empty search query" do
      post searches_path, params: { query: "" }, headers: { "ACCEPT" => "application/json" }
      expect(response).to have_http_status(:ok)
    end
  
    it "handles query with special characters" do
      post searches_path, params: { query: "!@#$%^&*" }, headers: { "ACCEPT" => "application/json" }
      expect(response).to have_http_status(:success)
    end
  
    it "handles long query string" do
      long_query = "a" * 500  # Example of a very long query string
      post searches_path, params: { query: long_query }, headers: { "ACCEPT" => "application/json" }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /searches with no results" do
    it "handles query with no matching results" do
      post searches_path, params: { query: "nonexistentquery" }, headers: { "ACCEPT" => "application/json" }
      expect(response).to have_http_status(:success)
      expect(response.body).to eq("[]")
    end
  end
  
  describe "POST /searches logs query" do
    it "creates a new search query record" do
      expect {
        post searches_path, params: { query: "ruby" }, headers: { "ACCEPT" => "application/json" }
      }.to change(SearchQuery, :count).by(1)
    end
  end
end
