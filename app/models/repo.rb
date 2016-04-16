class Repo < ActiveRecord::Base
  belongs_to :user

  scope :by_language, -> language { where(github_language: language) if language.present? }
  scope :by_idiom, -> idiom { where(idiom: idiom) if idiom.present? }

end
