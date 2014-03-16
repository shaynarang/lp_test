class Key < ActiveRecord::Base
  belongs_to :section
  has_many :values, :dependent => :destroy
  accepts_nested_attributes_for :values
end
