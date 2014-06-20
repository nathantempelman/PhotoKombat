require 'test_helper'

class PicturesHelperTest < ActionView::TestCase
	@@gallery_url = "http://imgur.com/gallery/JThDN"
	@@album_url ="http://imgur.com/a/VqUKy" 
	@@direct_url = "http://i.imgur.com/4fVCo5v.jpg"
	@@page_url = "http://imgur.com/4fVCo5v"
	@@five_url = "http://i.imgur.com/bSGJy.jpg"

	@@correct_format_regex = /\A(?:https?:\/\/)?(?:www\.)?i\.imgur\.com\/((?:\w|\d){5,7})(\w)?\.(gif|jpg|png)\z/i

	test "should format gallery urls correctly" do
		assert imgur_format(@@gallery_url).match(correct_format_regex)
	end

	test "should format album urls correctly" do
		assert imgur_format(@@album_url).match(correct_format_regex)
	end

	test "should format direct urls correctly" do
		assert imgur_format(@@direct_url).match(correct_format_regex)
	end

	test "should format page urls correctly" do
		assert imgur_format(@@page_url).match(correct_format_regex)
	end

	test "should format five character code urls correctly" do
		assert imgur_format(@@five_url).match(correct_format_regex)
	end

	test "should add small square image size flag properly" do
		assert imgur_small_square(@@direct_url).match(@@correct_format_regex) do |match|
			assert match[2] == "s"
		end
	end

	test "should add big square image size flag properly" do
		assert imgur_big_square(@@direct_url).match(@@correct_format_regex) do |match|
			assert match[2] == "b"
		end
	end

	test "should add medium image size flag properly" do
		assert imgur_medium(@@direct_url).match(@@correct_format_regex) do |match|
			assert match[2] == "m"
		end
	end

	test "should add large image size flag properly" do
		assert imgur_large(@@direct_url).match(@@correct_format_regex) do |match|
			assert match[2] == "l"
		end
	end


end
