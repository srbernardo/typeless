class PagesController < ApplicationController
  def home
    saldo_negativo = Expense.all.pluck(:value).reduce(:+)
    saldo_positivo = Income.all.pluck(:value).reduce(:+)
    @saldo = saldo_positivo - saldo_negativo
    @expense = Expense.new
    @color = "text-black"

    if @saldo.negative?
      @color = "text-danger"
    end
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user = current_user
    respond_to do |format|
      if @expense.save
        format.html { redirect_to root_path, notice: "Expense was successfully created." }
      else
        format.html { render "new", status: :unprocessable_entity }
      end
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:photo)
  end
end
