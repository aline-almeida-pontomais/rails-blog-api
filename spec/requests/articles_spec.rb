require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    before(:each) do 
      get articles_path
    end

    it "returns success status" do
      expect(response).to have_http_status(200)
    end

    it "returns the correct message for loaded articles" do
      expect(response.body).to match(/Artigos carregados/)
    end

    it "has the article's title" do
      articles = create_list(:article, 5)
      get articles_path
      articles.each do |article|
        expect(response.body).to include(article.title)
      end
    end
  end


  describe "GET /articles/article" do
    before(:each) do 
      all_articles_url = "/articles"
      article = build(:article)
      article_attributes = FactoryBot.attributes_for(:article)

      post all_articles_url, params: {article: article_attributes}

      article_url = "/articles/#{Article.last.id}"
      get article_url
    end

    it "returns success status to show a single loaded article" do
      expect(response).to have_http_status(200)
    end 

    it "returns the correct message to show a single loaded article" do
      expect(response.body).to match(/Artigo carregado./)
    end
  end

  describe "POST /articles" do
    context "when it has all valid parameters" do
      before(:each) do
        @article_attributes = FactoryBot.attributes_for(:article)
        post articles_path, params: { article: @article_attributes }
      end

      it "creates the article with correct attributes" do
        expect(Article.last).to have_attributes(@article_attributes)
      end

      it 'return the status code 200 - success' do
        expect(response).to have_http_status(200)
      end

      it "returns the correct message for created article" do
        expect(response.body).to match(/Artigo criado com sucesso./)
      end
    end

    context "when it has not all valid parameters" do
      before(:each) do
        @article_attributes = {article: {title: '', body: '', status: ''}}
        post articles_path, params: { article: @article_attributes }
      end

      it 'does not create the article' do
        expect{ 
          post articles_path, params: {article: @article_attributes}
        }.to_not change(Article, :count)
      end

      it 'returns the status 422 - unprocessable_entity' do
        expect(response).to have_http_status(422)
      end

      it "returns the correct message for not created article" do
        expect(response.body).to match(/Não foi possível criar o artigo./)
      end
    end
  end

  describe "PUT /articles" do
    context 'when the article exists' do 
      before(:each) do
        @article = create(:article)
        @article_attributes = FactoryBot.attributes_for(:article)

        put "/articles/#{@article.id}", params: {article: @article_attributes}
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it "returns the correct message for updated article" do
        expect(response.body).to match(/Artigo editado com sucesso./)
      end

      it 'updates the article' do
        expect(Article.last).to have_attributes(@article_attributes)
      end
      
      it 'returns the article updated' do
        json_response = JSON.parse(response.body)
        expect(@article.reload.updated_at).to_not be_nil
      end
    end

    context 'when the article exists and has wrong or invalid parameters' do
      before(:each) do
        article = create(:article)
        article_attributes = {title: "", body: "", status: ""}
        put "/articles/#{Article.last.id}", params: {article: article_attributes} 
      end

      it 'returns the status code 422 - unprocessable_entity' do
        expect(response).to have_http_status(422)
      end

      it "returns the correct message for not created article" do
        expect(response.body).to match(/Não foi possível editar o artigo./)
      end
    end

    context 'when the article does not exist' do
      it 'returns record not found' do
        expect { 
          article_attributes = FactoryBot.attributes_for(:article)
          put '/articles/0', params: {article: article_attributes}
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe 'DELETE /articles' do
    context 'when the article exists' do
      before(:each) do
        @article = create(:article)
        delete "/articles/#{@article.id}"
      end

      it 'returns status code 200 - success' do 
        expect(response).to have_http_status(200)
      end

      it "returns the correct message for deleted article" do
        expect(response.body).to match(/Artigo excluído com sucesso./)
      end

      it 'destroy the record' do
        expect{@article.reload}.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when the article does not exist' do
      it 'returns record not found' do
        expect { 
          article_attributes = FactoryBot.attributes_for(:article)
          delete '/articles/0', params: {article: article_attributes}
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
