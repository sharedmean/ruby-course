# frozen_string_literal: true

require 'rspec'
require './task_2'

RSpec.describe 'Task_2' do
  it 'returns a pokemon list' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('Pikachu', 'Yellow')

    expect(func(1)).to eq([{ name: 'Pikachu', color: 'Yellow' }])
  end
end
