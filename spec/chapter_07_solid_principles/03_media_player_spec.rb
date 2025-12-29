# frozen_string_literal: true

require 'chapter_07_solid_principles/03_media_player'

RSpec.describe Chapter07::MediaFile do
  describe '#initialize' do
    it 'creates a media file with filename and duration' do
      media = described_class.new('song.mp3', 180)
      expect(media.filename).to eq('song.mp3')
      expect(media.duration).to eq(180)
    end
  end

  describe '#play' do
    it 'returns a playing message' do
      media = described_class.new('song.mp3', 180)
      expect(media.play).to eq('Playing: song.mp3')
    end
  end

  describe '#pause' do
    it 'returns a paused message' do
      media = described_class.new('song.mp3', 180)
      expect(media.pause).to eq('Paused: song.mp3')
    end
  end

  describe '#stop' do
    it 'returns a stopped message' do
      media = described_class.new('song.mp3', 180)
      expect(media.stop).to eq('Stopped: song.mp3')
    end
  end

  describe '#formatted_duration' do
    it 'returns duration in MM:SS format' do
      media = described_class.new('song.mp3', 185)
      expect(media.formatted_duration).to eq('03:05')
    end

    it 'handles durations under a minute' do
      media = described_class.new('clip.mp3', 45)
      expect(media.formatted_duration).to eq('00:45')
    end
  end
end

RSpec.describe Chapter07::AudioFile do
  describe '#initialize' do
    it 'creates an audio file with filename, duration, and artist' do
      audio = described_class.new('song.mp3', 210, 'The Beatles')
      expect(audio.filename).to eq('song.mp3')
      expect(audio.duration).to eq(210)
      expect(audio.artist).to eq('The Beatles')
    end
  end

  describe '#play' do
    it 'returns a playing message with artist' do
      audio = described_class.new('song.mp3', 210, 'The Beatles')
      expect(audio.play).to eq('Playing audio: song.mp3 by The Beatles')
    end
  end

  describe '#pause' do
    it 'inherits pause behavior from MediaFile' do
      audio = described_class.new('song.mp3', 210, 'The Beatles')
      expect(audio.pause).to eq('Paused: song.mp3')
    end
  end

  describe '#stop' do
    it 'inherits stop behavior from MediaFile' do
      audio = described_class.new('song.mp3', 210, 'The Beatles')
      expect(audio.stop).to eq('Stopped: song.mp3')
    end
  end
end

RSpec.describe Chapter07::VideoFile do
  describe '#initialize' do
    it 'creates a video file with filename, duration, and resolution' do
      video = described_class.new('movie.mp4', 7200, '1080p')
      expect(video.filename).to eq('movie.mp4')
      expect(video.duration).to eq(7200)
      expect(video.resolution).to eq('1080p')
    end
  end

  describe '#play' do
    it 'returns a playing message with resolution' do
      video = described_class.new('movie.mp4', 7200, '1080p')
      expect(video.play).to eq('Playing video: movie.mp4 [1080p]')
    end
  end

  describe '#pause' do
    it 'inherits pause behavior from MediaFile' do
      video = described_class.new('movie.mp4', 7200, '1080p')
      expect(video.pause).to eq('Paused: movie.mp4')
    end
  end
end

RSpec.describe Chapter07::PodcastEpisode do
  describe '#initialize' do
    it 'creates a podcast with filename, duration, artist, and episode number' do
      podcast = described_class.new('episode.mp3', 3600, 'Tech Talk', 42)
      expect(podcast.filename).to eq('episode.mp3')
      expect(podcast.duration).to eq(3600)
      expect(podcast.artist).to eq('Tech Talk')
      expect(podcast.episode_number).to eq(42)
    end
  end

  describe '#play' do
    it 'returns a playing message with episode number' do
      podcast = described_class.new('episode.mp3', 3600, 'Tech Talk', 42)
      expect(podcast.play).to eq('Playing podcast: episode.mp3 - Episode 42')
    end
  end

  describe '#pause' do
    it 'inherits pause behavior from AudioFile' do
      podcast = described_class.new('episode.mp3', 3600, 'Tech Talk', 42)
      expect(podcast.pause).to eq('Paused: episode.mp3')
    end
  end
end

RSpec.describe Chapter07::Playlist do
  describe '#initialize' do
    it 'creates an empty playlist' do
      playlist = described_class.new
      expect(playlist.items).to eq([])
    end
  end

  describe '#add' do
    it 'adds media files to the playlist' do
      playlist = described_class.new
      audio = Chapter07::AudioFile.new('song.mp3', 180, 'Artist')

      playlist.add(audio)
      expect(playlist.items).to include(audio)
    end
  end

  describe '#play_all' do
    it 'plays all media files and returns results' do
      playlist = described_class.new
      audio = Chapter07::AudioFile.new('song.mp3', 180, 'Artist')
      video = Chapter07::VideoFile.new('clip.mp4', 120, '720p')

      playlist.add(audio)
      playlist.add(video)

      results = playlist.play_all
      expect(results).to eq([
                              'Playing audio: song.mp3 by Artist',
                              'Playing video: clip.mp4 [720p]'
                            ])
    end
  end

  describe '#total_duration' do
    it 'sums duration of all media files' do
      playlist = described_class.new
      playlist.add(Chapter07::MediaFile.new('a.mp3', 100))
      playlist.add(Chapter07::MediaFile.new('b.mp3', 150))
      playlist.add(Chapter07::MediaFile.new('c.mp3', 50))

      expect(playlist.total_duration).to eq(300)
    end
  end

  describe '#formatted_total_duration' do
    it 'returns total duration in HH:MM:SS format' do
      playlist = described_class.new
      playlist.add(Chapter07::MediaFile.new('a.mp3', 3661)) # 1 hour, 1 minute, 1 second

      expect(playlist.formatted_total_duration).to eq('01:01:01')
    end

    it 'handles multi-hour playlists' do
      playlist = described_class.new
      playlist.add(Chapter07::MediaFile.new('a.mp3', 7200)) # 2 hours
      playlist.add(Chapter07::MediaFile.new('b.mp3', 1800)) # 30 minutes

      expect(playlist.formatted_total_duration).to eq('02:30:00')
    end
  end

  describe 'Liskov Substitution Principle' do
    it 'works identically with any MediaFile subtype' do
      playlist = described_class.new

      # Add various subtypes - all should work
      playlist.add(Chapter07::MediaFile.new('base.mp3', 100))
      playlist.add(Chapter07::AudioFile.new('audio.mp3', 150, 'Artist'))
      playlist.add(Chapter07::VideoFile.new('video.mp4', 200, '1080p'))
      playlist.add(Chapter07::PodcastEpisode.new('podcast.mp3', 250, 'Host', 1))

      # All methods work regardless of actual type
      expect(playlist.items.length).to eq(4)
      expect(playlist.total_duration).to eq(700)
      expect(playlist.play_all.length).to eq(4)
    end
  end
end
