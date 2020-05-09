class StatsController < ApplicationController

	def index
		@urls  = Link.distinct.pluck(:url)
	end
	
end
