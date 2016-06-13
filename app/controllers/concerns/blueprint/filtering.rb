module Blueprint::Filtering
  extend ActiveSupport::Concern

  included do
    helper_method :filter_params
  end

  # def current_filter
  #   { by_category: filter_params[:by_category],
  #     by_year: filter_params[:by_year],
  #     page: current_page }
  # end

  def filter_params
    # TODO: overload these
    # params.permit
    {}
  end

end
