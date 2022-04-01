def foobar(a, b)
  a == 20 || b == 20 ? 20 : a + b
end

print 'Enter the first number: '
a = gets.to_i
print 'Enter the second number: '
b = gets.to_i
puts foobar(a, b)
