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
      end
    end

    class FormBuilder
      include WdFormBuilder::FormBuilderMethods
    end

  end
end
