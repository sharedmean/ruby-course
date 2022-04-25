# frozen_string_literal: true

STUDENTS_LIST_PATH = 'students.txt'
RESULT = 'result.txt'

def read_file(name)
  file_data = File.read(name).split("\n")
  puts(file_data)
  file_data
end

def find_students(students, age)
  result = File.open(RESULT, 'a')
  copy = students.clone
  students.each do |student|
    if student.slice(student.size - 2, student.size) == age.to_s
      result.puts(student)
      copy.delete(student)
    end
  end
  result.close
  copy
end

file_data = read_file(STUDENTS_LIST_PATH)
loop do
  print "Enter students' age. If you wanna stop, enter '0' -> "
  age = gets.to_i
  break if age == -1

  file_data = find_students(file_data, age)
  break if file_data.empty?
end
file_data = read_file(RESULT)
File.delete(RESULT) if File.exist?(RESULT)
