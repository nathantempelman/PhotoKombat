module PicturesHelper
	@@type1Regex = /\A(?:https?:\/\/)?(?:www\.)?(?:i\.)imgur\.com\/((?:\w|\d){7})(\w)?(?:\.(gif|jpg|png))\z/i
	@@type2Regex = /\A(?:https?:\/\/)?(?:www\.)?imgur\.com\/((?:\w|\d){7})(\w)?\z/i
	@@imgur_regex = /\A(?:https?:\/\/)?(?:www\.)?(?:i\.)?imgur\.com\/(?:gallery\/)?((?:\w|\d){7}|(?:\w|\d){5})(\w)?(?:\.(gif|jpg|png))?\z/i
		# 3 types of imgur links, in order of desirability
	# 	
	# 1 	directly to the image file, such as http://i.imgur.com/4fVCo5v.jpg
	# 2 	page with a single image, such as 	http://imgur.com/4fVCo5v
	# 3     albums, such as 					http://imgur.com/a/VqUKy
	# oh and also, images in a gallery 			http://imgur.com/gallery/JThDN

	# also, it appears the code can be 5 long	http://i.imgur.com/bSGJy.jpg
	# but mostly it's seven long 				http://i.imgur.com/4fVCo5v.jpg

	#ideally, they would all be the last type, minus http://. Perhaps convert?
	#    Also, it doesn't matter what filename is specified at the end, 
	# just so long as there is one

	#Finally, adding s, m, or l after the image code but before the .ext returns 
	# small medium or large versions of the picture.

	# Format image url to http://i.imgur.com/xxxxx.ext 
	def imgur_format!(url)
		if match = @@imgur_regex.match(url) 
			if match[3]
				url = "http://i.imgur.com/"+match[1]+"."+match[3]
			else
				url = "http://i.imgur.com/"+match[1]+".jpg"
			end
		else
			url = "somethinghasgonehorriblywrong.jpg"
		end
		
	end
	def imgur_format(url)
		if match = @@imgur_regex.match(url) 
			if match[3]
				"http://i.imgur.com/"+match[1]+"."+match[3]
			else
				"http://i.imgur.com/"+match[1]+".jpg"
			end
		else
			"somethinghasgonehorriblywrong.jpg"
		end
		
	end

	# this one should return an imgur link for a thumbnail, 90x90
	def imgur_small_square(url)
		url.match(@@type1Regex) do |match|
			"http://i.imgur.com/"+match[1]+"s"+"."+match[3]
		end
	end
	def imgur_big_square(url)
		url.match(@@type1Regex) do |match|
			"http://i.imgur.com/"+match[1]+"b"+"."+match[3]
		end
	end
	# this one should return an imgur link for a medium sized picture, 320x?
	def imgur_medium(url)
		url.match(@@type1Regex) do |match|
			"http://i.imgur.com/"+match[1]+"m"+"."+match[3]
		end
	end
	# this one should return an imgur link for a large sized picture, 640x?
	def imgur_large(url)
		url.match(@@type1Regex) do |match|
			"http://i.imgur.com/"+match[1]+"l"+"."+match[3]
		end
	end
end
