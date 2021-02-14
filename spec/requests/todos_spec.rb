require 'rails_helper'

describe 'Todos API' do

  describe 'GET /api/todos', type: :request do
    it 'should return a list of todos' do
      2.times { create(:todo) }
      get '/api/todos'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'GET /api/todos/:id', type: :request do
    
    it 'should return a single todo' do
      create(:todo)
      get "/api/todos/#{Todo.first.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /api/todos/:id', type: :request do
    it 'should update a todo' do
      create(:todo)
      todo = Todo.first

      expect(todo.text).to eq("do something")
      expect(todo.completed).to eq(false)

      put "/api/todos/#{todo.id}", params: {"text": "Updated text", completed: true}
      expect(response).to have_http_status(:success)

      todo.reload()
      expect(todo.text).to eq("Updated text")
      expect(todo.completed).to eq(true)
    end
  end

  describe 'DELETE /api/todos/:id', type: :request do
    it 'should delete a todo' do
      2.times { create(:todo) }

      expect(Todo.count).to eq(2)
  
      delete "/api/todos/#{Todo.first.id}"
  
      expect(response).to have_http_status(:success)
      expect(Todo.count).to eq(1)
    end
  end
end