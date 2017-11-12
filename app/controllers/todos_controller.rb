class TodosController < ApplicationController
  expose(:todo) { Todo.new(create_params) }

  def create
    if todo.save
      render json: todo
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.fetch(:todo, {}).permit :title, :checked
  end
end
