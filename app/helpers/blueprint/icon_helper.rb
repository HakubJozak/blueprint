module Blueprint::IconHelper

  def icon(name, title = nil)
    i = "<i class='fa fa-#{name}'></i>"
    [ i, title ].compact.join(' ').html_safe
  end

  def icon_with_tooltip(name, title, tooltip)
    %(<i class="fa fa-#{name} popover-me" title="#{title}" data-content="#{tooltip}"></i>).html_safe
  end

end
