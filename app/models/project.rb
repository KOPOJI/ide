class Project < ActiveRecord::Base
  before_save do
    self.project_url = self.name.gsub /[^-_.a-z0-9а-яёЁ]/i, '_'
    Directory.create(project_id: self.id, name: self.name)
  end
end
