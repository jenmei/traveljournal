module HotelsHelper
  def day_today()
    Date.today.strftime("%A")
  end
end

