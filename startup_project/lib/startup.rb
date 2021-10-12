require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
   def initialize(name, funding, salaries) #salaries => hash "title" => "salary"
       @name = name
       @funding = funding
       @salaries = salaries
       @employees = []
   end

   def valid_title?(title)
     @salaries.keys.include?(title)
   end

   def >(other_starup)
      self.funding > other_starup.funding
   end

   def hire(employee, title)
      if self.valid_title?(title)
        @employees << Employee.new(employee, title)
      else
        raise "should raise an error"
      end
   end

   def size
    @employees.length
   end

   def pay_employee(employee)
      money = @salaries[employee.title]
      if @funding >= money
        employee.pay(money)
        @funding -= money
      else
        raise "raise an error"
      end
   end

   def payday
     @employees.each { |employee| pay_employee(employee) }
   end

   def average_salary
    total = 0
     @employees.each { |empl| total += @salaries[empl.title] }
     total / (@employees.length / 1.0)
   end

   def close
     @employees = []
     @funding = 0
   end

   def acquire(other_starup)
     @funding += other_starup.funding
    #  puts @salaries
     other_starup.salaries.each  { |t, m| @salaries[t] = m if !@salaries.has_key?(t) }
     other_starup.employees.each { |emp| @employees << emp }
     other_starup.close
   end
end
