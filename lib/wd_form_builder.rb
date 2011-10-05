require 'action_view/helpers'
require 'active_support/i18n'
require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/object/blank'
require 'dynamic_form'


module ActionView
  module Helpers
    module WdFormBuilder

      def error_message_on(object, method, *args)
        options = args.extract_options!
        options.reverse_merge!(html_tag: "span",
                               css_class: "error_explanation")
        super(object, method, *(args << options))
      end

      module FormBuilderMethods
        def error_message_on(method, *args)
          @template.error_message_on(@object || @object_name, method, *args)
        end

        def error_messages(options = {})
          @template.error_messages_for(@object_name, objectify_options(options))
        end

        def revision_picker(name, options={})
          num_versions = object.versions.count
          values = @template.options_for_select((num_versions + 1).downto(1),
                                                options.delete(:selected))
          @template.select_tag(:"rev_#{name}", values, options)
        end

        def has_many_fields_for(rel_name, rel_objects=nil, &block)
          objects = rel_objects || rel_name
          objects.build unless objects.any?(&:new_record?)
          fields_for(rel_name, rel_objects, &block)
        end
      end
    end

    class FormBuilder
      include WdFormBuilder::FormBuilderMethods
    end

  end
end
