module Blueprint::Helpers::StateEventHelper

  def state_events_dropdown( record, route)
    actions = record.state_events

    # use CanCan if possible
    if respond_to? :can?
      actions.select! { |a| can?(a,record) }
    end

    links = actions.map { |a| event_link(record,a, route) }
    dropdown(links)
  end

  def event_link(record, event, route)
    model_name = record.class.name.underscore.to_sym

    title = t("events.#{model_name}.#{event}")
    confirmation = translate_or_nil("confirmations.#{model_name}.#{event}",
                                    title: record.to_label)
    opts = { 'data-confirm' => confirmation }

    update_url = public_send(route, record.id, model_name => { state_event: event })

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
