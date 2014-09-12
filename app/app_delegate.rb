class AppDelegate
  def applicationDidFinishLaunching(notification)
    return true if RUBYMOTION_ENV == 'test'
  end
end
