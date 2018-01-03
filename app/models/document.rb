# == Schema Information
#
# Table name: documents
#
#  id             :integer          not null, primary key
#  name           :string
#  description    :text
#  assigned_file  :string
#  submitted_file :string
#  company_id     :integer
#  employee_id    :integer
#  employer_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Document < ApplicationRecord
  mount_uploader :assigned_file, FileUploader
  mount_uploader :submitted_file, FileUploader

  belongs_to :company
  belongs_to :employee
  belongs_to :employer

  validates :name,              presence: true
  validates :employer,          presence: true
  validates :employee,          presence: true
  # validates :assigned_file,     presence: true, if: :is_employer?
  # validates :submitted_file,    presence: true, if: :is_employee?
end
