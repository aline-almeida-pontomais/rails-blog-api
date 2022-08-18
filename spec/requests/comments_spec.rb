require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before(:each) do
    @article_attributes = FactoryBot.attributes_for(:article)
    post articles_path, params: { article: @article_attributes }
    @article_id = Article.last.id
  end

  describe "GET /comments" do
    before(:each) do
      comments_url = "/articles/#{@article_id}/comments"
      get comments_url
    end

    it "returns success status" do
      expect(response).to have_http_status(200)
    end

    it "returns the correct message for loaded comments" do
      expect(response.body).to match(/Comentários carregados./)
    end
  end

  describe "GET /comments/comment" do
    before(:each) do
      all_comments_url = "/articles/#{@article_id}/comments"

      comment = build(:comment)
      comment_attributes = FactoryBot.attributes_for(:comment)

      post all_comments_url, params: {comment: comment_attributes}

      comment_url = "/articles/#{@article_id}/comments/#{Comment.last.id}"
      get comment_url
    end

    it "returns success status to show a single article" do
      expect(response).to have_http_status(200)
    end 

    it "returns the correct message for a single loaded comment" do
      expect(response.body).to match(/Comentário carregado./)
    end
  end

  describe "POST /comments" do
    context "when it has all valid (optionals) parameters" do
      before(:each) do
        comments_url = "/articles/#{@article_id}/comments"
        @comment_attributes = FactoryBot.attributes_for(:comment)
        post comments_url, params: { comment: @comment_attributes }
      end

      it "creates the comment with the correct attributes" do
        expect(Comment.last).to have_attributes(@comment_attributes)
      end

      it 'return the status code 200 - success' do
        expect(response).to have_http_status(200)
      end

      it "returns the correct message for created article" do
        expect(response.body).to match(/Comentário criado com sucesso./)
      end
    end
  end

  describe 'DELETE /comments' do
    context 'when the comment exists' do

      before(:each) do
        comments_url = "/articles/#{@article_id}/comments"
        @comment_attributes = FactoryBot.attributes_for(:comment)
  
        post comments_url, params: { comment: @comment_attributes }
  
        comment_id = Comment.last.id
        delete "/#{comments_url}/#{comment_id}"
      end

      it 'returns status code 200 - success' do 
        expect(response).to have_http_status(200)
      end

      it "returns the correct message for deleted comment" do
        expect(response.body).to match(/Comentário excluído com sucesso./)
      end

      it 'destroy the record' do
        comment = build(:comment)
        expect{comment.reload}.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
