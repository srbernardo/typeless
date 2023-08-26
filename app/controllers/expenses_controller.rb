class ExpensesController < ApplicationController
  include ApplicationHelper
  before_action :find_expense, only: %i[show edit update destroy]
  before_action :set_user, only: :index

  def index
    @expense = Expense.new
    @expenses = Expense.where(user: @user)
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user = current_user
    respond_to do |format|
      if @expense.save
        fill_params_from_photo
        format.html { redirect_to expenses_path, notice: "Expense was successfully created." }
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
        format.html { redirect_to expenses_path, notice: "Expense was successfully updated." }
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

  def fill_params_from_photo
    unless @expense.photo.url.nil?
      if @expense.ocr_hash.nil?
        @expense.ocr_hash = ocr_veryfi(@expense.photo.url)
        @expense.value = @expense.ocr_hash["total"]
        @expense.date = @expense.ocr_hash["date"]
        @expense.place = @expense.ocr_hash["vendor"]["name"]
        @expense.update(
          ocr_hash: @expense.ocr_hash,
          value: @expense.value,
          category: @expense.category,
          date: @expense.date,
          place: @expense.place,
          payment_type: @expense.payment_type
        )
      end
    end
  end

  def expense_params
    params.require(:expense).permit(:date, :place, :description, :quantity, :unity, :value, :category, :payment_type, :photo)
  end

  def find_expense
    @expense = Expense.find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
