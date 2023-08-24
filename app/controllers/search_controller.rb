class SearchController < ApplicationController
  def index
    @results = search(params[:query])
  end

  private

  def search(query)
    Expense.search_all_fields(query) + Income.search_all_fields(query)
  end
end
