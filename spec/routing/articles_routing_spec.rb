require 'rails_helper'

RSpec.describe ArticlesController, :type => :routing do
  describe "routing" do
    it "routes to articles #index" do
      expect(:get => "/articles").to route_to("articles#index")
    end

    it "routes to articles #show" do
      expect(:get => "/articles/1").to route_to("articles#show", :id => "1")
    end

    it "routes to articles #create" do
      expect(:post => "/articles").to route_to("articles#create")
    end

    it "routes to articles #update" do
      expect(:put => "/articles/1").to route_to("articles#update", :id => "1")
    end

    it "routes to articles #destroy" do
      expect(:delete => "articles/1").to route_to("articles#destroy", :id => "1")
    end
  end
end