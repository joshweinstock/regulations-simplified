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
#  significant     :string
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Regulation < ApplicationRecord
end
