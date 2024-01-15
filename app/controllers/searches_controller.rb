require 'fuzzystringmatch'

class SearchesController < ApplicationController
    skip_before_action :verify_authenticity_token  # Only for demonstration, should be handled properly
  
    def new
      @articles = Article.all
    end
  
    def create
      user_identifier = request.headers['X-Forwarded-For']&.split(',')&.first.strip || request.remote_ip
      query = params[:query]
  
      if new_query?(user_identifier, query)
        # Save the new query
        SearchQuery.create(query: query, user_identifier: user_identifier)
      end
  
      @articles = Article.where("title ILIKE ?", "%#{query}%")
      respond_to do |format|
        format.json { render json: @articles }
      end
    end
  
    private
  
    def new_query?(user_identifier, query)
        last_query = SearchQuery.where(user_identifier: user_identifier).last
        return true if last_query.nil?
      
        # Adjust the threshold based on query length
        threshold = case query.length
          when 1..2 then 0
          when 3..5 then 0.50
          else 0.70
        end
      
        # Consider time factor - for example, 30 seconds
        return true if Time.current - last_query.created_at > 30.seconds
      
        fuzzy_matcher = FuzzyStringMatch::JaroWinkler.create(:pure)
        distance = fuzzy_matcher.getDistance(last_query.query, query)

        if distance >= threshold
            last_query.destroy  # Delete the old query
            true  # Treat the new query as a distinct one for saving
        end

        true
    end
      
end
  