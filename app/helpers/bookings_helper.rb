module BookingsHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (params[:sort] == column && params[:direction] == "asc") ? "desc" : "asc"
    arrow = params[:sort] == column ? (params[:direction] == "asc" ? "↑" : "↓") : ""
    link_to "#{title} #{arrow}".html_safe, bookings_path(sort: column, direction: direction), class: "hover:underline text-purple-700 font-semibold"
  end
end
