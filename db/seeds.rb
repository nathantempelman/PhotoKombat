require 'net/http'
require 'json'

count = 0
for i in 1..5
  c = Category.create(name: "Cats-#{i}", nsfw: false)

  json = JSON.parse Net::HTTP.get('imgur.com', "/r/cats/top/day.json")
  json['data'].each do |image_json|
    url = "http://imgur.com/#{image_json['hash']}#{image_json['ext']}"
    picture = Picture.create(url: url, name: image_json['title'], rating: 1500, category: c)
    puts "~> Created image named #{image_json['title']} with URL #{url}"
    count += 1
  end

  puts "\n\nTried to create #{count.to_s} pictures!\nSucceeded with #{Picture.count} pictures."
end
