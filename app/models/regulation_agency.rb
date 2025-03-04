# == Schema Information
#
# Table name: regulation_agencies
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  agency_id     :integer
#  regulation_id :integer
#
class RegulationAgency < ApplicationRecord
end
