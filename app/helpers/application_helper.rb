module ApplicationHelper
  def toggle_direction(column)
    if params[:column] == column.to_s && params[:direction] == 'asc'
      'desc'
    else
      'asc'
    end
  end
end