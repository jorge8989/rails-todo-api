describe 'Todo', type: :model do
  describe 'Validations' do
    let(:todo) { create(:todo) }
    it { expect(todo).to validate_presence_of(:text) }
  end
end