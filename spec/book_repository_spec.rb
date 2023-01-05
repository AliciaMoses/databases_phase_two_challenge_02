require 'book'
require 'book_repository'
require 'database_connection'

RSpec.describe BookRepository do
    def reset_books_table
        seed_sql = File.read('spec/book_store_seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_books_table
    end
    
    it "returns all books" do
        repo = BookRepository.new
        books = repo.all

        expect(books.length).to eq(5)
        expect(books.first.title).to eq("Nineteen Eighty-Four")
        expect(books.first.author_name).to eq("George Orwell") 
        expect(books.last.title).to eq("The Age of Innocence")
        expect(books.last.author_name).to eq("Edith Wharton")
    end
    it "sorts books by title in alphabetical order" do
    repo = BookRepository.new
    sorted_list = repo.sort_by_title

    expect(sorted_list[2].title).to eq("Mrs Dalloway")
    expect(sorted_list[0].title).to eq("Dracula")
    expect(sorted_list[1].author_name).to eq("Jane Austen")
    expect(sorted_list[4].id).to eq("5")
    end
end