def input_students
   puts "Please enter the names and cohorts of the students"
   puts "Please enter in the format: name, cohort"
   puts "To finish, just hit return twice"
   students = []
   name_and_cohort = gets.chomp
   while !name_and_cohort.empty? do
      while !name_and_cohort.include?(",")
         puts "Please use the format: name,cohort (with a \",\")"
         name_and_cohort = gets.chomp
      end
      name = name_and_cohort.split(",")[0]
      cohort = name_and_cohort.split(",")[1].capitalize
      # Why do I need this capitalize here??
      cohort = cohort[1..-1].capitalize if cohort[0] == " "
      students << {name: name, cohort: cohort}
      if students.count == 1
         puts "We now have 1 student"
      else
         puts "We now have #{students.count} students"
      end
      name_and_cohort = gets.chomp
   end
   students
end

def cohorts(students)
   cohort_months = students.map {|x| x[:cohort]}.uniq
end

def print_header
   puts "The students of Villains Academy"
   puts "--------------"
end

def print(students, cohort_months)
   cohort_months.each do |month|
      students.each_with_index do |student, index|
         # Or you can use student["name"] if your hash was set up like so:
         # "name" => "Darth Vader", etc. (Two ways of doing it)
         if student[:cohort] == month
            puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
         end
      end
   end
end

def print_footer(names)
   if names.count == 1
      puts "Our grand total is 1 villainous student!"
   else
      puts "Overall, we have #{names.count} villainous students."
   end
end

students = input_students
print_header
cohort_months = cohorts(students)
print(students, cohort_months)
print_footer(students)