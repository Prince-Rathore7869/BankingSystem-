module Employee
 
 class Employee_Login
  EMPLOYEE_CREDENTIAL={username:"admin", password: "password"}

  def login
    puts "----------Employee Login-----------"
    print "Enter your username:"
    username=gets.chomp
    print "Enter your password:"
    password=gets.chomp

    if username== EMPLOYEE_CREDENTIAL[:username] && password== EMPLOYEE_CREDENTIAL[:password]
      puts "Login Successfull!
      Welcome Employee."
      true
    else
      puts "Credential invalid. Please try again"
      false
    end
  end
 end
end