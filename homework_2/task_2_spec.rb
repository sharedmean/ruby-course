require 'rspec'
require './task_2.rb'

RSpec.describe 'Task_2' do
  it "returns 20" do
    expect(foobar(20, 9)).to eq(20)
  end

  it "returns 20" do
    expect(foobar(1, 20)).to eq(20)
  end

  it "returns 30" do
    expect(foobar(11, 19)).to eq(30)
  end
end
