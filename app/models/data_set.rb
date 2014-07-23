class DataSet < ActiveRecord::Base
  belongs_to :user
  belongs_to :directory

  before_save do
    self.extension = File.extname(name)[1..-1]
  end
end
