module Faulty
  class ErrorsController < ApplicationController
    before_action :set_error, only: [:show, :resolve, :assign]

    def index
      @page     = params.fetch(:page, 1).to_i
      @per_page = 20

      @errors = Faulty::Error.order(last_event_at: :desc)

      # Status filter
      if params[:status].present?
        @errors = @errors.where(status: params[:status])
      end

      # Assignee filter
      if params[:assigned_to].present?
        if params[:assigned_to] == "unassigned"
          @errors = @errors.where(assigned_to_id: nil)
        else
          @errors = @errors.where(assigned_to_id: params[:assigned_to])
        end
      end

      # Date range has higher priority
      if params[:from_date].present? && params[:to_date].present?
        from_date = Date.parse(params[:from_date]) rescue nil
        to_date   = Date.parse(params[:to_date]) rescue nil

        if from_date && to_date
          @errors = @errors.where(last_event_at: from_date.beginning_of_day..to_date.end_of_day)
        end

      elsif params[:timeframe].present?
        cutoff =
          case params[:timeframe]
          when "24h" then 24.hours.ago
          when "7d"  then 7.days.ago
          when "30d" then 30.days.ago
          end

        @errors = @errors.where("last_event_at >= ?", cutoff) if cutoff
      end

      @total_count = @errors.count

      @errors = @errors
              .offset((@page - 1) * @per_page)
              .limit(@per_page)

      @authorized_users = Faulty.resolved_authorized_users
    end

    def show
      @authorized_users = Faulty.resolved_authorized_users
    end

    def resolve
      @error.update!(
        status: params[:status],
        resolved_by: Faulty.current_faulty_user.call(self),
        resolved_at: Time.current
      )
      redirect_to error_path(@error), notice: "Error marked as #{params[:status].capitalize}"
    end

    def assign
      assignee_id = params[:assignee_id]

      assignee = Faulty.resolved_authorized_users.find { |u| u.id.to_s == assignee_id.to_s }

      if assignee.present?
        @error.update!(
          assigned_to: assignee,
          assigned_by: Faulty.current_faulty_user.call(self),
          assigned_at: Time.current
        )

        respond_to do |format|
          format.json { render json: { success: true, assignee: assignee.email } }
        end
      else
        respond_to do |format|
          format.json { render json: { success: false, message: "Invalid assignee selected" }, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_error
      @error = Faulty::Error.find(params[:id])
    end
  end
end
