class User
  PROPERTIES = [:id, :name, :email, :phone]
  PROPERTIES.each do |prop|
    attr_accessor prop
  end

  def initialize(properties = {})
    properties.each do |key, value|
      if PROPERTIES.member? key.to_sym
        self.send("#{key}=", value)
      end
    end
  end

end