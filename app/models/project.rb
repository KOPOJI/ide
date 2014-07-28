class Project < ActiveRecord::Base
  has_many :directories

  before_save do
    self.project_url = self.name.gsub /[^-_.a-z0-9а-яёЁ]/i, '_'
  end
  after_save do
    if Directory.where(parent_id: -1, project_id: self.id).count.zero?
      Directory.create(name: self.name, parent_id: -1, project_id: self.id)
    end
  end
end
