# frozen_string_literal: true

module ApplicationHelper
  # Helper method to display different toast messages, feel free to add more types if necessary
  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = 'success' if type == 'notice'
      type = 'error' if type == 'alert'
      text = "<script>toastr.#{type}('#{message}', '', { closeButton: true })</script>"
      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end

  # Helper methods to use devise form anywhere in the app
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def show_errors(object, field_name)
    if object.errors.any?
      if !object.errors.messages[field_name].blank?
        object.errors.messages[field_name].join(", ")
      end
    end
  end 
end
