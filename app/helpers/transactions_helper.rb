
module TransactionsHelper
  def status_color(status)
    case status
    when "confirmed"
      "success"
    when "rejected"
      "danger"
    when "completed"
      "primary"
    when "requested"
      "warning"
    else
      "secondary"
    end
  end
end
