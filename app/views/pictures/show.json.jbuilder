json.extract! @picture, :id, :name, :url, :rating, :created_at, :updated_at
json.user do
  json.username @picture.user.try(:username)
  json.id @picture.user.try(:id)
end
