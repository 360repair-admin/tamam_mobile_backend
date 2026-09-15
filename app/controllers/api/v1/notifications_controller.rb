class Api::V1::NotificationsController < Api::BaseController
  def index
    notifications = current_customer.notifications.or(Notification.public_notifications).order(created_at: :desc)
    render json: { notifications: notifications }
  end

  def update
    notification = current_customer.notifications.find(params[:id])
    notification.update!(read_at: Time.current)
    render json: { notification: notification }
  end

  private

  def visible_notifications
    Notification.where(
      "customer_id = :customer_id OR (customer_id IS NULL AND created_at >= :customer_created_at)",
      customer_id: current_customer.id,
      customer_created_at: current_customer.created_at
    )
  end
end
