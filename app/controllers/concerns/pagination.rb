module Blueprint::Pagination
  extend ActiveSupport::Concern

  included do
    helper_method :current_page
  end
  
  def current_page
    params.permit(:page)[:page].to_i || 1
  end
end
