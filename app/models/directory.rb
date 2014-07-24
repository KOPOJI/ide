class Directory < ActiveRecord::Base

  extend ActsAsTree::TreeView

  acts_as_tree

  belongs_to :project

  has_many :child, class_name: 'Directory', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Directory', foreign_key: 'parent_id'

  validates_presence_of :name

  accepts_nested_attributes_for :child

  has_many :data_sets

  def files
    self.data_sets
  end

end
