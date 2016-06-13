module Blueprint
  module Dsl
    class HasManyField < PlainAttribute
      attr_reader :model

      def initialize(name,model,opts = {})
        super(name)
        @model = model
      end

      def to_arg
        nil
      end

      def to_whitelist
        "#{name}_attributes: [ #{@model.fields_whitelist} ]"
      end

      def simple_form_input(builder = 'f')
        <<EOS
h3 #{name.to_s.capitalize}

= #{builder}.simple_fields_for :#{name} do |ff|
  .tab-pane id="#{name}-\#{ff.object.id}"
    = render '#{name}_form', f: ff
EOS
      end
    end
  end
end
