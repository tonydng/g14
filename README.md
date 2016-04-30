<h1>Group 14 Contribution:</h1>
<pre>
	Dena Tapia: Book ER Design, Book Database model normalization, SQL Query scripts (create, insert, select), Deliverable 1 and Tested the whole UI to make sure that it will work as design.

	James Stokke: Book ER Design, Book Database model normalization, SQL Query scripts (create, insert, select) and Tested the whole UI to make sure that it will work as design.

	Tony Nguyen: Book ER Design, Book Database model normalization, SQL Query scripts (create, insert, select) and used the Ruby on Rails to create an UI that integrates our book database models to a web application.

	Patrick Graham: Book ER Design, Book Database model normalization, SQL Query scripts (create, insert, select), Deliverable 2 and created Demo Video
</pre>
<h3><a href="https://www.flickr.com/photos/142018434@N08/26039229884/in/shares-ghKouH/">Book Database Entity Relationship</a></h3>
<hr>
<h3>Book Database Models</h3>
![alt tag](https://s3-eu-west-1.amazonaws.com/gallery-prod-4f50/img/6ee2f2b471494d3ca2314545a6cae40b.png)
<hr>
<p>Use <a href="https://www.railstutorial.org/book">Ruby on rails Tutorial</a> for UI</p>
<p>We assume that you already had <a href="https://github.com/">github.com account</a>, <a href="https://www.heroku.com/">heroku.com account</a> and <a href="http://rubyonrails.org/">Ruby on Rails</a> installing in your PC/Mac</p>

<h4>INSTRUCTIONS:</h4>

<p>$ rails new g14</p>
<p>$ cd g14</p>
<p>$ rails s</p>
<p>open a new browser at http://localhost:3000 to test this website</p>

<h3>Create Models (Database Tables)</h3>
<p>
	Primary keys - By default, Active Record will use an integer column named id as the table's primary key. When using Active Record Migrations to create your tables, this column will be automatically created.
</p>
<p><b>Note: </b>We use sqlite3 database for development and postgresql database for production on Heroku</p>
<h4>Create Publisher Model</h4>
<p>$ rails g model publisher name location</p>
<p>$ rake db:migrate</p>
<p>After 2 above commands, Rails will run automatically an equivalent query behind the scenes for us:</p>
<pre>
	 CREATE TABLE "publishers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "location" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
</pre>

<pre>
	<h2 style="color: red;">Start over:</h2>
	If you did something wrong, you can start over as the following:
	$ rails destroy model publisher
	$ rails destroy model foo
	$ rails destroy scaffold_controller foo 
</pre>

<h4>Create Topic Model</h4>
<p>$ rails g model topic topic_name</p>
<p>$ rake db:migrate</p>
<p>Similarly, after 2 above commands, Rails will run automatically an equivalent query behind the scenes for us:</p>
<pre>
	 CREATE TABLE "topics" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "topic_name" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
</pre>

<h4>Create Author Model</h4>
<p>$ rails g model author author_name</p>
<p>$ rake db:migrate</p>
<p>Similarly, after 2 above commands, Rails will run automatically an equivalent query behind the scenes for us:</p>
<pre>
	 CREATE TABLE "authors" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "author_name" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
</pre>

<h4>Create Book Model</h4>
<p>$ rails g model book book_name references:publisher references:topic</p>
<p>$ rake db:migrate</p>
<p>Similarly, after 2 above commands, Rails will run automatically an equivalent query behind the scenes for us:</p>
<pre>
	CREATE TABLE "books" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "book_name" varchar, "publisher_id" integer, "topic_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
</pre>

<h4>Create BookAuthor Model</h4>
<p>$ rails g model book_author book:references author:references</p>
<p>$ rake db:migrate</p>
<p>Similarly, after 2 above commands, Rails will run automatically an equivalent query behind the scenes for us:</p>
<pre>
	CREATE TABLE "book_authors" ("book_id" integer, "author_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
</pre>

<h4>Validations</h4>

<p>Update file app/models/book.rb</p>
<pre>
	class Book < ActiveRecord::Base
	  belongs_to :publisher
	  belongs_to :topic
	  has_many :book_authors, dependent: :destroy
	  has_many :authors, through: :book_authors
	  
	  # a book must have a publisher and a topic
	  validates :publisher_id, :topic_id, presence: true
	  # a book must have a book name
	  validates :book_name, presence: true
	end
</pre>

<p>Update file app/models/author.rb</p>
<pre>
  class Author < ActiveRecord::Base
    has_many :book_authors, dependent: :destroy
    has_many :books, through: :book_authors
    
    validates :author_name, presence: true
  end
</pre>

<p>Update file app/models/publisher.rb</p>
<pre>
  class Publisher < ActiveRecord::Base
    has_many :books, dependent: :destroy
    validates :name, presence: :true
  end
</pre>

<p>Update file app/models/topic.rb</p>
<pre>
  class Topic < ActiveRecord::Base
    has_many :books, dependent: :destroy
    validates :topic_name, presence: true
  end
</pre>

<p>Update file app/models/book_author.rb</p>
<pre>
  class BookAuthor < ActiveRecord::Base
    belongs_to :book
    belongs_to :author

    validates :book_id, presence: true
    validates :author_id, presence: true
  end
</pre>

<h4>Insert data into tables</h4>
<p>Update seed file on db/seeds.rb</p>
<pre>
	# insert data into publishers
	Publisher.create(name: "Scribner", location: "New York")
	Publisher.create(name: "World Library Classics", location: "California")
	Publisher.create(name: "Vintage", location: "New York")
	Publisher.create(name: "Addison-Wesley Proffesional", location: "New York")
	Publisher.create(name: "Apress", location: "New York")
	Publisher.create(name: "Wiley", location: "New Jersey")
	Publisher.create(name: "Thomas & Mercer", location: "Washington")
	Publisher.create(name: "Penguin Books", location: "UK")
	Publisher.create(name: "Fairy Tale Review Press", location: "Arizona")
	Publisher.create(name: "Random House Trade Paperbacks", location: "New York")

	# insert data into topics
	Topic.create(topic_name: "Fiction")
	Topic.create(topic_name: "Computer Science")
	Topic.create(topic_name: "Physical Science")
	Topic.create(topic_name: "Math")
	Topic.create(topic_name: "Travel")

	# insert data into authors
	Author.create(author_name: "Scott Fitzgerald")
	Author.create(author_name: "Tom McCarthy")
	Author.create(author_name: "Stephen G. Kochan")
	Author.create(author_name: "Clare Churcher")
	Author.create(author_name: "Karl F. Kuhn")
	Author.create(author_name: "Mark Ryan")
	Author.create(author_name: "Ian Fleming")
	Author.create(author_name: "Joy Williams")

	# insert data into books
	Book.create(book_name: "The Great Gatsby", publisher_id: 1, topic_id: 1)
	Book.create(book_name: "The Beautiful and Damned:  A Twentieht Century Classic", publisher_id: 2, topic_id: 1)
	Book.create(book_name: "C", publisher_id: 3, topic_id: 2)
	Book.create(book_name: "Programming in C (4th Edition) (Developer's Library)", publisher_id: 4, topic_id: 2)
	Book.create(book_name: "Beginning Database Design: From Novice to Professional", publisher_id: 5, topic_id: 2)
	Book.create(book_name: "Basic Physics: A Self-Teaching Guide", publisher_id: 6, topic_id: 3	)
	Book.create(book_name: "Calculus for Dummies", publisher_id: 6, topic_id: 4)
	Book.create(book_name: "Moonraker", publisher_id: 7, topic_id: 1)
	Book.create(book_name: "Dr. No", publisher_id: 7, topic_id: 1)
	Book.create(book_name: "Quantum of Solace: The Complete James Bond Short Stories", publisher_id: 8, topic_id: 1)
	Book.create(book_name: "The Changeling", publisher_id: 9, topic_id: 1)
	Book.create(book_name: "The Florida Keys: A History & Guide Tenth Edition", publisher_id: 10, topic_id: 5)

	# insert data into join table, book_authors
	BookAuthor.create(book_id: 1, author_id: 1)
	BookAuthor.create(book_id: 2, author_id: 1)
	BookAuthor.create(book_id: 3, author_id: 2)
	BookAuthor.create(book_id: 4, author_id: 3)
	BookAuthor.create(book_id: 5, author_id: 4)
	BookAuthor.create(book_id: 6, author_id: 5)
	BookAuthor.create(book_id: 7, author_id: 6)
	BookAuthor.create(book_id: 8, author_id: 7)
	BookAuthor.create(book_id: 9, author_id: 7)
	BookAuthor.create(book_id: 10, author_id: 7)
	BookAuthor.create(book_id: 11, author_id: 8)
	BookAuthor.create(book_id: 12, author_id: 8)
</pre>

<p>$ rake db:seed</p>
<p>After this command, Rails automatically create a query SQL behind the scenes for us:</p>
<pre>
	INSERT INTO 
	"publishers" 
	("name", "location", "created_at", "updated_at") 
	VALUES 
	("Scribner", "New York", "2016-04-26 02:17:10.808633", "2016-04-26 02:17:10.808633"),
	("World Library Classics", "California", "2016-04-26 02:17:10.814413", "2016-04-26 02:17:10.814413"),
	("Vintage", "New York", "2016-04-26 02:17:10.816752", "2016-04-26 02:17:10.816752"),
	("Addison-Wesley Proffesional", "New York", "2016-04-26 02:17:10.818188", "2016-04-26 02:17:10.818188"),
	("Apress", "New York", "2016-04-26 02:17:10.819607", "2016-04-26 02:17:10.819607"),
	("Wiley", "New Jersey", "2016-04-26 02:17:10.821240", "2016-04-26 02:17:10.821240"),
	("Thomas & Mercer", "Washington", "2016-04-26 02:17:10.822752", "2016-04-26 02:17:10.822752"),
	("Penguin Books", "UK", "2016-04-26 02:17:10.824207", "2016-04-26 02:17:10.824207"),
	("Fairy Tale Review Press", "Arizona", "2016-04-26 02:17:10.825581", "2016-04-26 02:17:10.825581"),
	("Random House Trade Paperbacks", "New York", "2016-04-26 02:17:10.826885", "2016-04-26 02:17:10.826885");

	INSERT INTO 
	"topics" 
	("topic_name", "created_at", "updated_at") 
	VALUES 
	("Fiction", "2016-04-26 02:17:10.831588", "2016-04-26 02:17:10.831588"),
	("Computer Science", "2016-04-26 02:17:10.833334", "2016-04-26 02:17:10.833334"),
	("Physical Science", "2016-04-26 02:17:10.834665", "2016-04-26 02:17:10.834665"),
	("Math", "2016-04-26 02:17:10.836147", "2016-04-26 02:17:10.836147"),
	("Travel", "2016-04-26 02:17:10.837714", "2016-04-26 02:17:10.837714");

	INSERT INTO 
	"authors" 
	("author_name", "created_at", "updated_at") 
	VALUES 
	("Scott Fitzgerald", "2016-04-26 02:17:10.842127", "2016-04-26 02:17:10.842127"),
	("Tom McCarthy", "2016-04-26 02:17:10.843669", "2016-04-26 02:17:10.843669"),
	("Stephen G. Kochan", "2016-04-26 02:17:10.844934", "2016-04-26 02:17:10.844934"),
	("Clare Churcher", "2016-04-26 02:17:10.846163", "2016-04-26 02:17:10.846163"),
	("Karl F. Kuhn", "2016-04-26 02:17:10.847413", "2016-04-26 02:17:10.847413"),
	("Mark Ryan", "2016-04-26 02:17:10.848657", "2016-04-26 02:17:10.848657"),
	("Ian Fleming", "2016-04-26 02:17:10.849911", "2016-04-26 02:17:10.849911"),
	("Joy Williams", "2016-04-26 02:17:10.851194", "2016-04-26 02:17:10.851194");

	INSERT INTO 
	"books" 
	("book_name", "publisher_id", "topic_id", "created_at", "updated_at") 
	VALUES 
	("The Great Gatsby", 1, 1, "2016-04-26 02:17:10.859535", "2016-04-26 02:17:10.859535"),
	("The Beautiful and Damned:  A Twentieht Century Classic", 2, 1, "2016-04-26 02:17:10.861191", "2016-04-26 02:17:10.861191"),
	("C", 3, 2, "2016-04-26 02:17:10.862510", "2016-04-26 02:17:10.862510"),
	("Programming in C (4th Edition) (Developer's Library)", 4, 2, "2016-04-26 02:17:10.863858", "2016-04-26 02:17:10.863858"),
	("Beginning Database Design: From Novice to Professional", 5, 2, "2016-04-26 02:17:10.865350", "2016-04-26 02:17:10.865350"),
	("Basic Physics: A Self-Teaching Guide", 6, 3, "2016-04-26 02:17:10.866716", "2016-04-26 02:17:10.866716"),
	("Calculus for Dummies", 6, 4, "2016-04-26 02:17:10.868027", "2016-04-26 02:17:10.868027"),
	("Moonraker", 7, 1, "2016-04-26 02:17:10.869339", "2016-04-26 02:17:10.869339"),
	("Dr. No", 7, 1, "2016-04-26 02:17:10.870697", "2016-04-26 02:17:10.870697"),
	("Quantum of Solace: The Complete James Bond Short Stories", 8, 1, "2016-04-26 02:17:10.872058", "2016-04-26 02:17:10.872058"),
	("The Changeling", 9, 1, "2016-04-26 02:17:10.873362", "2016-04-26 02:17:10.873362"),
	("The Florida Keys: A History & Guide Tenth Edition", 10, 5, "2016-04-26 02:17:10.874656", "2016-04-26 02:17:10.874656");

	INSERT INTO 
	"book_authors" 
	("book_id", "author_id", "created_at", "updated_at") 
	VALUES 
	(1, 1, "2016-04-26 02:17:10.884163", "2016-04-26 02:17:10.884163"),
	(1, 2, "2016-04-26 02:17:10.885985", "2016-04-26 02:17:10.885985"),
	(2, 1, "2016-04-26 02:17:10.887726", "2016-04-26 02:17:10.887726"),
	(3, 2, "2016-04-26 02:17:10.889202", "2016-04-26 02:17:10.889202"),
	(4, 3, "2016-04-26 02:17:10.890766", "2016-04-26 02:17:10.890766"),
	(5, 4, "2016-04-26 02:17:10.892115", "2016-04-26 02:17:10.892115"),
	(6, 5, "2016-04-26 02:17:10.893646", "2016-04-26 02:17:10.893646"),
	(7, 6, "2016-04-26 02:17:10.894986", "2016-04-26 02:17:10.894986"),
	(8, 7, "2016-04-26 02:17:10.896330", "2016-04-26 02:17:10.896330"),
	(9, 7, "2016-04-26 02:17:10.897736", "2016-04-26 02:17:10.897736"),
	(10, 7, "2016-04-26 02:17:10.899135", "2016-04-26 02:17:10.899135"),
	(11, 8, "2016-04-26 02:17:10.900450", "2016-04-26 02:17:10.900450"),
	(12, 8, "2016-04-26 02:17:10.901687", "2016-04-26 02:17:10.901687");
</pre>

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

	# Use postgresql for Active Record production
	# in Heroku Server.
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
<p>$ rails g scaffold_controller publisher name location</p>
<p>$ rails g scaffold_controller topic topic_name</p>
<p>$ rails g scaffold_controller author author_name</p>
<p>$ rails g scaffold_controller book book_name publisher:references topic:references</p>
<p>$ rails g scaffold_controller book_author book:references author:references</p>

<p>Update file config/routes.rb as following:</p>
<pre>
	Rails.application.routes.draw do
	 
	  resources :publishers
	  resources :topics
	  resources :authors
	  resources :books
	  resources :book_authors

	  root 'books#index'
	end
</pre>
<h4>Install bootstrap for a better UI</h4>
<p>$ rails g bootstrap:install static</p>
<p>$ rails g bootstrap:themed books -f</p>
<p>$ rails g bootstrap:themed authors -f</p>
<p>$ rails g bootstrap:themed topics -f</p>
<p>$ rails g bootstrap:themed publishers -f</p>
<p>$ rails g bootstrap:themed book_authors -f</p>
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

<p>Other <a href="https://github.com/tonydng/g14/tree/master/app/controllers">controllers</a> and <a href="https://github.com/tonydng/g14/tree/master/app/views">views</a>  are modified as needed.</p>

<h3>At 5 SELECT(s) Used For This Project</h3>

<p>Update file app/controllers/books_controller.rb:</p>
<p>1. SELECT all books, then store them into an array, @books, for <a href="https://github.com/tonydng/g14/blob/master/app/views/books/index.html.erb" target="_blank">Book Index View</a></p>
<p>2. SELECT all attributes of a publisher belonging to a @book.id. Then store them to @publisher for <a href="https://github.com/tonydng/g14/blob/master/app/views/books/show.html.erb" target="_blank">Book Show View</a> of @book.id</p>
<p>3. SELECT all attributes of a topic belonging to a @book.id. Then store them to @topic for <a href="https://github.com/tonydng/g14/blob/master/app/views/books/show.html.erb" target="_blank">Book Show View</a> of @book.id</p>
<p>4. SELECT all authors writing a book whose id is @book.id. Then store them to @authors for <a href="https://github.com/tonydng/g14/blob/master/app/views/books/show.html.erb" target="_blank">Book Show View</a> of @book.id</p>
<pre>
	class BooksController < ApplicationController
	  .....

	  # GET /books
    # GET /books.json
    def index
      all_books_sql = ""
      all_books_sql = "SELECT * FROM books"
      @books = Book.find_by_sql(all_books_sql)
    end

    # GET /books/1
    # GET /books/1.json
    def show
      publisher_sql = ""
      publisher_sql = "SELECT p.* FROM publishers p INNER JOIN books b" + 
                      " ON p.id = b.publisher_id AND b.id = #{@book.id}"
      @publisher = Publisher.find_by_sql(publisher_sql)

      topic_sql = ""
      topic_sql = "SELECT t.* FROM topics t INNER JOIN books b" + 
                  " ON t.id = b.topic_id AND b.id = #{@book.id}"
      @topic = Topic.find_by_sql(topic_sql)

      authors_sql = ""
      authors_sql = "SELECT a.* FROM authors a INNER JOIN book_authors ba" + 
                " ON a.id = ba.author_id AND ba.book_id = #{@book.id}"
      @authors = Book.find_by_sql(authors_sql)
    end

	  ....
	end
</pre>

<p>Update file app/controllers/publishers_controller.rb:</p>
<p>5. SELECT all publishers, then store them into an array, @publishers, for <a href="https://github.com/tonydng/g14/blob/master/app/views/publishers/index.html.erb" target="_blank">Publisher Index View</a></p>
<p>6. SELECT all books publishing by a publisher whose id is @publisher.id. Then store them to @books for <a href="https://github.com/tonydng/g14/blob/master/app/views/publishers/show.html.erb" target="_blank">Publisher show View</a> of @publisher.id</p>
<pre>
  class PublishersController < ApplicationController
    ....
    # GET /publishers
    # GET /publishers.json
    def index
      @publishers = Publisher.find_by_sql("SELECT * FROM publishers")
    end

    # GET /publishers/1
    # GET /publishers/1.json
    def show
      books_sql = ""
      books_sql = "SELECT b.* FROM books b, publishers p " +
                  "WHERE b.publisher_id = p.id AND p.id = #{@publisher.id}"
      @books = Book.find_by_sql(books_sql)
    end
    ....
  end
</pre>

<p>Update file app/controllers/topics_controller.rb:</p>
<p>7. SELECT all topics, then store them into an array, @topics, for <a href="https://github.com/tonydng/g14/blob/master/app/views/topics/index.html.erb" target="_blank">Topic Index View</a></p>
<p>8. SELECT all books about this topic whose id is @topic.id. Then store them to @books for <a href="https://github.com/tonydng/g14/blob/master/app/views/topics/show.html.erb" target="_blank">Topic Show View</a> of @topic.id</p>
<pre>
	class TopicsController < ApplicationController
	  ...

	  # GET /topics
	  # GET /topics.json
	  def index
	    @topics = Topic.find_by_sql("SELECT * from topics")
	  end

	  # GET /topics/1
	  # GET /topics/1.json
	  def show
	    books_sql = ""
	    books_sql = "SELECT b.* FROM books b, topics t " +
	                "WHERE b.topic_id = t.id AND t.id = #{@topic.id}"
	    @books = Book.find_by_sql(books_sql)
	  end
	  ....
	end
</pre>

<p>Update file app/controllers/authors_controller.rb:</p>
<p>9. SELECT all authors, then store them into an array, @authors, for <a href="https://github.com/tonydng/g14/blob/master/app/views/authors/index.html.erb" target="_blank">Author Index View</a></p>
<p>10. SELECT all books written by this author whose id is @author.id. Then store them to @books for <a href="https://github.com/tonydng/g14/blob/master/app/views/authors/show.html.erb" target="_blank">Author show View</a> of @author.id</p>
<pre>
	class AuthorsController < ApplicationController
	  ....
	  # GET /authors
	  # GET /authors.json
	  def index
	    @authors = Author.find_by_sql("SELECT * FROM authors")
	  end

	  # GET /authors/1
	  # GET /authors/1.json
	  def show
	    books_sql = ""
	    books_sql = "SELECT b.* FROM books b INNER JOIN book_authors ba" + 
	                " ON b.id = ba.book_id AND ba.author_id = #{@author.id}"
	    @books = Author.find_by_sql(books_sql)
	  end
	  ....
	end
</pre>

<h4>on github create a new repository, g14</h4>
<pre>
	$ git init
	$ git add README.md
	$ git commit -m "first commit"
	$ git remote add origin https://github.com/tonydng/g14.git
	$ git push -u origin master
	
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
<p>$ heroku create g14 (you have to use a different name because this name was already used.)</p>
<p>$ git push heroku master</p>
<p>$ heroku run rake db:migrate</p>
<p>$ heroku open</p>
<p>https://g14.herokuapp.com/</p>
<pre>
	Next time if you update something in your app
	$ git add .
	$ git commit -m "update something"
	$ git push
	$ git push heroku
</pre>
