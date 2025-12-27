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

##
# A module that provides tagging functionality
module Taggable
end

##
# An article that can be tagged
class Article
end

##
# A photo that can be tagged
class Photo
end
