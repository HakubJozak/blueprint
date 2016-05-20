module Blueprint
  module Dsl
    class Blueprint::PlainAttribute  < Struct.new(:name)
      def to_str
        name.to_s
      end

      alias :to_s :to_str

      def to_whitelist
        ":#{name}"
      end

      def simple_form_input(builder = 'f')
        "= #{builder}.input :#{name}"
      end
    end
  end
end
