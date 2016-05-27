module Blueprint::Sortable
  extend ActiveSupport::Concern

  module ClassMethods
    # FIXME: whitelist columns
    # TODO: prefer scopes
    def sort_by_params(params)
      desc = params[:desc]
      column = params[:sort]

      if column
        method = "order_by_#{column}"
        direction = desc.present? ? :desc : :asc

        if respond_to?(method)
          send(method,direction)
        else
          order(column =>  direction)
        end
      else
        where(nil)
      end
    end
  end
end
