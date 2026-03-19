class Habit < ApplicationRecord
  PRIORITIES = %w[baixa media alta].freeze

  after_initialize :set_defaults, if: :new_record?

  belongs_to :user
  has_many :completions, dependent: :destroy

  validates :name, presence: true
  validates :category, length: { maximum: 40 }, allow_blank: true
  validates :frequency_per_week, inclusion: { in: 1..7 }
  validates :priority, inclusion: { in: PRIORITIES }

  def completed_today?
    completions.exists?(completed_on: Date.today)
  end

  def streak
    count = 0
    date = Date.today
    loop do
      break unless completions.exists?(completed_on: date)

      count += 1
      date -= 1.day
    end
    count
  end

  def reminder_time_label
    return "Sem lembrete" if reminder_time.blank?

    reminder_time.strftime("%H:%M")
  end

  def priority_label
    priority.capitalize
  end

  private

  def set_defaults
    self.frequency_per_week ||= 7
    self.priority ||= "media"
    self.active = true if active.nil?
  end
end