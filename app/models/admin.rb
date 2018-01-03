# == Schema Information
#
# Table name: admins
#
#  id                 :integer          not null, primary key
#  email              :string
#  encrypted_password :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Admin < ApplicationRecord
  devise :database_authenticatable, :timeoutable
end
