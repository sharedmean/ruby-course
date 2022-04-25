# frozen_string_literal: true

STUDENTS_LIST_PATH = 'students_1.txt'
BUFFER = 'buffer.txt'

def index
  File.foreach(STUDENTS_LIST_PATH) { |student| puts student }
end

def find(id)
  File.foreach(STUDENTS_LIST_PATH).with_index do |student, index|
    @student_info = student if index.to_i == id
  end
  puts @student_info
end

def where(pattern)
  @index_array = []
  File.foreach(STUDENTS_LIST_PATH).with_index do |student, index|
    @index_array.push(index) if student.include?(pattern)
  end
  puts @index_array
end

def update(id, text)
  buffer = File.open(BUFFER, 'w')
  File.foreach(STUDENTS_LIST_PATH).with_index do |student, index|
    buffer.puts(id == index ? text : student)
  end

  buffer.close
  File.write(STUDENTS_LIST_PATH, File.read(BUFFER))
  File.delete(BUFFER) if File.exist?(BUFFER)
  index
end

def delete(id)
  buffer = File.open(BUFFER, 'w')
  File.foreach(STUDENTS_LIST_PATH).with_index do |student, index|
    buffer.puts(student) if id != index
  end

  buffer.close
  File.write(STUDENTS_LIST_PATH, File.read(BUFFER))

  File.delete(BUFFER) if File.exist?(BUFFER)
  index
end


where('Anna')