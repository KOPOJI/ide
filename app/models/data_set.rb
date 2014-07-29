class DataSet < ActiveRecord::Base
  belongs_to :user
  belongs_to :directory
  belongs_to :project

  validates_presence_of :name

  before_validation do
    f = DataSet.where(directory_id: self.directory_id, name: self.name)
    return if f.count.zero?
    if self.new_record?
      errors.add(:name, 'File with this name already exists.') if !f.count.zero?
    else
      errors.add(:name, 'File with this name already exists.') if self.id && f[0].id != self.id && !f.count.zero?
    end
  end

  before_save do
    self.extension = File.extname(name)[1..-1]
  end
end
