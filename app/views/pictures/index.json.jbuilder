json.array!(@pictures) do |picture|
  json.extract! picture, :id, :name, :url, :user_id, :rating
  json.url picture_url(picture, format: :json)
end
