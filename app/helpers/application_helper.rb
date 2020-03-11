module ApplicationHelper
  #日本時間
  def ja_time(time)
    time.strftime("%Y-%m-%d %H:%M:%S")
  end
end
