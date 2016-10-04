module Blueprint::StateFilteringHelper
  def state_select_options(model, opts = {})
    opts = model.group(:state).count.map { |state,_|
      if to_exclude = opts[:exclude]
        next if state.to_sym.in? to_exclude
      end

      name = t("states.#{model.name.underscore}.#{state}")
      [ name, state ]
    }.compact

    options_for_select(opts, filter_params[:with_state])
  end

  def state_filter_select(model, opts = {})
    select_tag :with_state,
               state_select_options(model, opts),
               class: 'form-control',
               include_blank: t("states.#{model.name.underscore}.all")
  end


end
