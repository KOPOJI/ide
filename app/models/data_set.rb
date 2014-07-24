class DataSet < ActiveRecord::Base
  belongs_to :user
  belongs_to :directory
  belongs_to :project

  validates_presence_of :name

  before_validation do
    if self.new_record?
      unless DataSet.where(directory_id: self.directory_id, name: self.name).count.zero?
        errors.add(:name, 'File with this name already exists.')
      end
    end
  end

  before_save do
    self.project_id = self.directory.project_id
    self.extension = File.extname(name)[1..-1]
  end
end
