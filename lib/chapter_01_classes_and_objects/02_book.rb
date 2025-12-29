# frozen_string_literal: true

# Implement the Book class here
#
# A Book should:
# - Be initialized with a title, author, and number of pages
# - Have a summary method that returns "{title} by {author}"
# - Have a long_read? method that returns true if pages > 300

module Chapter01
  ##
  # A book with a title and author that can describe itself
  # and if it's a long read of > 300 pages
  class Book
    def initialize(title, author, num_pages)
      @title = title
      @author = author
      @num_pages = num_pages
    end

    def summary
      "#{@title} by #{@author}"
    end

    def long_read?
      @num_pages > 300
    end
  end
end
