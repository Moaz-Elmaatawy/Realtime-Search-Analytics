class SearchQuery < ApplicationRecord
    validates :query, presence: true  # Ensures that a query is present
    validates :user_identifier, presence: true 
end
