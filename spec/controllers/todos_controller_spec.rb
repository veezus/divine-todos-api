require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  context "when unauthenticated" do

    context "and GETting /todos" do
      it "fetches unchecked todos when checked is '0'" do
        expect(Todo).to receive(:by_checked).with(false)
        get :index, params: { checked: '0' }
      end

      it "fetches unchecked todos when checked is 'false'" do
        expect(Todo).to receive(:by_checked).with(false)
        get :index, params: { checked: 'false' }
      end

      it "fetches unchecked todos when checked is nil" do
        expect(Todo).to receive(:by_checked).with(nil)
        get :index
      end

      it "fetches checked todos when checked is '1'" do
        expect(Todo).to receive(:by_checked).with(true)
        get :index, params: { checked: '1' }
      end

      it "fetches checked todos when checked is 'true'" do
        expect(Todo).to receive(:by_checked).with(true)
        get :index, params: { checked: 'true' }
      end
    end

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
