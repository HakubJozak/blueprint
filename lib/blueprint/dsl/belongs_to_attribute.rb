module Blueprint
  module Dsl
    class BelongsToAttribute < PlainAttribute
      def to_whitelist
        ":#{name}_id"
      end

      def simple_form_input(builder = 'f')
        "= #{builder}.association :#{name}"
      end
    end
  end
end
