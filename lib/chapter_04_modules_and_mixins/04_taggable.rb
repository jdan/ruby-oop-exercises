# frozen_string_literal: true

# Implement the Taggable module, Article, and Photo classes here
#
# The Taggable module should:
# - Define an `add_tag(tag)` method that adds a tag (no duplicates allowed)
# - Define a `remove_tag(tag)` method that removes a tag
# - Define a `tags` method that returns all tags as an array
# - Define a `tagged_with?(tag)` method that returns true if the tag exists
# - Define a `clear_tags` method that removes all tags
#
# The Article class should:
# - Include the Taggable module
# - Accept a title in the constructor
# - Have a `title` reader method
#
# The Photo class should:
# - Include the Taggable module
# - Accept a filename in the constructor
# - Have a `filename` reader method

module Chapter04
  ##
  # A module that provides tagging functionality
  module Taggable
    # NOTE: These methods are wrapped in #tap so they do not
    # expose the underlying set
    def add_tag(tag)
      tap { tag_set.add(tag) }
    end

    def remove_tag(tag)
      tap { tag_set.delete(tag) }
    end

    def clear_tags
      tap { tag_set.clear }
    end

    def tags
      tag_set.to_a
    end

    def tagged_with?(tag)
      tag_set.include? tag
    end

    private

    ##
    # Store the tags as a set internally
    def tag_set
      @tag_set ||= Set.new
    end
  end

  ##
  # An article that can be tagged
  class Article
    include Taggable

    attr_reader :title

    def initialize(title)
      @title = title
    end
  end

  ##
  # A photo that can be tagged
  class Photo
    include Taggable

    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end
  end
end
