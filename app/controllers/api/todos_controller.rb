class Api::TodosController < ApplicationController
  def index
    @todos = Todo.all.order(created_at: :asc)
  end

  def show
    @todo = Todo.find(params[:id])
    render json: @todo.to_json
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: @todo.to_json(only: [:text, :id, :completed]), status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    head :ok
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      render json: @todo.to_json(only: [:id, :text, :completed], status: :ok)
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  private
  def todo_params
    params.permit(:text, :completed)
  end
end