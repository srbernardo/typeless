class IncomesController < ApplicationController

  def new
    @income = Income.new
    @user = current_user
  end

  def create
    @income = Income.new(income_params)
    @user = current_user
    @income.user = @user

    respond_to do |format|
      if @income.save
        format.html { redirect_to new_income_path, notice: "Income was successfully added." }
        @income.save
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def income_params
    params.require(:income).permit(:date, :title, :description, :quantity, :value)
  end
end
