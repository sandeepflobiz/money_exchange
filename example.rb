class User
  attr_accessor :name,:email
  # attr_reader :name, :email
  # attr_writer :name, :email

  def initialize(attributes = {})
    @name  = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end
end

user = User.new
user.name = "sandeep"
user.email = "sandeep"
