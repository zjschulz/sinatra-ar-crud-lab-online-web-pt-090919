
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  #CREATE
  
  get '/articles/new' do
    erb :new
  end
  
  post '/articles' do
    @abc = Article.create(title: params[:title], content: params[:content])
    @abc.save
    #This controller action should use the Create CRUD action to create the article and save it to the database
    redirect "/articles/#{@abc.id}"
  end
  
  #READ 
  
  get '/articles' do
    #This action should use Active Record to grab all of the articles and store them in an instance variable, @articles. Then, it should render the index.erb view. That view should use ERB to iterate over @articles and render them on the page.
    @articles = Article.all
    erb :index
  end
  
  get '/articles/:id' do
    #This action should use Active Record to grab the article with the id that is in the params and set it equal to @article. Then, it should render the show.erb view page. That view should use ERB to render the @article's title and content.
    @articles = Article.find(params[:id])
    erb :show
  end
  
  #UPDATE 
  
  get '/articles/:id/edit' do
    #that renders the view, edit.erb. This view should contain a form to update a specific article and POSTs to a controller action, patch '/articles/:id'
    @articles = Article.find(params[:id])
    erb :edit
  end
   
  patch '/articles/:id' do 
    #will find the instance of the model to update, using the id from params, update and save that instance.
    article = Article.find(params[:id])
    article.title = params["title"] unless params["title"].empty?
    article.content = params["content"] unless params["content"].empty?
    article.save
    article.update
  end
  
  #DELETE 
  
  delete '/articles/:id' do
    article = Article.find(params[:id])
    article.destroy
  end
  
end
