habits = [ "Meditar", "Exercitar", "Ler 30 min", "Beber 2L de agua" ]
habits.each do |name|
  h = Habit.create!(name: name)
  3.times { |i| h.completions.create!(completed_on: Date.today - i.days) }
end
