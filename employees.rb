class Employee
  attr_reader :name, :title, :salary, :boss
  
  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
    @boss = nil
  end
  
  def bonus(multiplier)
    @salary * multiplier
  end

  def set_boss(boss)
    @boss = boss
  end

  def inspect
    print "#{@name}"
  end
end

class Manager < Employee
  attr_reader :employees
  def initialize(name, title, salary, employees=[])
    super(name, title, salary)
    @employees = employees
  end

  def bonus(multiplier)
    total_salary = 0
    @employees.each do |employee|
      total_salary += employee.salary
    end
    total_salary * multiplier
  end

  def add_employee(employee)
    employee.set_boss(self)
    @employees << employee
    if employee.is_a?(Manager)
      @employees += employee.employees
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  david = Employee.new("David", "TA", 10000)
  shawna = Employee.new("Shawna", "TA", 12000)
  darren = Manager.new("Darren", "TA Manager", 78000)
  ned = Manager.new("Ned", "Founder", 1000000)
  darren.add_employee(david)
  darren.add_employee(shawna)
  ned.add_employee(darren)
  puts ned.bonus(5)
  puts darren.bonus(4)
  puts david.bonus(3)
end