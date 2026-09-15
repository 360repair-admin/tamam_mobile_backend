module Admin::SidebarHelper
  def admin_sidebar_menu
    [
      {
        label: "Dashboard",
        path: admin_root_path,
        permission: nil,
        implemented: true,
        active: -> { request.path == admin_root_path }
      },
      {
        label: "Customers",
        path: admin_customers_path,
        permission: :customers_view,
        implemented: true,
        active: -> { request.path.start_with?("/admin/customers") }
      },
      {
        label: "Notifications",
        path: nil,
        permission: :notifications_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/notifications") }
      },
      {
        label: "Addresses",
        path: nil,
        permission: :addresses_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/addresses") }
      },
      {
        label: "Vehicle Makes",
        path: admin_vehicle_makes_path,
        permission: :vehicle_makes_view,
        implemented: true,
        active: -> { request.path.start_with?("/admin/vehicle_makes") }
      },
      {
        label: "Vehicle Models",
        path: nil,
        permission: :vehicle_models_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/vehicle_models") }
      },
      {
        label: "Countries",
        path: nil,
        permission: :countries_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/countries") }
      },
      {
        label: "Regions",
        path: nil,
        permission: :regions_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/regions") }
      },
      {
        label: "Cities",
        path: nil,
        permission: :cities_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/cities") }
      },
      {
        label: "OTP Requests",
        path: nil,
        permission: :otp_requests_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/otp_requests") }
      },
      {
        label: "SMS Messages",
        path: nil,
        permission: :sms_messages_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/sms_messages") }
      },
      {
        label: "SMS Templates",
        path: nil,
        permission: :sms_templates_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/sms_templates") }
      },
      {
        label: "Auth Sessions",
        path: nil,
        permission: :auth_sessions_view,
        implemented: false,
        active: -> { request.path.start_with?("/admin/auth_sessions") }
      },
      {
        label: "Colors",
        path: admin_colors_path,
        permission: :colors_view,
        implemented: true,
        active: -> { request.path.start_with?("/admin/colors") }
      },
      {
        label: "Developer Tools",
        permission: nil,
        implemented: true,
        children: [
          {
            label: "Swagger Docs",
            path: nil,
            permission: :swagger_docs_view,
            implemented: false,
            active: -> { request.path.start_with?("/admin/swagger_docs") }
          },
          {
            label: "Errors",
            path: Faulty::Engine.routes.url_helpers.errors_path,
            permission: :faulty_errors_view,
            implemented: true,
            active: -> { request.path.start_with?("/errors") }
          }
        ]
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
end
