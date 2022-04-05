def greeting(age)
  if age < 18
    'Your age is under 18, ' \
    "but it's never early to start your studying as a programmer!"
  else
    "Let's get down to business!"
  end
end

print 'Enter your first name: '
first_name = gets.chomp
print 'Enter your last name: '
last_name = gets.chomp
print 'Enter your age: '
age = gets.to_i
puts "Hi, #{first_name} #{last_name}! " + greeting(age)
