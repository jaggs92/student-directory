@students = []

def interactive_menu
   loop do
      print_menu
      process(STDIN.gets.chomp)
   end
end

def print_menu
   puts "1. Input the students"
   puts "2. Show the students"
   puts "3. Save the list to students.csv"
   puts "4. Load the list from students.csv"
   puts "9. Exit"
end

def process(selection)
   case selection
   when "1"
      input_students
   when "2"
      show_students
   when "3"
      save_students
   when "4"
      load_students
   when "9"
      exit
   else
      puts "I didn't catch that. Can you try again please?"
   end
end

def show_students
   print_header
   cohort_months = cohorts
   print_students_list(cohort_months)
   print_footer
end


def input_students
   puts "Please enter the names and cohorts of the students"
   puts "Please enter in the format: name, cohort"
   puts "To finish, just hit return twice"
   @students = []
   name_cohort = STDIN.gets.chomp
   while !name_cohort.empty? do
      while name_cohort.count(",") != 1
         puts "Please use the format: name,cohort (with two \",\"s)"
         name_cohort = STDIN.gets.chomp
      end
      name = name_cohort.split(",")[0]
      cohort = name_cohort.split(",")[1].capitalize || "Unspecified"
      cohort = cohort[1..-1].capitalize if cohort[0] == " "
      @students << {name: name, cohort: cohort}
      if @students.count == 1
         puts "We now have 1 student"
      else
         puts "We now have #{@students.count} students"
      end
      name_cohort = STDIN.gets.chomp
   end
end

def cohorts
   cohort_months = @students.map {|x| x[:cohort]}.uniq
end


def print_header
   linewidth = 100
   puts "The students of Villains Academy".center(50)
   puts "--------------".center(50)
end

def print_students_list(cohort_months)
   linewidth = 100
   puts "Nothing to print yo!" if @students.empty?
   cohort_months.each do |month|
      @students.each_with_index do |student, index|
         if student[:cohort] == month
            puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
         end
      end
   end
end

def print_footer
   linewidth = 100
   puts "--------------".center(50)
   if @students.count == 1
      puts "Our grand total is 1 villainous student!".center(50)
   else
      puts "Overall, we have #{@students.count} villainous students.".center(50)
   end
end

def save_students
   file = File.open("students.csv", "w")
   @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
   end
   file.close
end

def load_students(filename = "students.csv")
   file = File.open(filename, "r")
   @students = []
   file.readlines.each do |line|
      name, cohort = line.chomp.split(",")
      @students << {name: name, cohort: cohort}
   end
   file.close
end

def try_load_students
   filename = ARGV.first
   return if filename.nil?
   if File.exists?(filename)
      load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
   else
      puts "Sorry #{filename} does not exist."
      exit
   end
end

try_load_students
interactive_menu