class IncomesController < ApplicationController
  def index
    @incomes = Income.all
  end

  def show
    @income = Income.find(params[:id])
  end

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

  def edit
    @income = Income.find(params[:id])
  end

  def update
    @income = Income.find(params[:id])

    if @income.update(income_params)
      redirect_to incomes_path, notice: "Income was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @income = Income.find(params[:id])
    @income.destroy

    redirect_to incomes_path, notice: "Income was successfully deleted."
  end

  private

  def income_params
    params.require(:income).permit(:date, :title, :description, :quantity, :value)
  end
end
