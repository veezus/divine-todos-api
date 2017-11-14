require 'rails_helper'

RSpec.describe Todo, type: :model do
  it { should validate_presence_of :title }

  it "knows if it is checked" do
    todo = build :checked_todo
    expect(todo.checked?).to eq true
  end

  describe ".by_checked" do
    let!(:checked) { create :checked_todo }
    let!(:unchecked) { create :todo }

    it "returns checked todos" do
      expect(Todo.by_checked(true)).to contain_exactly checked
    end

    it "returns unchecked todos by default" do
      expect(Todo.by_checked).to contain_exactly unchecked
    end
  end

  describe "#check!" do
    context "when checked" do
      it "preserves checked_at" do
        a_while_ago = 5.seconds.ago
        todo = create :checked_todo, checked_at: a_while_ago

        todo.check!

        expect(todo.checked_at).to eq a_while_ago
      end
    end

    context "when unchecked" do
      it "sets checked_at" do
        todo = create :todo
        fail "Expected an unchecked todo" if todo.checked?

        expect{ todo.check! }.to change(todo, :checked_at)
        expect(todo).to be_checked
      end
    end
  end

  describe "#uncheck!" do
    context "when checked" do
      it "clears checked_at" do
        todo = create :checked_todo
        fail "Expected a checked todo" unless todo.checked?

        expect{ todo.uncheck! }.to change(todo, :checked_at)
        expect(todo).to_not be_checked
      end
    end
  end
end
