# frozen_string_literal: true

# Liskov Substitution Principle (LSP)
#
# Objects of a superclass should be replaceable with objects of its subclasses
# without affecting the correctness of the program.
#
# All MediaFile subtypes can be used interchangeably in a Playlist because
# they all honor the same contract (play, pause, stop, duration).

# MediaFile class (base):
# - initialize(filename, duration)
# - filename, duration readers
# - play - returns "Playing: #{filename}"
# - pause - returns "Paused: #{filename}"
# - stop - returns "Stopped: #{filename}"
# - formatted_duration - returns "MM:SS" format

##
# Base class establishing the contract for all media files
MediaFile = Struct.new(:filename, :duration) do
  def play = "Playing: #{filename}"
  def pause = "Paused: #{filename}"
  def stop = "Stopped: #{filename}"

  def formatted_duration
    min = duration / 60
    sec = duration % 60
    "#{min.to_s.rjust(2, '0')}:#{sec.to_s.rjust(2, '0')}"
  end
end

# AudioFile < MediaFile:
# - initialize(filename, duration, artist)
# - artist reader
# - play - returns "Playing audio: #{filename} by #{artist}"
# - Inherits pause, stop, formatted_duration

##
# Audio file with artist information
class AudioFile < MediaFile
  attr_reader :artist

  def initialize(filename, duration, artist)
    super(filename, duration)
    @artist = artist
  end

  def play = "Playing audio: #{filename} by #{artist}"
end

# VideoFile < MediaFile:
# - initialize(filename, duration, resolution)
# - resolution reader
# - play - returns "Playing video: #{filename} [#{resolution}]"
# - Inherits pause, stop, formatted_duration

##
# Video file with resolution information
class VideoFile < MediaFile
  attr_reader :resolution

  def initialize(filename, duration, resolution)
    super(filename, duration)
    @resolution = resolution
  end

  def play = "Playing video: #{filename} [#{resolution}]"
end

# PodcastEpisode < AudioFile:
# - initialize(filename, duration, artist, episode_number)
# - episode_number reader
# - play - returns "Playing podcast: #{filename} - Episode #{episode_number}"
# - Inherits pause, stop from AudioFile

##
# Podcast episode with episode number
class PodcastEpisode < AudioFile
  attr_reader :episode_number

  def initialize(filename, duration, artist, episode_number)
    super(filename, duration, artist)
    @artist = artist
    @episode_number = episode_number
  end

  def play = "Playing podcast: #{filename} - Episode #{episode_number}"
end

# Playlist class:
# - initialize (creates empty items array)
# - add(media_file) - adds to collection
# - items reader
# - play_all - calls play on each, returns array of results
# - total_duration - sums all durations
# - formatted_total_duration - returns "HH:MM:SS" format

##
# Works with ANY MediaFile subtype (demonstrates LSP)
class Playlist
  attr_reader :items

  def initialize
    @items = []
  end

  def add(media_file)
    @items << media_file
  end

  def play_all
    @items.map &:play
  end

  def total_duration
    @items.sum &:duration
  end

  def formatted_total_duration
    hour = total_duration / 3600
    min = (total_duration % 3600) / 60
    sec = total_duration % 60

    [hour, min, sec].map { |amt| amt.to_s.rjust(2, '0') }.join(':')
  end
end
