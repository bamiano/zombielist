json.array!(@favorites) do |favorite|
  json.extract! favorite, :id, :name, :image, :link
  json.url favorite_url(favorite, format: :json)
end
