module SettingsHelper
  def ldate(dt, hash = {})
    dt ? l(dt, hash) : ""
  end
end
