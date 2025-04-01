require_relative 'spec_helper'

RSpec.describe 'main.rb' do
  let(:output_path) { File.join(__dir__, '..', 'data', 'output.json') }
  let(:expected_output_path) { File.join(__dir__, '..', 'data', 'expected_output.json') }
  let(:output_content) { File.read(output_path) }
  let(:expected_content) { File.read(expected_output_path) }
  let(:output_json) { JSON.parse(output_content) }
  let(:expected_json) { JSON.parse(expected_content) }

  it 'generates output.json matching expected_output.json' do
    expect(output_json).to eq(expected_json)
  end
end
