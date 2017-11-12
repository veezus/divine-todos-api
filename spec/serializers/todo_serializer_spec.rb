require 'rails_helper'

describe TodoSerializer do
  let(:todo) { create :checked_todo }
  let(:serialized) do
    ActiveModelSerializers::Adapter.create \
      TodoSerializer.new todo
  end
  let(:json) { serialized.to_json }
  let(:data) do
    HashWithIndifferentAccess.new(JSON.parse(json))[:data]
  end

  it 'serializes a todo' do
    attributes = data[:attributes]

    expect(data[:id]).to eq todo.id.to_s
    expect(attributes.keys).to contain_exactly('title', 'checked')
    expect(attributes[:title]).to start_with 'An arbitrary todo'
    expect(attributes[:checked]).to eq true
  end
end
