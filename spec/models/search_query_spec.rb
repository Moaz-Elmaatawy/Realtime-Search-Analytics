require 'rails_helper'

RSpec.describe SearchQuery, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      search_query = SearchQuery.new(query: 'test query', user_identifier: '123.123.123.123')
      expect(search_query).to be_valid
    end

    it 'is not valid without a query' do
      search_query = SearchQuery.new(query: nil, user_identifier: '123.123.123.123')
      expect(search_query).to_not be_valid
    end

    it 'is not valid without a user identifier' do
      search_query = SearchQuery.new(query: 'test query', user_identifier: nil)
      expect(search_query).to_not be_valid
    end
  end
end
