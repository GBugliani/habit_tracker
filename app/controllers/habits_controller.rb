class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: [ :show, :edit, :update, :destroy ]

  def index
    @selected_category = params[:category].to_s
    @selected_priority = params[:priority].to_s
    @selected_status = params[:status].to_s

    habits = current_user.habits.order(created_at: :desc)
    @categories = current_user.habits.where.not(category: [nil, ""]).distinct.order(:category).pluck(:category)

    habits = habits.where(category: @selected_category) if @selected_category.present?
    habits = habits.where(priority: @selected_priority) if Habit::PRIORITIES.include?(@selected_priority)

    case @selected_status
    when "active"
      habits = habits.where(active: true)
    when "paused"
      habits = habits.where(active: false)
    end

    @pagination_params = {
      category: @selected_category,
      priority: @selected_priority,
      status: @selected_status
    }.reject { |_, value| value.blank? }

    @per_page = 9
    @total_count = habits.count
    @total_pages = [(@total_count.to_f / @per_page).ceil, 1].max

    requested_page = params[:page].to_i
    @current_page = requested_page.positive? ? requested_page : 1
    @current_page = @total_pages if @current_page > @total_pages

    offset = (@current_page - 1) * @per_page
    @habits = habits.offset(offset).limit(@per_page)

    @page_from = @total_count.zero? ? 0 : offset + 1
    @page_to = [offset + @per_page, @total_count].min
  end

  def show
    @completions = @habit.completions.all
  end

  def new
    @habit = Habit.new
  end

  def create
    @habit = current_user.habits.new(habit_params)
    if @habit.save
      redirect_to @habit, notice: "Hábito criado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @habit.update(habit_params)
      redirect_to @habit, notice: "Hábito atualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @habit.destroy
    redirect_to habits_path, notice: "Hábito removido."
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(
      :name,
      :description,
      :category,
      :frequency_per_week,
      :priority,
      :reminder_time,
      :active
    )
  end
end