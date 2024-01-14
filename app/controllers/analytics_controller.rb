class AnalyticsController < ApplicationController
    def index
        @top_searches = SearchQuery.group(:query)
                                    .order('count_id DESC')
                                    .count('id')
                                    .first(10)

        @recent_searches = SearchQuery.order(created_at: :desc)
                                        .limit(10)

        if params[:user_identifier]
            @user_top_searches = SearchQuery.where(user_identifier: params[:user_identifier])
                                            .group(:query)
                                            .order('count_id DESC')
                                            .count('id')
                                            .first(10)

            @user_recent_searches = SearchQuery.where(user_identifier: params[:user_identifier])
                                            .order(created_at: :desc)
                                            .limit(10)
        end
    end

    def reset
        SearchQuery.delete_all
        redirect_to analytics_path, notice: 'Analytics data has been reset.'
    end
end
  