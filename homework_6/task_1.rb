# frozen_string_literal: true

require 'socket'
require 'cgi' # need to parse URI

BALANCE = 'balance.txt'
START_BALANCE = 100.0
STYLE = "style='font-size:30px; text-align:center; margin-top:10%'"
START_PAGE = "<p #{STYLE}> Hi! It's a start page. Enter one of the following commands:<br>" \
"\n <br> <b>/balance</b> - to check your balance" \
"\n <br> <b>/deposit?value=amount</b> - to deposit the <b>amount</b> on your balance" \
"\n <br> <b>/withdraw?value=amount</b> - to withdraw the <b>amount</b> from your balance" \
"\n </p> \n"

# Main class
class App
  def self.init
    File.write(BALANCE, START_BALANCE) unless File.exist?(BALANCE)
    balance = File.read(BALANCE).to_f
    cash_machine = CashMachine.new(balance)

    # Server 
    server = TCPServer.open('0.0.0.0', 3002)
    while connection = server.accept
      request = connection.gets
      method, path = request.split(' ')

      uri = URI(path) # URI is a path-working module

      case uri.path
      when '/balance'
        result = "<p #{STYLE}> Hello! Your balance is #{cash_machine.balance} </p>"
      when '/deposit'
        params = CGI.parse(uri.query)
        amount = params['value'].first.to_i
        status = cash_machine.deposit(amount)
        case status
        when 1
          File.write(BALANCE, cash_machine.balance)
          result = "<p #{STYLE}> You've made a deposit. Your current balance is #{cash_machine.balance} </p>"
        when 0
          result = "<p #{STYLE}> Wrong value! You may only enter a number > 0 </p>"
        end
      when '/withdraw'
        params = CGI.parse(uri.query)
        amount = params['value'].first.to_i
        status = cash_machine.withdraw(amount)
        case status
        when 1
          File.write(BALANCE, cash_machine.balance)
          result = "<p #{STYLE}> You've made a withdrawal. Your current balance is #{cash_machine.balance} </p>"
        when 0
          result = "<p #{STYLE}> Wrong value! You may only enter a number > 0 </p>"
        when -1
          result = "<p #{STYLE}> Your withdrawal amount should be less than #{cash_machine.balance} > 0 </p>"
        end
      else
        result = START_PAGE
      end

      connection.print "HTTP/1.1 200\r\n"
      connection.print "Content-Type: text/html\r\n"
      connection.print "\r\n"
      connection.print result

      connection.close
    end
  end
end

# Cash machine class
class CashMachine
  attr_accessor :balance

  def initialize(balance)
    @balance = balance
  end

  def deposit(amount)
    if amount.positive?
      @balance += amount
      1
    else
      0
    end
  end

  def withdraw(amount)
    if amount.positive?
      if amount <= @balance
        @balance -= amount
        1
      else
        -1
      end
    else
      0
    end
  end
end

App.init
