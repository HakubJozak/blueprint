module Blueprint
  module Dsl
    class PlainAttribute < Struct.new(:name,:type)
      def to_str
        name.to_s
      end

      alias :to_s :to_str

      # can be used as a Rails generator argument
      def to_arg
        [ name, type ].join ':'
      end

      # symbol for controller whitelist
      def to_whitelist
        ":#{name}"
      end

      def simple_form_input(builder = 'f')
        "= #{builder}.input :#{name}"
      end
    end
  end
end
