class Project < ActiveRecord::Base
  has_many :directories

  before_save do
    self.project_url = self.name.gsub /[^-_.a-z0-9а-яёЁ]/i, '_'
  end
end
