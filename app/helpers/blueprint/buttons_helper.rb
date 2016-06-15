module Blueprint::ButtonsHelper

  def create_button(text,url)
    title = "#{icon('plus')} #{text}".html_safe
    link_to(title, url, class: 'btn btn-success')
  end
  
  def delete_button(record, path, opts = { label: 'Smazat' })
    name = record.try(:full_title) || record.try(:title) || record.try(:to_label)
    question = t('really_delete',title: name)
    ico = icon 'trash'

    opts.reverse_merge!('data-confirm' => question,
                        method: :delete,
                        class: 'btn btn-default pull-right')

    link_to( ico, path, opts).html_safe
  end  

end
