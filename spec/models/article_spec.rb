require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      article = Article.new(title: 'Sample Title', content: 'Sample content')
      expect(article).to be_valid
    end

    it 'is not valid without a title' do
      article = Article.new(title: nil, content: 'Sample content')
      expect(article).to_not be_valid
    end

    it 'is valid without content' do
      article = Article.new(title: 'Sample Title', content: nil)
      expect(article).to be_valid
    end
  end
end
