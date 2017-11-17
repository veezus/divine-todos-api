class TodosController < ApplicationController
  expose(:todo) { Todo.find_by(id: params[:id]) || Todo.new(create_params) }
  expose(:todos) do
    if checked_param
      Todo.by_checked checked_param
    else
      Todo.all
    end
  end

  def index
    render json: todos
  end

  def create
    if todo.save
      render json: todo
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  def check
    if todo.check!
      render json: todo
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  def uncheck
    if todo.uncheck!
      render json: todo
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.fetch(:todo, {}).permit :title, :checked
  end

  def checked_param
    ActiveRecord::Type::Boolean.new.deserialize params[:checked]
  end
end
