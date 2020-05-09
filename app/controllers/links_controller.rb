class LinksController < ApplicationController
	before_action :set_post, only: [:show, :fetch_original_url]
  
  def create_url
    if params[:url]
      @link =  Link.new(url: params[:url])
        if @link.url_exists?
          @link = Link.find_by_url(params[:url])
          redirect_to @link, notice: "Short link for this url is already exists in db. Please use the below given short url"
        else
          respond_to do |format|
            if @link.save
              format.js
              format.html
            else
              format.js { render json: @link.errors , status: :unprocessable_entity}
              format.html
            end
          end
        end
      else
        @link = Link.new
      end
    @records = load_last_three_records
  end

  def fetch_original_url
     @link = Link.find(params[:id])
    return render_not_found if @link.expired?
    @link.update(clicked: @link.clicked + 1)
    get_url_analytics!
    redirect_to @link.url
  end
 
 def show
 end

  private

  def set_post
    @link = Link.find(params[:id])
  end

  def load_last_three_records
  	return records = Link.last(3).reverse
  end

  def get_url_analytics!
    results = Geocoder.search(request.ip)
    country = results.first.country
    state = results.first.state
    Stat.create(link_id: params["id"], country: country, state: state)
  end
  
end
