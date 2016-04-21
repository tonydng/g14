<h1>Group 14</h1>
<p>https://github.com/tonydng/g14</p>
<h3>Books Database ER</h3>
(https://www.flickr.com/photos/142018434@N08/shares/9yf15z)
<hr>
<h3>Relational Models of Books Database</h3>
(https://www.flickr.com/gp/142018434@N08/ZEC5S1)
<hr>
<p>Use Ruby on rails (https://www.railstutorial.org/book) for UI</p>
<p>$ rails new g14</p>
<p>$ cd g14</p>
<h4>on github create a new repository, g14</h4>
<pre>
	$ git init
	$ git add README.md
	$ git commit -m "first commit"
	$ git remote add origin https://github.com/tonydng/g14.git
	$ git push -u origin master

	$ heroku login ...
	$ heroku create g14
	
</pre>
<h4>Setup heroku for deployment</h4>
<p>Update file config/environments/production.rb</p>
<pre>
	...
	# Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  	config.force_ssl = true
	...
</pre>
<p>$ heroku login</p>
<p>$ heroku create g14</p>
<p>$ git push heroku master</p>
<p>$ heroku run rake db:migrate</p>
<p>$ heroku open</p>
<p>https://g14.herokuapp.com/</p>
<h3>Create Models</h3>
<p>
	Primary keys - By default, Active Record will use an integer column named id as the table's primary key. When using Active Record Migrations to create your tables, this column will be automatically created.
</p>
<p>$ rails g model book book_title</p>
<p>$ rake db:migrate</p>
<p>$ rails g model author author_name</p>
<p>$ rake db:migrate</p>
<p>$ rails g model topic topic_name</p>
<p>$ rake db:migrate</p>
<h4>BooksAuthors and BooksTopics withoud id</h4>
<p>$ rails g model books_authors book:references author:references</p>
<p>update file: db/migrate/xxx_your_num_xxxx_create_books_authors.rb</p>
<pre>
	class CreateBooksAuthors < ActiveRecord::Migration
	  def change
	    create_table :books_authors, id: false do |t|
	      t.references :book, index: true, foreign_key: true
	      t.references :author, index: true, foreign_key: true

	      t.timestamps null: false
	    end
	  end
	end
</pre>
<p>$ rake db:migrate</p>
<p>$ rails g model books_topics book:references topic:references</p>
<p>update file: db/migrate/xxx_your_num_xxxx_create_books_topics.rb</p>
<pre>
	class CreateBooksTopics < ActiveRecord::Migration
	  def change
	    create_table :books_topics, id: false do |t|
	      t.references :book, index: true, foreign_key: true
	      t.references :topic, index: true, foreign_key: true

	      t.timestamps null: false
	    end
	  end
	end
</pre>
<p>$ rake db:migrate</p>
<p>Update Gemfile</p>
<pre>
	source 'https://rubygems.org'

	gem 'rails', '4.2.6'
	gem 'sass-rails', '~> 5.0'
	gem 'uglifier', '>= 1.3.0'
	gem 'coffee-rails', '~> 4.1.0'
	gem 'jquery-rails'
	gem 'turbolinks'
	gem 'jbuilder', '~> 2.0'
	gem 'sdoc', '~> 0.4.0', group: :doc

	gem "twitter-bootstrap-rails"
	# Use sqlite3 as the database for Active Record
	# development and test only
	group :development, :test do 
		gem 'sqlite3'
	end
	group :production do
	  gem 'pg',							'~> 0.17.1'            
	  gem 'rails_12factor',	'~> 0.0.2'
	end

	group :development, :test do
	  gem 'byebug'
	end

	group :development do
	  gem 'web-console', '~> 2.0'
	  gem 'spring'
	end
</pre>
<p>$ bundle update</p>
<h4>Create Views and Controllers</h4>
<p>$ rails g scaffold_controller book book_title</p>
<p>$ rails g scaffold_controller author author_name</p>
<p>$ rails g scaffold_controller book topic_name</p>
<p>Update file config/routes.rb as following:</p>
<pre>
	Rails.application.routes.draw do
	  resources :books
	  resources :authors
	  resources :topics

	  root 'books#index'
	end
</pre>
<p>Install bootstrap for a better UI</p>
<p>$ rails g bootstrap:install static</p>
<p>$ rails g bootstrap:themed books -f</p>
<p>$ rails g bootstrap:themed authors -f</p>
<p>$ rails g bootstrap:themed topics -f</p>
<p>Modify app/controllers/books_controller.rb. So that when a new book created it redirect to root_path (home page)</p>
<pre>
	# POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to root_path, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end
</pre>
<p>update file app/views/books/index.html.erb</p>
<p>https://github.com/tonydng/g14/blob/master/app/views/books/index.html.erb</p>
<p>Select all books from app/controllers/boots_controller.rb</p>
<pre>
	class BooksController < ApplicationController
	  .....

	  # GET /books/new
	  def index
	    @book = Book.find_by_sql("SELECT * from books;")
	  end

	  ....
	end
</pre>