class Directory < ActiveRecord::Base

  extend ActsAsTree::TreeView

  acts_as_tree

  belongs_to :project

  has_many :child, class_name: 'Directory', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Directory', foreign_key: 'parent_id'


  validates_presence_of :name

  accepts_nested_attributes_for :child

  has_many :data_sets

  before_validation do
    d = Directory.where(parent_id: self.parent_id, name: self.name, project_id: self.project_id)
    return if d.count.zero?
    if self.new_record?
      errors.add(:name, 'Directory with this name already exists.') if !d.count.zero?
    else
      errors.add(:name, 'Directory with this name already exists.') if self.id && d[0].id != self.id && !d.count.zero?
    end
  end

  before_destroy do
    self.files.destroy_all
    self.child.each { |dir| dir.files.destroy_all; dir.destroy! }
  end

  def files
    self.data_sets
  end

end
