# == Schema Information
#
# Table name: brands
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  type       :string(255)
#  state      :boolean
#

class Brand < ActiveRecord::Base
  # include Mongoid::Document
  scope :active, where(:state => true)
  scope :with_address, joins(:address)

  scope :custom_state, ->(state) { where(:state => state)}
  belongs_to :address
  # embeds_one :address
end
