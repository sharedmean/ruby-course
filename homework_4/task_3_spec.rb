# frozen_string_literal: true

require 'rspec'
require './task_3'

RSpec.describe 'Task_3' do
  it "allows user to make a withdrawal and returns renewed balance" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('W', 50, 'Q')

    expect(withdraw(100)).to eq(50)
  end
end
