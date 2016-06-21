def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit enter twice"
    # create an empty array
    students = []
    name=gets.chomp
    # while the name is not empty, repeat this code
    while !name.empty? do
        # add the student hash to the array
        students << {name: name, cohort: :november}
        puts "Now we have #{students.count} students"
        # get another name from the user
        name = gets.chomp
    end
# return the array of students
students
end
    
def print_header
  puts "The students of Villians Academy"
  puts "-------------"
end

def print(students)
    students.each_with_index do |student, i|
    if student [:name].length < 12
      puts "#{i+1}. #{student [:name]} (#{student[:cohort]} cohort)"
  end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students

#nothing happens until we call the methods
print_header
print(students)
print_footer(students)
