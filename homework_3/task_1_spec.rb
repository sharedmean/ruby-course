# frozen_string_literal: true

require 'rspec'
require './task_1'

RSpec.describe 'Task_1' do
  it "returns '2' raised to the power of line's size" do
    expect(func('dspCS')).to eq(32)
  end
  it 'returns reversed line' do
    expect(func('fgsp')).to eq('psgf')
  end
end
