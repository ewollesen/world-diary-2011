# -*- coding: utf-8 -*-
module RevisionsHelper

  def revisions_form_for(object, &block)
    url = send("revisions_#{object.class.name.underscore}_path")
    options = {:url => url, :html => {:method => :get}}
    form_for(object, options, &block)
  end

  def show_changes(text_left, date_left, text_right, date_right)
    output_left, output_right = [], []
    changes = Diff::LCS.sdiff(text_left.split("\n"), text_right.split("\n"))
    changes.each do |change|
      left_element = change.old_element.blank? ? " ".html_safe : change.old_element
      right_element = change.new_element.blank? ? " ".html_safe : change.new_element

      case change.action
      when "!"
        output_left << text_delete(left_element, true)
        output_right << text_insert(right_element, true)
      when "="
        output_left << content_tag("div", left_element)
        output_right << content_tag("div", right_element)
      when "+"
        output_left << content_tag("div", left_element)
        output_right << text_insert(right_element)
      when "-"
        output_left << text_delete(left_element)
        output_right << content_tag("div", right_element)
      else
        raise "Unhandled change action: #{change.action.inspect}"
      end
    end

    render "changes", :output_left => output_left,
                      :output_right => output_right,
                      :date_left => date_left,
                      :date_right => date_right
  end


  private

  def text_delete(text, change=false)
    content_tag("del", h(text), :class => change ? "change" : "")
  end

  def text_insert(text, change=false)
    content_tag("ins", h(text), :class => change ? "change" : "")
  end

end
