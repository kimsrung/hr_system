class Document < ApplicationRecord
  belongs_to :company_id
  belongs_to :employee_id
end
