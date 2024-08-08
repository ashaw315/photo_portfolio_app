require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:portfolio) { FactoryBot.create(:portfolio) }

  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:portfolio) }
  end

  context "validations" do
    it "is valid with valid attributes" do
      article = Article.new(title: "Valid Title", content: "This is valid content.", user: user, portfolio: portfolio)
      expect(article).to be_valid
    end

    it "is not valid without a title" do
      article = Article.new(title: nil, content: "Content without a title.", user: user, portfolio: portfolio)
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("can't be blank")
    end

    it "is not valid without content" do
      article = Article.new(title: "Title without content", content: nil, user: user, portfolio: portfolio)
      expect(article).not_to be_valid
      expect(article.errors[:content]).to include("can't be blank")
    end

    it "is not valid with a title shorter than 3 characters" do
      article = Article.new(title: "No", content: "Short title test.", user: user, portfolio: portfolio)
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("is too short (minimum is 3 characters)")
    end

    it "is not valid without a user" do
      article = Article.new(title: "Valid Title", content: "Valid content", portfolio: portfolio)
      expect(article).not_to be_valid
      expect(article.errors[:user]).to include("must exist")
    end

    it "is not valid without a portfolio" do
      article = Article.new(title: "Valid Title", content: "Valid content", user: user)
      expect(article).not_to be_valid
      expect(article.errors[:portfolio]).to include("must exist")
    end
  end
end
