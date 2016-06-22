module Blueprint::SortingHelper
  def sort_link(label,by)
    opts = filter_params.merge(sort: by)

    if current_sort == by.to_s
      # flip the sorting direction
      opts[:desc] = (!descending_sort?) ? '1' : '0'
      dir = descending_sort? ? 'desc' : 'asc'
      arrow = icon "sort-#{dir}"
    end

    link_to "#{label} #{arrow}".html_safe, url_for(opts)
  end

end
