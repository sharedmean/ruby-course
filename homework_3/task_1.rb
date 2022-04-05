# frozen_string_literal: true

def func(word)
  size = word.size
  word.slice(size - 2, size) == 'CS' ? 2**size : word.reverse
end

print 'Enter the word: '
word = gets.chomp
puts func(word)
