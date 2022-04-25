# frozen_string_literal: true

BALANCE = 'balance.txt'
START_BALANCE = 100.0
COMMANDS = "Available commands: \n Enter 'D' to deposit money" \
"\n Enter 'W' to withdraw money \n Enter 'B' to check your balance" \
"\n Enter 'Q' to quit \n"

# Main class
class App
  def self.init
    File.write(BALANCE, START_BALANCE) unless File.exist?(BALANCE)
    balance = File.read(BALANCE).to_f
    cash_machine = CashMachine.new(balance)
    cash_machine.show_balance

    command = ''
    print COMMANDS
    loop do
      print 'Enter your next command: '
      command = gets.chomp
      if %w[D d].include?(command) # %w[D d] = ['D', 'd'] - rubocop's will
        cash_machine.deposit
      elsif %w[W w].include?(command)
        cash_machine.withdraw
      elsif %w[B b].include?(command)
        cash_machine.show_balance
      elsif %w[Q q].include?(command)
        cash_machine.quit
        break
      else
        cash_machine.wrong_command
      end
    end
  end
end

# Cash machine class
class CashMachine
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def show_balance
    puts("Your current balance is #{@balance} \n")
  end

  def deposit
    print 'Please, enter your amount > 0 : '
    amount = gets.to_f
    if amount.positive?
      @balance += amount
      show_balance
    else
      puts('Wrong value! You may only enter a number > 0')
    end
    @balance
  end

  def withdraw
    print 'Please, enter your amount > 0 : '
    amount = gets.to_f
    if amount.positive?
      if amount <= @balance
        @balance -= amount
        show_balance
      else
        print "Your withdrawal amount should be less than #{@balance} \n"
      end
    else
      puts('Wrong value! You may only enter a number > 0')
    end
    @balance
  end

  def quit
    show_balance
    File.write(BALANCE, balance)
  end

  def wrong_command
    print 'Wrong command! '
    print COMMANDS
  end
end

App.init
