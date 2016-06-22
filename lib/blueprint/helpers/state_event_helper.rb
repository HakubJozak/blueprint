module Blueprint::Helpers::StateEventHelper

  def state_events_dropdown( record, update_url)
    actions = record.state_events
    
    # use CanCan if possible
    if respond_to(:can?)
      actions.select! { |a| can?(a,record) }
    end

    links = actions.map { |a| event_link(record,a, update_url) }
    dropdown(links)
  end

  def event_link(record, event, update_url)
    prefix = record.class.name.underscore
    title = t("events.#{prefix}.#{event}")
    confirmation = translate_or_nil("confirmations.#{prefix}.#{event}",
                                    title: record.to_label)
    opts = { 'data-confirm' => confirmation }

    OpenStruct.new(title: title,
                   url: update_url,
                   opts: opts.merge(method: :patch))
  end

  private
  
  # HACK - move it elsewhere and make it smarter?
  def translate_or_nil(key,opts)
    missing = '--MISSING-KEY--'
    v = t(key,opts.merge(default: missing))

    if v == missing
      nil
    else
      v
    end
  end
  




end
