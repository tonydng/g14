<h1>Group 14</h1>
<p><a href="https://github.com/tonydng/g14/tree/master/app" target="_blank">App Files</a></p>
<h3>Books Database ER TO BE UPDATED LATER</h3>
(https://www.flickr.com/photos/142018434@N08/shares/9yf15z)
<hr>
<h3>Relational Models of Books Database</h3>
![alt tag](https://s3-eu-west-1.amazonaws.com/gallery-prod-4f50/img/6ee2f2b471494d3ca2314545a6cae40b.png)
<hr>
<p>Use <a href="https://www.railstutorial.org/book">Ruby on rails Tutorial</a> for UI</p>
<p>We assume that you already had <a href="https://github.com/">github.com account</a>, <a href="https://www.heroku.com/">heroku.com account</a> and <a href="http://rubyonrails.org/">Ruby on Rails</a> installing in your PC/Mac</p>

<h4>All instructions bellow using for Mac / linux computer only:</h4>

<p>$ rails new g14</p>
<p>$ cd g14</p>

<h3>Create Models (Database Tables)</h3>
<p>
	Primary keys - By default, Active Record will use an integer column named id as the table's primary key. When using Active Record Migrations to create your tables, this column will be automatically created.
</p>
<h4>Create Publisher Model</h4>
<p>$ rails g model publisher name location</p>
<p>$ rake db:migrate</p>
<p>After 2 above commands, Rails will run automatically an equivalent query behind the scenes for us:</p>
<pre>
	 CREATE TABLE "publishers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "location" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
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

<h4>Validations (constraints)</h4>

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

<h4>Populate data</h4>
<p>Update seed file on db/seeds.rb</p>
<pre>
	# populate publishers
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

	# populate topics
	Topic.create(topic_name: "Fiction")
	Topic.create(topic_name: "Computer Science")
	Topic.create(topic_name: "Physical Science")
	Topic.create(topic_name: "Math")
	Topic.create(topic_name: "Travel")

	# populate authors
	Author.create(author_name: "Scott Fitzgerald")
	Author.create(author_name: "Tom McCarthy")
	Author.create(author_name: "Stephen G. Kochan")
	Author.create(author_name: "Clare Churcher")
	Author.create(author_name: "Karl F. Kuhn")
	Author.create(author_name: "Mark Ryan")
	Author.create(author_name: "Ian Fleming")
	Author.create(author_name: "Joy Williams")

	# populate book
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

	# populate join table, book_authors
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
	(0.0ms)  begin transaction
	  SQL (0.2ms)  INSERT INTO "publishers" ("name", "location", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Scribner"], ["location", "New York"], ["created_at", "2016-04-24 00:07:43.928849"], ["updated_at", "2016-04-24 00:07:43.928849"]]
	   (2.4ms)  commit transaction
	   (0.1ms)
	SQL (0.2ms)  INSERT INTO "publishers" ("name", "location", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "World Library Classics"], ["location", "California"], ["created_at", "2016-04-24 00:07:43.934042"], ["updated_at", "2016-04-24 00:07:43.934042"]]
   (0.5ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "publishers" ("name", "location", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Vintage"], ["location", "New York"], ["created_at", "2016-04-24 00:07:43.935766"], ["updated_at", "2016-04-24 00:07:43.935766"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "publishers" ("name", "location", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Addison-Wesley Proffesional"], ["location", "New York"], ["created_at", "2016-04-24 00:07:43.937218"], ["updated_at", "2016-04-24 00:07:43.937218"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "publishers" ("name", "location", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Apress"], ["location", "New York"], ["created_at", "2016-04-24 00:07:43.938691"], ["updated_at", "2016-04-24 00:07:43.938691"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "publishers" ("name", "location", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Wiley"], ["location", "New Jersey"], ["created_at", "2016-04-24 00:07:43.940055"], ["updated_at", "2016-04-24 00:07:43.940055"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "publishers" ("name", "location", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Thomas & Mercer"], ["location", "Washington"], ["created_at", "2016-04-24 00:07:43.941535"], ["updated_at", "2016-04-24 00:07:43.941535"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "publishers" ("name", "location", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Penguin Books"], ["location", "UK"], ["created_at", "2016-04-24 00:07:43.942971"], ["updated_at", "2016-04-24 00:07:43.942971"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "publishers" ("name", "location", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Fairy Tale Review Press"], ["location", "Arizona"], ["created_at", "2016-04-24 00:07:43.944273"], ["updated_at", "2016-04-24 00:07:43.944273"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "publishers" ("name", "location", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Random House Trade Paperbacks"], ["location", "New York"], ["created_at", "2016-04-24 00:07:43.945528"], ["updated_at", "2016-04-24 00:07:43.945528"]]
   (0.5ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.2ms)  INSERT INTO "topics" ("topic_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["topic_name", "Fiction"], ["created_at", "2016-04-24 00:07:43.949715"], ["updated_at", "2016-04-24 00:07:43.949715"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "topics" ("topic_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["topic_name", "Computer Science"], ["created_at", "2016-04-24 00:07:43.951396"], ["updated_at", "2016-04-24 00:07:43.951396"]]
   (0.3ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "topics" ("topic_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["topic_name", "Physical Science"], ["created_at", "2016-04-24 00:07:43.952686"], ["updated_at", "2016-04-24 00:07:43.952686"]]
   (0.3ms)  commit transaction
   (0.3ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "topics" ("topic_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["topic_name", "Math"], ["created_at", "2016-04-24 00:07:43.954215"], ["updated_at", "2016-04-24 00:07:43.954215"]]
   (0.3ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "topics" ("topic_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["topic_name", "Travel"], ["created_at", "2016-04-24 00:07:43.955380"], ["updated_at", "2016-04-24 00:07:43.955380"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.2ms)  INSERT INTO "authors" ("author_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["author_name", "Scott Fitzgerald"], ["created_at", "2016-04-24 00:07:43.959945"], ["updated_at", "2016-04-24 00:07:43.959945"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "authors" ("author_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["author_name", "Tom McCarthy"], ["created_at", "2016-04-24 00:07:43.961448"], ["updated_at", "2016-04-24 00:07:43.961448"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "authors" ("author_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["author_name", "Stephen G. Kochan"], ["created_at", "2016-04-24 00:07:43.962780"], ["updated_at", "2016-04-24 00:07:43.962780"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "authors" ("author_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["author_name", "Clare Churcher"], ["created_at", "2016-04-24 00:07:43.964081"], ["updated_at", "2016-04-24 00:07:43.964081"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.2ms)  INSERT INTO "authors" ("author_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["author_name", "Karl F. Kuhn"], ["created_at", "2016-04-24 00:07:43.965337"], ["updated_at", "2016-04-24 00:07:43.965337"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "authors" ("author_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["author_name", "Mark Ryan"], ["created_at", "2016-04-24 00:07:43.967023"], ["updated_at", "2016-04-24 00:07:43.967023"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "authors" ("author_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["author_name", "Ian Fleming"], ["created_at", "2016-04-24 00:07:43.968400"], ["updated_at", "2016-04-24 00:07:43.968400"]]
   (0.5ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "authors" ("author_name", "created_at", "updated_at") VALUES (?, ?, ?)  [["author_name", "Joy Williams"], ["created_at", "2016-04-24 00:07:43.969791"], ["updated_at", "2016-04-24 00:07:43.969791"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.2ms)  INSERT INTO "books" ("book_name", "publisher_id", "topic_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["book_name", "The Great Gatsby"], ["publisher_id", 1], ["topic_id", 1], ["created_at", "2016-04-24 00:07:43.977399"], ["updated_at", "2016-04-24 00:07:43.977399"]]
   (0.5ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "books" ("book_name", "publisher_id", "topic_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["book_name", "The Beautiful and Damned:  A Twentieht Century Classic"], ["publisher_id", 2], ["topic_id", 1], ["created_at", "2016-04-24 00:07:43.979153"], ["updated_at", "2016-04-24 00:07:43.979153"]]
   (0.5ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "books" ("book_name", "publisher_id", "topic_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["book_name", "C"], ["publisher_id", 3], ["topic_id", 2], ["created_at", "2016-04-24 00:07:43.980669"], ["updated_at", "2016-04-24 00:07:43.980669"]]
   (0.5ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "books" ("book_name", "publisher_id", "topic_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["book_name", "Programming in C (4th Edition) (Developer's Library)"], ["publisher_id", 4], ["topic_id", 2], ["created_at", "2016-04-24 00:07:43.982155"], ["updated_at", "2016-04-24 00:07:43.982155"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "books" ("book_name", "publisher_id", "topic_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["book_name", "Beginning Database Design: From Novice to Professional"], ["publisher_id", 5], ["topic_id", 2], ["created_at", "2016-04-24 00:07:43.983583"], ["updated_at", "2016-04-24 00:07:43.983583"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "books" ("book_name", "publisher_id", "topic_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["book_name", "Basic Physics: A Self-Teaching Guide"], ["publisher_id", 6], ["topic_id", 3], ["created_at", "2016-04-24 00:07:43.985052"], ["updated_at", "2016-04-24 00:07:43.985052"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "books" ("book_name", "publisher_id", "topic_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["book_name", "Calculus for Dummies"], ["publisher_id", 6], ["topic_id", 4], ["created_at", "2016-04-24 00:07:43.986485"], ["updated_at", "2016-04-24 00:07:43.986485"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.2ms)  INSERT INTO "books" ("book_name", "publisher_id", "topic_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["book_name", "Moonraker"], ["publisher_id", 7], ["topic_id", 1], ["created_at", "2016-04-24 00:07:43.988041"], ["updated_at", "2016-04-24 00:07:43.988041"]]
   (0.5ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.2ms)  INSERT INTO "books" ("book_name", "publisher_id", "topic_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["book_name", "Dr. No"], ["publisher_id", 7], ["topic_id", 1], ["created_at", "2016-04-24 00:07:43.989744"], ["updated_at", "2016-04-24 00:07:43.989744"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "books" ("book_name", "publisher_id", "topic_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["book_name", "Quantum of Solace: The Complete James Bond Short Stories"], ["publisher_id", 8], ["topic_id", 1], ["created_at", "2016-04-24 00:07:43.991343"], ["updated_at", "2016-04-24 00:07:43.991343"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "books" ("book_name", "publisher_id", "topic_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["book_name", "The Changeling"], ["publisher_id", 9], ["topic_id", 1], ["created_at", "2016-04-24 00:07:43.992711"], ["updated_at", "2016-04-24 00:07:43.992711"]]
   (0.4ms)  commit transaction
   (0.0ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "books" ("book_name", "publisher_id", "topic_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["book_name", "The Florida Keys: A History & Guide Tenth Edition"], ["publisher_id", 10], ["topic_id", 5], ["created_at", "2016-04-24 00:07:43.994132"], ["updated_at", "2016-04-24 00:07:43.994132"]]
   (0.5ms)  commit transaction
   (0.0ms)  begin transaction
  BookAuthor Exists (0.1ms)  SELECT  1 AS one FROM "book_authors" WHERE ("book_authors"."author_id" = 1 AND "book_authors"."book_id" = 1) LIMIT 1
   (0.0ms)  rollback transaction
   (0.0ms)  begin transaction
  BookAuthor Exists (0.1ms)  SELECT  1 AS one FROM "book_authors" WHERE ("book_authors"."author_id" = 1 AND "book_authors"."book_id" = 2) LIMIT 1
   (0.0ms)  rollback transaction
   (0.0ms)  begin transaction
  BookAuthor Exists (0.1ms)  SELECT  1 AS one FROM "book_authors" WHERE ("book_authors"."author_id" = 2 AND "book_authors"."book_id" = 3) LIMIT 1
   (0.0ms)  rollback transaction
   (0.0ms)  begin transaction
  BookAuthor Exists (0.1ms)  SELECT  1 AS one FROM "book_authors" WHERE ("book_authors"."author_id" = 3 AND "book_authors"."book_id" = 4) LIMIT 1
   (0.0ms)  rollback transaction
   (0.0ms)  begin transaction
  BookAuthor Exists (0.1ms)  SELECT  1 AS one FROM "book_authors" WHERE ("book_authors"."author_id" = 4 AND "book_authors"."book_id" = 5) LIMIT 1
   (0.0ms)  rollback transaction
   (0.0ms)  begin transaction
  BookAuthor Exists (0.1ms)  SELECT  1 AS one FROM "book_authors" WHERE ("book_authors"."author_id" = 5 AND "book_authors"."book_id" = 6) LIMIT 1
   (0.0ms)  rollback transaction
   (0.0ms)  begin transaction
  BookAuthor Exists (0.1ms)  SELECT  1 AS one FROM "book_authors" WHERE ("book_authors"."author_id" = 6 AND "book_authors"."book_id" = 7) LIMIT 1
   (0.0ms)  rollback transaction
   (0.0ms)  begin transaction
  BookAuthor Exists (0.1ms)  SELECT  1 AS one FROM "book_authors" WHERE ("book_authors"."author_id" = 7 AND "book_authors"."book_id" = 8) LIMIT 1
   (0.1ms)  rollback transaction
   (0.0ms)  begin transaction
  BookAuthor Exists (0.1ms)  SELECT  1 AS one FROM "book_authors" WHERE ("book_authors"."author_id" = 7 AND "book_authors"."book_id" = 9) LIMIT 1
   (0.0ms)  rollback transaction
   (0.0ms)  begin transaction
  BookAuthor Exists (0.1ms)  SELECT  1 AS one FROM "book_authors" WHERE ("book_authors"."author_id" = 7 AND "book_authors"."book_id" = 10) LIMIT 1
   (0.0ms)  rollback transaction
   (0.0ms)  begin transaction
  BookAuthor Exists (0.1ms)  SELECT  1 AS one FROM "book_authors" WHERE ("book_authors"."author_id" = 8 AND "book_authors"."book_id" = 11) LIMIT 1
   (0.0ms)  rollback transaction
   (0.0ms)  begin transaction
  BookAuthor Exists (0.1ms)  SELECT  1 AS one FROM "book_authors" WHERE ("book_authors"."author_id" = 8 AND "book_authors"."book_id" = 12) LIMIT 1
   (0.0ms)  rollback transaction

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
<p>Install bootstrap for a better UI</p>
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
<p>Modify app/controllers/book_authors_controller.rb. So that when a new book_author created it redirect to root_path (home page)</p>
<pre>
	# POST /book_authors
  # POST /book_authors.json
  def create
    @book_author = BookAuthor.new(book_author_params)

    respond_to do |format|
      if @book_author.save
        format.html { redirect_to root_path, notice: 'Book author was successfully created.' }
        format.json { render :show, status: :created, location: @book_author }
      else
        format.html { render :new }
        format.json { render json: @book_author.errors, status: :unprocessable_entity }
      end
    end
  end
</pre>

<h3>At 5 SELECT(s) Used For This Project</h3>
<p>Update file app/controllers/boots_controller.rb:</p>
<p>1. SELECT all books, then store them into an array, @books, for Book Index View</p>
<p>2. SELECT all attributes of a publisher belonging to a @book.id. Then store them to @publisher for Book Show View of @book.id</p>
<p>3. SELECT all attributes of a topic belonging to a @book.id. Then store them to @topic for Book Show View of @book.id</p>
<p>4. SELECT all authors writing a book whose is @book.id. Then store them to @authors for Book Show View of @book.id</p>
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
      publisher_sql = "SELECT * FROM publishers p INNER JOIN books b" + 
                      " ON p.id = b.publisher_id AND b.id = #{@book.id}"
      @publisher = Publisher.find_by_sql(publisher_sql)

      topic_sql = ""
      topic_sql = "SELECT * FROM topics t INNER JOIN books b" + 
                  " ON t.id = b.topic_id AND b.id = #{@book.id}"
      @topic = Topic.find_by_sql(topic_sql)

      authors_sql = ""
      authors_sql = "SELECT * FROM authors a INNER JOIN book_authors ba" + 
                " ON a.id = ba.author_id AND ba.book_id = #{@book.id}"
      @authors = Book.find_by_sql(authors_sql)
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
<p>$ heroku create g14 (you have to use a different name because this name was in used.</p>
<p>$ git push heroku master</p>
<p>$ heroku run rake db:migrate</p>
<p>$ heroku open</p>
<p>https://g14.herokuapp.com/</p>
