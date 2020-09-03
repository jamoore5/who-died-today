class Obituary < ApplicationRecord
  default_scope { order(dod: :desc) }
  scope :recent, ->{ where("created_at >= ?", Time.zone.now.beginning_of_day)}
  scope :past, ->{ where("created_at < ?", Time.zone.now.beginning_of_day)}
end
