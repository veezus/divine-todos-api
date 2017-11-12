require 'rails_helper'

RSpec.describe TodosController, type: :controller do

  context "when unauthenticated" do
    context "and POSTing to /todos" do
      context "and valid params" do
        let(:params) { { todo: { title: 'Do a thing' } } }

        it "creates a global todo" do
          expect do
            post :create, params: params
          end.to change(Todo, :count).by(1)

          todo = Todo.last
          expect(todo.title).to eq 'Do a thing'

          expect(response.status).to eq 200
          expect(response.body).to include %q("title":"Do a thing")
        end
      end

      context "and invalid params" do
        let(:params) { { todo: { foo: 'bear' } } }

        it "returns an error" do
          expect do
            post :create, params: params
          end.to change(Todo, :count).by(0)

          expect(response.status).to eq 422
        end
      end
    end
  end
end
