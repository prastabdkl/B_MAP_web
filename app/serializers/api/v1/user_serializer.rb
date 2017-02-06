class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :is_admin, :activated, :created_at, :activated,
             :address, :bank_name, :account_number, :nationality, :mobile,
             :home, :work, :image

  has_one :account
  has_many :capitals

	def created_at
		object.created_at.in_time_zone.iso8601 if object.created_at
	end

	def updated_at
		object.updated_at.in_time_zone.iso8601 if object.created_at
	end
end
