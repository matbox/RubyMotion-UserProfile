class UserController < UIViewController
  include BubbleWrap::KVO
  attr_accessor :user

  def initWithUser(user)
    initWithNibName(nil, bundle:nil)
    self.user = user
    self
  end

  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor

    last_label = nil
    User::PROPERTIES.each do |prop|
      label = UILabel.alloc.initWithFrame(CGRectZero)
      label.text = "#{prop.capitalize}:"

      label.sizeToFit
      if last_label
        label.frame = [
            [last_label.frame.origin.x,
            last_label.frame.origin.y + last_label.frame.size.height],
            label.frame.size]
      else
        label.frame = [[10,10], label.frame.size]
      end
      last_label = label

      self.view.addSubview(label)

      value = UILabel.alloc.initWithFrame(CGRectZero)
      value.text = self.user.send(prop)

        observe(self.user, prop) do |old_value, new_value|
          value.text = new_value
          value.sizeToFit
        end

      value.sizeToFit
      value.frame = [
          [label.frame.origin.x + label.frame.size.width + 10, label.frame.origin.y],
          value.frame.size]
      self.view.addSubview(value)
    end
    self.title = self.user.name
      observe(self.user, "name") do |old_value, new_value|
        self.title = new_value
      end
  end

  def viewDidUnload
    unobserve_all
    super
  end
end