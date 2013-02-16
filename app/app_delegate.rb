class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @user = User.load
    @user ||= User.new(
        id: "123",
        name: "Matthias",
        email: "matthias@example.com",
        phone: "(123)-345-567"
    )
    @user_controller = UserController.alloc.initWithUser(@user)

    @nav_controller = UINavigationController.alloc.initWithRootViewController(@user_controller)

    @window.rootViewController = @nav_controller
    @window.makeKeyAndVisible

    true
  end

  def applicationDidEnterBackground(application)
    @user.save
  end
end
