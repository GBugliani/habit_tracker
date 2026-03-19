class CompletionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @habit = current_user.habits.find(params[:habit_id])
    @habit.completions.find_or_create_by(completed_on: Date.today)
    redirect_to @habit
  end

  def destroy
    @habit = current_user.habits.find(params[:habit_id])
    completion = @habit.completions.find(params[:id])
    completion.destroy
    redirect_to @habit
  end
end