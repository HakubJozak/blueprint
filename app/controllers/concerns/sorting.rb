module Blueprint::Sorting
  extend ActiveSupport::Concern

  included do
    helper_method :current_sort
    helper_method :descending_sort?
  end

  def current_sort
    filter_params[:sort] || default_sort
  end

  def descending_sort?
    if filter_params[:desc].present?
      filter_params[:desc].to_i == 1
    else
      default_descending_sort
    end
  end

  def default_sort
    :created_at
  end

  def default_descending_sort
    false
  end

end
