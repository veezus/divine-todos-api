require 'rails_helper'

RSpec.describe TodosController, type: :controller do

  context "when unauthenticated" do
    context "and POSTing to /todos" do
      context "and valid params" do
        let(:params) { { todo: { title: 'Do a thing' } } }

        it "creates a global todo" do
          expect{ post :create, params: params }.to change(Todo, :count).by(1)

          todo = Todo.last
          expect(todo.title).to eq 'Do a thing'

          expect(response.status).to eq 200
          expect(response.body).to include %q("title":"Do a thing")
        end
      end

      context "and invalid params" do
        let(:params) { { todo: { foo: 'bear' } } }

        it "returns an error" do
          expect{ post :create, params: params }.to change(Todo, :count).by(0)

          expect(response.status).to eq 422
        end
      end
    end

    context "and PATCHing to /todos/check" do
      let(:todo) { create :todo }
      let(:params) { { id: todo.id } }

      it "tells the todo to check itself" do
        allow(controller).to receive(:todo) { todo }
        expect(todo).to receive(:check!)

        post :check, params: params
      end
    end

    context "and PATCHing to /todos/uncheck" do
      let(:todo) { create :todo }
      let(:params) { { id: todo.id } }

      it "tells the todo to uncheck itself" do
        allow(controller).to receive(:todo) { todo }
        expect(todo).to receive(:uncheck!)

        post :uncheck, params: params
      end
    end
  end
end
