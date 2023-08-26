class SearchController < ApplicationController
  def index
    @results = search(params[:query], current_user)
  end

  private

  def search(query, user)
    Expense.where(user: user).search_all_fields(query) + Income.where(user: user).search_all_fields(query)
  end
end
