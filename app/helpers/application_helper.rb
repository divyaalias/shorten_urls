module ApplicationHelper
	def get_record(url)
		Link.find_by_url(url)
	end
end
