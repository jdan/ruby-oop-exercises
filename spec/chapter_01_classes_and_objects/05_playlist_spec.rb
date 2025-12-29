# frozen_string_literal: true

require 'chapter_01_classes_and_objects/05_playlist'

RSpec.describe Chapter01::Playlist do
  describe '#initialize' do
    it 'creates a playlist with a name' do
      playlist = described_class.new('Road Trip')
      expect(playlist).to be_a(described_class)
    end

    it 'starts with no songs' do
      playlist = described_class.new('Road Trip')
      expect(playlist.total_songs).to eq(0)
    end
  end

  describe '#add_song' do
    it 'adds a song to the playlist' do
      playlist = described_class.new('Road Trip')
      playlist.add_song('Bohemian Rhapsody')
      expect(playlist.total_songs).to eq(1)
    end

    it 'can add multiple songs' do
      playlist = described_class.new('Road Trip')
      playlist.add_song('Bohemian Rhapsody')
      playlist.add_song('Hotel California')
      playlist.add_song('Stairway to Heaven')
      expect(playlist.total_songs).to eq(3)
    end
  end

  describe '#total_songs' do
    it 'returns the number of songs' do
      playlist = described_class.new('Workout')
      expect(playlist.total_songs).to eq(0)
      playlist.add_song('Eye of the Tiger')
      expect(playlist.total_songs).to eq(1)
    end
  end

  describe '#includes?' do
    it 'returns true if the song is in the playlist' do
      playlist = described_class.new('Favorites')
      playlist.add_song('Yesterday')
      expect(playlist.includes?('Yesterday')).to be true
    end

    it 'returns false if the song is not in the playlist' do
      playlist = described_class.new('Favorites')
      playlist.add_song('Yesterday')
      expect(playlist.includes?('Tomorrow')).to be false
    end
  end

  describe '#first_song' do
    it 'returns the first song added' do
      playlist = described_class.new('Mix')
      playlist.add_song('First Song')
      playlist.add_song('Second Song')
      expect(playlist.first_song).to eq('First Song')
    end

    it 'returns nil for an empty playlist' do
      playlist = described_class.new('Empty')
      expect(playlist.first_song).to be_nil
    end
  end
end
