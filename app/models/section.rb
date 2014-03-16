class Section < ActiveRecord::Base
  belongs_to :upload
  has_many :keys, :dependent => :destroy
  accepts_nested_attributes_for :keys
end
