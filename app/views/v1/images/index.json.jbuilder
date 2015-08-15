json.images do
	json.array! @images do |image|
		json.image image

		json.sizes do
			json.array! image.image_sizes do |size|
				json.width size.width
				json.height size.height

				present size do |p|
					json.link p.link
				end
			end
		end
	end
end