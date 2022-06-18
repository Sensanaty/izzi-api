class CompanySerializer
  include JSONAPI::Serializer
  attributes :name, :address, :city, :country, :website, :type, :subscription
end
