# frozen_string_literal: true

def func(pokemon_count)
  pokemons = []
  pokemon_count.times do |_i|
    print "Enter pokemon's name: "
    name = gets.chomp
    print "Enter pokemon's color: "
    color = gets.chomp
    pokemons.push({ name: name, color: color })
  end
  return pokemons
end

print 'How many pokemons are you gonna add? '
pokemon_count = gets.to_i
pokemons = func(pokemon_count)
puts pokemons
