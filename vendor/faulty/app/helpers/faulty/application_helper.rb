module Faulty
  module ApplicationHelper
    def faulty_pagination(current_page, per_page, total_count, path_helper)
      total_pages = (total_count / per_page.to_f).ceil
      return if total_pages <= 1

      content_tag(:div, class: "faulty-pagination") do
        (1..total_pages).map do |page|
          link_to page,
                  path_helper.call(page: page),
                  class: "page-link #{'active' if page == current_page}"
        end.join(" ").html_safe
      end
    end

    def event_time_range(error)
      first_seen = error.events.minimum(:created_at)
      last_seen  = error.events.maximum(:created_at)
      diff = (last_seen - first_seen).abs

      if diff < 1.hour
        "#{time_ago_in_words(last_seen)} ago"
      else
        "#{time_ago_in_words(first_seen)} ago - #{time_ago_in_words(last_seen)} ago"
      end
    end
  end
end
