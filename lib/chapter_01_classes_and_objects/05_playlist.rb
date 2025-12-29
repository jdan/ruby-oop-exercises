# frozen_string_literal: true

# Implement the Playlist class here
#
# A Playlist should:
# - Be initialized with a name (starts with no songs)
# - Have an add_song method that adds a song to the playlist
# - Have a total_songs method that returns the number of songs
# - Have an includes? method that checks if a song is in the playlist
# - Have a first_song method that returns the first song (or nil if empty)

module Chapter01
  ##
  # A playlist which tracks songs
  class Playlist
    def initialize(name)
      @name = name
      @songs = []
    end

    def total_songs
      @songs.count
    end

    def add_song(song)
      @songs << song
    end

    def includes?(song)
      @songs.include? song
    end

    def first_song
      @songs.first
    end
  end
end
