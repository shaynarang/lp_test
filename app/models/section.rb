class Section < ActiveRecord::Base
  belongs_to :upload
  has_many :key_value_pairs, :dependent => :destroy
  accepts_nested_attributes_for :key_value_pairs
end
