module Blueprint
  module Dsl
    class Model
      attr_reader :fields

      def initialize(name)
        @name = name
        @fields = []
      end

      def fields_whitelist
        @fields.map(&:to_whitelist).join(",")
      end

      %i( boolean decimal text string datetime date integer json ).each do |type|
        define_method type do |name,opts = {}|
          @fields << ::Blueprint::Dsl::PlainAttribute.new(name)
        end
      end

      # HACK - rewrite
      def has_many(name,opts = {},&block)
        model = ::Blueprint::Dsl::Model.new(name.to_s.singularize)
        model.instance_eval &block
        field = ::Blueprint::Dsl::HasManyField.new(name,model)
        @fields << field
      end

      def belongs_to(name,opts = {})
        @fields << ::Blueprint::Dsl::BelongsToAttribute.new(name)
      end

      # TODO: move to Blueprint::AllGenerator
      def run_crud_generator!(generator)
        with_parent_generator(generator) do
          opts = { behavior: @generator.behavior }
          opts.merge!(@generator.options)
          force_flag = opts['force'] ? '--force' : nil

          say! @name.capitalize
          ::Rails::Generators.invoke 'crud', [ "admin/#{@name.to_s}", force_flag ].flatten, opts
        end
      end

      private

      def with_parent_generator(g)
        @generator = g
        yield
        g = nil
      end

      def say!(msg)
        @generator.say msg, output_color
      end

      def output_color
        if @generator.behavior == :invoke
          # generate
          :green
        else
          # destroy
          :red
        end
      end
    end
  end
end
