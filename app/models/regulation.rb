# == Schema Information
#
# Table name: regulations
#
#  id              :bigint           not null, primary key
#  action          :string
#  citation        :string
#  comment_count   :integer
#  document_number :string
#  original_url    :string
#  pdf_url         :string
#  raw_url         :string
#  register_url    :string
#  significant     :boolean
#  summary         :string
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint
#
# Indexes
#
#  index_regulations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Regulation < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  serialize :agency_names, Array

end
