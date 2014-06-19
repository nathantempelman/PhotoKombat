require 'net/http'
require 'json'

c = Category.new(name: 'Cats')

count = 0
for page in 0..5 # 50 is the highest we can put the page here.
  puts "\n Page ##{page.to_s}"
  json = JSON.parse Net::HTTP.get('imgur.com', "/r/cats.json/page/#{page}")
  json['data'].each do |image_json|
    url = "http://imgur.com/#{image_json['hash']}#{image_json['ext']}"
    picture = Picture.create(url: url, name: image_json['title'], rating: 1500, category: c)
    puts "~> Created image named #{image_json['title']} with URL #{url}"
    count += 1
  end
end
puts "\n\nTried to create #{count.to_s} pictures!\nSucceeded with #{Picture.count} pictures."
