# {{Book Store}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql



TRUNCATE TABLE books RESTART IDENTITY; 

INSERT INTO "public"."books" ("id", "title", "author_name") VALUES
(1, 'Nineteen Eighty-Four', 'George Orwell'),
(2, 'Mrs Dalloway', 'Virginia Woolf'),
(3, 'Emma', 'Jane Austen'),
(4, 'Dracula', 'Bram Stoker'),
(5, 'The Age of Innocence', 'Edith Wharton');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 book_store < book_store_seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: books


# (in lib/book.rb)

# Model class

class Book
end

# (in lib/book_repository.rb)

# Repository class
class BookRepository
end

```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: book

# (in lib/book.rb)

# Model class
class Book
    attr_accessor :id, :title, :author_name
end

# class used to create Book objects

# book = Book.new
# book.title = "Catch 22"
# book.author_name = "Joseph Heller"



```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: book

# (in lib/book_repository.rb)

# Repository class
class BookRepository
    def all
        # Executes SQL query:
        #   SELECT id, title, author_name FROM books;

        # returns an array of Book objects
    end
    
    def sort_by_title
        # Executes SQL query:
        #   SELECT id, title, author_name FROM books ORDER BY title;

        # returns an array of book objects, sorted by title rather than id
    end

end


```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

repo = BookRepository.new
books = repo.all

books.length # => 5
books.first.title # =>  "Nineteen Eighty-Four"
books.first.author_name # => "George Orwell"
books.last.title # => "The Age of Innocence"
books.last.author_name # => "Edith Wharton"

repo = BookRepository.new
sorted_list = repo.sort_by_title

sorted_list[2].title # => "Mrs Dalloway"
sorted_list[0].title # => "Dracula"
sorted_list[1].author_name # => "Jane Austen"
sorted_list[4].id # => 5


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
def reset_books_table
  seed_sql = File.read('spec/book_store_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'books' })
  connection.exec(seed_sql)
end

describe BookRepository do
  before(:each) do 
    reset_books_table
  end


end

```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->


<!-- END GENERATED SECTION DO NOT EDIT -->