class ExpensesController < ApplicationController
  include ApplicationHelper
  before_action :find_expense, only: %i[show edit update destroy]

  def index
    @expenses = Expense.all
  end

  def show
    unless @expense.photo.url.nil?
      if @expense.ocr_hash.nil?
        @expense.ocr_hash = ocr_veryfi(@expense.photo.url)
        @expense.update(ocr_hash: @expense.ocr_hash)
      end
    end
    @hash = eval(@expense.ocr_hash)
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

  def edit
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to root_path, notice: "Expense was successfully updated." }
      else
        format.html { render "edit", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_path, notiice: "Expense was successfully deleted."
  end

  private

  def expense_params
    params.require(:expense).permit(:date, :place, :description, :quantity, :unity, :value, :category, :payment_type, :photo)
  end

  def find_expense
    @expense = Expense.find(params[:id])
  end
end
