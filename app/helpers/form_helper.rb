module FormHelper

  def cancel_button(*args)
    path = args.pop
    text = args.first || "Cancel"
    if path.respond_to?(:new_record) && path.new_record?
      path = [:index, path]
    end
    link_button(text, path, class: "cancel")
  end

  def delete_button(*args)
    path = args.pop
    text = args.first || "Delete"
    link_button(text, path,
                method: :delete, confirm: "Are you sure?", class: "delete")
  end

  def edit_button(*args)
    path = args.pop
    text = args.first || "Edit"
    link_button(text, [:edit, path], class: "edit")
  end

  def new_button(*args)
    path = args.pop
    text = args.first || "New #{params[:controller].singularize.capitalize}"
    link_button(text, path, class: "new")
  end


  protected

  def link_button(text, path, options={})
    link_to(text, path, options)
  end
end
