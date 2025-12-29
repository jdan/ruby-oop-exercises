# frozen_string_literal: true

# Liskov Substitution Principle (LSP)
#
# Objects of a superclass should be replaceable with objects of its subclasses
# without affecting the correctness of the program.
#
# All MediaFile subtypes can be used interchangeably in a Playlist because
# they all honor the same contract (play, pause, stop, duration).

# MediaFile class (base):
# - initialize(filename, duration_seconds)
# - filename, duration readers
# - play - returns "Playing: #{filename}"
# - pause - returns "Paused: #{filename}"
# - stop - returns "Stopped: #{filename}"
# - formatted_duration - returns "MM:SS" format

##
# Base class establishing the contract for all media files
class MediaFile
end

# AudioFile < MediaFile:
# - initialize(filename, duration_seconds, artist)
# - artist reader
# - play - returns "Playing audio: #{filename} by #{artist}"
# - Inherits pause, stop, formatted_duration

##
# Audio file with artist information
class AudioFile < MediaFile
end

# VideoFile < MediaFile:
# - initialize(filename, duration_seconds, resolution)
# - resolution reader
# - play - returns "Playing video: #{filename} [#{resolution}]"
# - Inherits pause, stop, formatted_duration

##
# Video file with resolution information
class VideoFile < MediaFile
end

# PodcastEpisode < AudioFile:
# - initialize(filename, duration_seconds, artist, episode_number)
# - episode_number reader
# - play - returns "Playing podcast: #{filename} - Episode #{episode_number}"
# - Inherits pause, stop from AudioFile

##
# Podcast episode with episode number
class PodcastEpisode < AudioFile
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
end
