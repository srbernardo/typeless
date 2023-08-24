class PagesController < ApplicationController
  before_action :top, only: :home

  def home
    @expense = Expense.new
    saldo_negativo = Expense.where(user_id: current_user.id).pluck(:value).reduce(:+)
    saldo_positivo = Income.where(user_id: current_user.id).pluck(:value).reduce(:+)

    saldo_negativo =  0 if saldo_negativo.nil?
    saldo_positivo =  0 if saldo_positivo.nil?

    @saldo = saldo_positivo - saldo_negativo
    @saldo.negative? ? @color = "text-danger" : @color = "text-black"
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

  def top
    @user = current_user
    @top = Expense.where(user: @user).order(value: :desc).limit(5)
  end
end
