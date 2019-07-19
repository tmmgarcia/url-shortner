class ShortUri < ApplicationRecord
  validates :original_uri, :short_uri, presence: true
  validates :original_uri, url: true
end
