require 'rspec'
require './task_1.rb'

RSpec.describe 'Task_1' do
  it "returns the 'studying message' if user's age is under 18" do
    expect(greeting(17)).to eq('Your age is under 18, ' \
    "but it's never early to start your studying as a programmer!")
  end

  it "returns the 'job message' if user's age is over 18" do
    expect(greeting(20)).to eq("Let's get down to business!")
  end
end
