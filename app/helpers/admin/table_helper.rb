module Admin::TableHelper
  def admin_status_badge(active:, active_label: "Active", inactive_label: "Inactive")
    if active
      content_tag(
        :span,
        active_label,
        class: "inline-flex items-center rounded-full bg-green-100 px-2.5 py-1 text-xs font-medium text-green-700"
      )
    else
      content_tag(
        :span,
        inactive_label,
        class: "inline-flex items-center rounded-full bg-red-100 px-2.5 py-1 text-xs font-medium text-red-700"
      )
    end
  end

  def admin_badge(text, type: :default)
    classes =
      case type
      when :success
        "bg-green-100 text-green-700"
      when :danger
        "bg-red-100 text-red-700"
      when :warning
        "bg-yellow-100 text-yellow-700"
      when :info
        "bg-blue-100 text-blue-700"
      else
        "bg-slate-100 text-slate-700"
      end

    content_tag(
      :span,
      text,
      class: "inline-flex items-center rounded-full px-2.5 py-1 text-xs font-medium #{classes}"
    )
  end
end
