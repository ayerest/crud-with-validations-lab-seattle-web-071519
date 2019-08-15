class Song < ApplicationRecord
    validates :title, presence: true
    validates :artist_name, presence: true
    validate :same_year_repeat?
    validate :future?
    validate :released_yet?

    def same_year_repeat?
        repeat = Song.all.any? do |song|
            # binding.pry
            self.artist_name == song.artist_name && self.release_year == song.release_year && self.title == song.title
        end
        if repeat
            errors.add(:title, "You have already released this song this year!")
        end
    end

    def future?
        if self.release_year
            if self.release_year > Time.now.year
                errors.add(:release_year, "Release year cannot be in the future")
            end
        end
    end

    def released_yet?
        if self.released
            if self.release_year == nil
                errors.add(:release_year, "Release year must be set")
            end
        else
            if self.release_year |= nil
                errors.add(:release_year, "This song is not yet released and cannot have a release")
            end
        end
    end

end

