require_relative 'lib/database_connection.rb'
require_relative 'lib/book_repository.rb'

# use connect method on database connection class
DatabaseConnection.connect('book_store') # connection to the main database

# Perform SQL query to get result set

sql = 'SELECT * FROM books;'

result = DatabaseConnection.exec_params(sql, [])

# create loop to extract values 

result.each do |record|
    p record.values
end



