# frozen_string_literal: true

BALANCE = 'balance.txt'
START_BALANCE = 100.0
COMMANDS = "Available commands: \n Enter 'D' to deposit money" \
"\n Enter 'W' to withdraw money \n Enter 'B' to check your balance" \
"\n Enter 'Q' to quit \n"

def deposit(balance)
  print 'Please, enter your amount > 0 : '
  amount = gets.to_f
  if amount.positive?
    balance += amount
    print "Your current balance is #{balance} \n"
  else
    puts('Wrong value! You may only enter a number > 0')
  end
  balance
end

def withdraw(balance)
  print 'Please, enter your amount > 0 : '
  amount = gets.to_f
  if amount.positive?
    if amount <= balance
      balance -= amount
      print "Your current balance is #{balance} \n"
    else
      print "Your withdrawal amount should be less than #{balance} \n"
    end
  else
    puts('Wrong value! You may only enter a number > 0')
  end
  balance
end

File.write(BALANCE, START_BALANCE) unless File.exist?(BALANCE)
balance = File.read(BALANCE).to_f
puts("Hello! Your current balance is #{balance} \n")
command = ''
print COMMANDS
loop do
  print 'Enter your next command: '
  command = gets.chomp
  if %w[D d].include?(command) # %w[D d] = ['D', 'd'] - rubocop's will
    balance = deposit(balance)
  elsif %w[W w].include?(command)
    balance = withdraw(balance)
  elsif %w[B b].include?(command)
    print "Your current balance is #{balance} \n"
  elsif %w[Q q].include?(command)
    print "Your current balance is #{balance}. Have a nice day! \n"
    File.write(BALANCE, balance)
    break
  else
    print 'Wrong command! '
    print COMMANDS
  end
end
