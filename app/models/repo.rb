class Repo < ActiveRecord::Base
  belongs_to :user

  scope :by_programming_language, -> programming_language {
    where(github_programming_language: programming_language) if programming_language.present?
  }

  scope :by_language, -> language { where(language: [language, nil, '']) if language.present? }

end
