# frozen_string_literal: true

ENV = 'test'

require 'rspec'
require './task_3'

RSpec.describe 'Task_3' do
  it 'allows user to make a withdrawal and returns renewed balance' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return(50, 170, 'One hundred')

    expect(withdraw(100)).to eq(50)
    expect(withdraw(100)).to eq(100)
    expect(withdraw(100)).to eq(100)
  end

  it 'allows user to make a deposit and returns renewed balance' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return(100, 'One hundred')

    expect(deposit(100)).to eq(200)
    expect(deposit(100)).to eq(100)
  end
end
