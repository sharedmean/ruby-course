# frozen_string_literal: true

require 'rspec'
require './task_1'

RSpec.describe 'Students management' do
  let(:string) do
    <<~STRING
      Anna Ivanova
      Oleg Pirogov
      Anna Orlova
    STRING
  end

  before { File.write(STUDENTS_LIST_PATH, string) }

  it '#index' do
    expect { index }.to output(string).to_stdout
  end
  it '#find' do
    expect { find(1) }.to output("Oleg Pirogov\n").to_stdout
  end
  it '#where' do
    expect { where('Anna') }.to output("0\n2\n").to_stdout
  end
  it '#update' do
    expect { update(2, 'Anna Kotova') }.to output("Anna Ivanova\nOleg Pirogov\nAnna Kotova\n").to_stdout
  end
  it '#delete' do
    expect { delete(1) }.to output("Anna Ivanova\nAnna Orlova\n").to_stdout
  end
end
