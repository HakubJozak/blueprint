module Blueprint::StateHelper

  def state_label(record)
    c = state_color(record.state_name)
    content_tag :span, class: "label label-#{c}" do
      state_name(record)
    end
  end

  def state_name(record)
    model = record.class.model_name.to_s.underscore
    t("states.#{model}.#{record.state}")
  end

  def state_color(name)
    case name.to_sym
    when :completed, :active, :done, :sent, :published, :confirmed
      'success'
    when :cancelled
      'danger'
    when :pending
      'warning'
    else
      'default'
    end
  end
  
end
