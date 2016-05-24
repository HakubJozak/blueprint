module Blueprint::Pagination
  extend ActiveSupport::Concern
  
  def current_page
    params.permit(:page)[:page].to_i || 1
  end
end
