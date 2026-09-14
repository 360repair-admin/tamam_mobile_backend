module Admin::SidebarHelper
  def admin_sidebar_menu
    [
      {
        label: "Dashboard",
        path: admin_dashboard_path,
        icon: :dashboard,
        permission: nil,
        implemented: true,
        active: -> { request.path == admin_dashboard_path }
      },
      {
        label: "Customers",
        path: admin_customers_path,
        icon: :customers,
        permission: :customers_view,
        badge: -> { Customer.count },
        implemented: true,
        active: -> { request.path.start_with?("/admin/customers") }
      },
      {
        label: "Notifications",
        path: nil,
        icon: :notifications,
        permission: :notifications_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/notifications") }
      },
      {
        label: "Addresses",
        path: nil,
        icon: :addresses,
        permission: :addresses_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/addresses") }
      },
      {
        label: "Vehicle Makes",
        path: admin_vehicle_makes_path,
        icon: :vehicle_make,
        permission: :vehicle_makes_view,
        implemented: true,
        active: -> { request.path.start_with?("/admin/vehicle_makes") }
      },
      {
        label: "Vehicle Models",
        path: nil,
        icon: :vehicle_model,
        permission: :vehicle_models_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/vehicle_models") }
      },
      {
        label: "Countries",
        path: nil,
        icon: :countries,
        permission: :countries_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/countries") }
      },
      {
        label: "Regions",
        path: nil,
        icon: :regions,
        permission: :regions_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/regions") }
      },
      {
        label: "Cities",
        path: nil,
        icon: :cities,
        permission: :cities_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/cities") }
      },
      {
        label: "OTP Requests",
        path: nil,
        icon: :otp,
        permission: :otp_requests_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/otp_requests") }
      },
      {
        label: "SMS Messages",
        path: nil,
        icon: :sms,
        permission: :sms_messages_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/sms_messages") }
      },
      {
        label: "SMS Templates",
        path: nil,
        icon: :template,
        permission: :sms_templates_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/sms_templates") }
      },
      {
        label: "Auth Sessions",
        path: nil,
        icon: :sessions,
        permission: :auth_sessions_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/auth_sessions") }
      },
      {
        label: "Errors",
        path: nil,
        icon: :error,
        permission: :faulty_errors_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/faulty_errors") }
      }
    ]
  end

  def admin_sidebar_item_visible?(item)
    return false unless item[:implemented]
    return true if item[:permission].blank?

    # Permission system will be added here later.
    true
  end

  def admin_sidebar_item_active?(item)
    active = item[:active]

    return false if active.blank?
    return active.call if active.respond_to?(:call)

    active
  end

  def admin_sidebar_badge(item)
    badge = item[:badge]

    return nil if badge.blank?

    badge.respond_to?(:call) ? badge.call : badge
  end

  def admin_sidebar_icon(name)
    case name
    when :dashboard
      content_tag(:svg,
        content_tag(
          :path,
          nil,
          stroke_linecap: "round",
          stroke_linejoin: "round",
          d: "M3 13h8V3H3v10zm10 8h8V3h-8v18zM3 21h8v-6H3v6z"
        ),
        class: "h-5 w-5 flex-shrink-0",
        fill: "none",
        viewBox: "0 0 24 24",
        stroke: "currentColor",
        stroke_width: "1.8"
      )

    when :customers
      content_tag(
        :svg,
        safe_join([
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            stroke_linejoin: "round",
            d: "M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2"
          ),
          content_tag(:circle, nil, cx: "9", cy: "7", r: "4"),
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            stroke_linejoin: "round",
            d: "M22 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"
          )
        ]),
        class: "h-5 w-5 flex-shrink-0",
        fill: "none",
        viewBox: "0 0 24 24",
        stroke: "currentColor",
        stroke_width: "1.8"
      )

    when :notifications
      content_tag(
        :svg,
        safe_join([
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            stroke_linejoin: "round",
            d: "M15 17H9m9-5a6 6 0 00-12 0c0 7-3 7-3 7h18s-3 0-3-7"
          ),
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            stroke_linejoin: "round",
            d: "M13.73 21a2 2 0 01-3.46 0"
          )
        ]),
        class: "h-5 w-5 flex-shrink-0",
        fill: "none",
        viewBox: "0 0 24 24",
        stroke: "currentColor",
        stroke_width: "1.8"
      )

    when :addresses
      content_tag(
        :svg,
        safe_join([
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            stroke_linejoin: "round",
            d: "M12 21s7-5.2 7-11a7 7 0 10-14 0c0 5.8 7 11 7 11z"
          ),
          content_tag(:circle, nil, cx: "12", cy: "10", r: "2.5")
        ]),
        class: "h-5 w-5 flex-shrink-0",
        fill: "none",
        viewBox: "0 0 24 24",
        stroke: "currentColor",
        stroke_width: "1.8"
      )

    when :vehicle_make, :vehicle_model
      content_tag(
        :svg,
        safe_join([
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            stroke_linejoin: "round",
            d: "M5 17h14l-1-7H6l-1 7z"
          ),
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            stroke_linejoin: "round",
            d: "M7 10l2-4h6l2 4"
          ),
          content_tag(:circle, nil, cx: "8", cy: "18", r: "1.5"),
          content_tag(:circle, nil, cx: "16", cy: "18", r: "1.5")
        ]),
        class: "h-5 w-5 flex-shrink-0",
        fill: "none",
        viewBox: "0 0 24 24",
        stroke: "currentColor",
        stroke_width: "1.8"
      )

    when :countries, :regions, :cities
      content_tag(
        :svg,
        safe_join([
          content_tag(:circle, nil, cx: "12", cy: "12", r: "9"),
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            stroke_linejoin: "round",
            d: "M3 12h18M12 3a14 14 0 010 18M12 3a14 14 0 000 18"
          )
        ]),
        class: "h-5 w-5 flex-shrink-0",
        fill: "none",
        viewBox: "0 0 24 24",
        stroke: "currentColor",
        stroke_width: "1.8"
      )

    when :otp
      content_tag(
        :svg,
        safe_join([
          content_tag(
            :rect,
            nil,
            x: "4",
            y: "4",
            width: "16",
            height: "16",
            rx: "2"
          ),
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            d: "M8 8h.01M12 8h.01M16 8h.01M8 12h.01M12 12h.01M16 12h.01M8 16h8"
          )
        ]),
        class: "h-5 w-5 flex-shrink-0",
        fill: "none",
        viewBox: "0 0 24 24",
        stroke: "currentColor",
        stroke_width: "1.8"
      )

    when :sms
      content_tag(
        :svg,
        content_tag(
          :path,
          nil,
          stroke_linecap: "round",
          stroke_linejoin: "round",
          d: "M4 5h16v11H8l-4 4V5z"
        ),
        class: "h-5 w-5 flex-shrink-0",
        fill: "none",
        viewBox: "0 0 24 24",
        stroke: "currentColor",
        stroke_width: "1.8"
      )

    when :template
      content_tag(
        :svg,
        safe_join([
          content_tag(
            :rect,
            nil,
            x: "5",
            y: "3",
            width: "14",
            height: "18",
            rx: "2"
          ),
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            d: "M8 8h8M8 12h8M8 16h5"
          )
        ]),
        class: "h-5 w-5 flex-shrink-0",
        fill: "none",
        viewBox: "0 0 24 24",
        stroke: "currentColor",
        stroke_width: "1.8"
      )

    when :sessions
      content_tag(
        :svg,
        safe_join([
          content_tag(
            :rect,
            nil,
            x: "4",
            y: "5",
            width: "16",
            height: "14",
            rx: "2"
          ),
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            d: "M8 9h8M8 13h5"
          )
        ]),
        class: "h-5 w-5 flex-shrink-0",
        fill: "none",
        viewBox: "0 0 24 24",
        stroke: "currentColor",
        stroke_width: "1.8"
      )

    when :error
      content_tag(
        :svg,
        safe_join([
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            stroke_linejoin: "round",
            d: "M12 3l9 16H3L12 3z"
          ),
          content_tag(
            :path,
            nil,
            stroke_linecap: "round",
            d: "M12 9v4M12 16h.01"
          )
        ]),
        class: "h-5 w-5 flex-shrink-0",
        fill: "none",
        viewBox: "0 0 24 24",
        stroke: "currentColor",
        stroke_width: "1.8"
      )

    else
      content_tag(
        :svg,
        nil,
        class: "h-5 w-5 flex-shrink-0",
        fill: "none",
        viewBox: "0 0 24 24",
        stroke: "currentColor",
        stroke_width: "1.8"
      )
    end
  end
end
