class IncomesController < ApplicationController
  def index
    @incomes = Income.all
  end

  def show
    @income = Income.find(params[:id])
  end
end
