require File.join(File.dirname(__FILE__), "../../lib/wd_form_builder.rb")


class ActionView::Base
  include WdFormBuilder
end
