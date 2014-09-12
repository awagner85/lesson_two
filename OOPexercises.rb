=begin
1. How do we create an object in Ruby? Give an example of the creation of an object.

class SciFiCreature
end

r2d2 = SciFiCreature.new


2. What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

A module is a mixin, it is used when different classes have a similar attribute. Uses keyword 'include' to be added to the class.

module Android
  def android(noise)
    puts "Beep bop boop"
  end
end

class SciFiCreature
  include Android
end

r2d2 = SciFiCreature.new
r2d2.android

===========================================
Class and Objects Part One Exercises
===========================================
1. Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.


module Muddable
  def mud
  puts "I can drive through the mud!"
  end
end

class Vehicle

  attr_accessor :color
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def initialize(year,color,model)
    @@number_of_vehicles += 1
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def self.gas_mileage(miles,gallons)
    puts miles / gallons
  end

  def self.number_of_vehicles
    puts "There are currently #{@@number_of_vehicles} vehicles."
  end

  def initialize
    @@number_of_vehicles += 1
  end

  def gas_pedal(speed_amount)
    self.current_speed = @current_speed + speed_amount
    #@current_speed += speed_amount
    puts "We are now going #{current_speed}mph."
  end

  def brake_pedal(lower_speed)
    self.current_speed = @current_speed - lower_speed
    #@current_speed -= lower_speed
    puts "We are now going #{current_speed}mph."
  end

  def shut_off
    self.current_speed = 0
    #@current_speed = 0
    puts "Put that bad boy in park, we're going #{current_speed}."
  end

  def spray_paint(color)
    self.color = color
    puts "Now your #{model} is #{color}."
  end

  private

  def age
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  attr_accessor :color, :model, :current_speed, :miles, :gallons
  attr_reader :year

  def initialize(year,color,model)
    @@number_of_vehicles += 1
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def self.gas_mileage(miles,gallons)
    puts miles / gallons
  end

  def gas_pedal(speed_amount)
    self.current_speed = @current_speed + speed_amount
    #@current_speed += speed_amount
    puts "We are now going #{current_speed}mph."
  end

  def brake_pedal(lower_speed)
    self.current_speed = @current_speed - lower_speed
    #@current_speed -= lower_speed
    puts "We are now going #{current_speed}mph."
  end

  def shut_off
    self.current_speed = 0
    #@current_speed = 0
    puts "Put that bad boy in park, we're going #{current_speed}."
  end

  def spray_paint(color)
    self.color = color
    puts "Now your #{model} is #{color}."
  end

  def HAS_TRUNK
    puts "This vehicle has a trunk."
  end

  def to_s
    "This vehicle is a #{year} #{color} #{model}."
  end
end

class MyTruck < Vehicle
  attr_accessor :color, :current_speed, :miles, :gallons
  attr_reader :year, :model

  include Muddable

  def initialize(year,color,model)
    @@number_of_vehicles += 1
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def self.gas_mileage(miles,gallons)
    puts miles / gallons
  end

  def gas_pedal(speed_amount)
    self.current_speed = @current_speed + speed_amount
    #@current_speed += speed_amount
    puts "We are now going #{current_speed}mph."
  end

  def brake_pedal(lower_speed)
    self.current_speed = @current_speed - lower_speed
    #@current_speed -= lower_speed
    puts "We are now going #{current_speed}mph."
  end

  def shut_off
    self.current_speed = 0
    #@current_speed = 0
    puts "Put that bad boy in park, we're going #{current_speed}."
  end

  def spray_paint(color)
    self.color = color
    puts "Now your #{model} is #{color}."
  end

  def CAN_TOW
    puts "This vehicle can tow."
  end

  def to_s
    "This vehicle is a #{year} #{color} #{model}."
  end
end

Subaru = MyCar.new(2007, "silver", "Outback")
puts Subaru
Subaru.gas_pedal(30)
Subaru.brake_pedal(10)
Subaru.shut_off
Subaru.spray_paint("blue")
puts Subaru
MyCar.gas_mileage(100, 11)

puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors

=end

class Student
  attr_reader :name, :grade

  def initialize(name,grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(classmate)
    grade > classmate.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new("joe", 95)
bob = Student.new("bob", 80)


puts "Well done!" if joe.better_grade_than?(bob)
puts joe.grade