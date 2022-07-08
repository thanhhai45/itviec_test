# == Schema Information
#
# Table name: users
#
#  id     : integer          not null, primary key
#  status : string
#  city   : string
#

class User < ActiveRecord::Base
  enum status: { active: 0, inactive: 1, banned: 2, pending: 3 } 
  enum city: { hcm: 'HCM', hn: 'HN', dn: 'DN', other: 'Other' }
  
  # def exists?(status, city)
  #   pluck(:status, :city).count{|user| user.status == status && user.city == city} > 0
  # end

  # I think we should not be define name methods like rails methods
  # exists? is rails methods

  # Change name method and optimize code
  def existence?(status, city)
    status = User.statuses["#{status}"]
    city = User.cities["#{city}"]
    where("status = ? and city = ?", status, city).exists?
  end
end
