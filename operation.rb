require_relative 'employee_file'
require_relative 'bank_account'

module Bank_operation
  include Employee
  include Account
  
  class BankingSystem
    def initialize
      @accounts=[]
    end
    def run
      employee=EmployeeLogin.new
      until employee.login
      end

      loop do 
        puts "\n------Banking System Menu-----"
        puts "1. Register Customer"
        puts "2. Deposit"
        puts "3. Withdraw"
        puts "4. Check balance"
        puts "5. Search a Customer"
        puts "6. List All Customer"
        puts "7. Exit"

        print "Choose an option: "
        choice=gets.chomp.to_i

        case choice
        when 1 
          register_customer
        when 2
          perform_deposit
        when 3
          perform_withdraw
        when 4
          perform_check_balance
        when 5
           serach_customer_by_id
        when 6
           list_all_customers
        when 7
          puts "Exiting the banking System.Goodbye"
          break 
        else
          puts "Invalid option.Please try again."
        end
      end
    end
    
    #Register anew Customer
    def register_customer
      print "Enter Customer Name: "
      name=gets.chomp
      print "Enter your Aadhar Number"
      aadhar_number=gets.chomp
      if aadhar_number.match?(/^\d{12}$/)
      
       print "Enter Initial Depost Amount: "
       initial_deposit=gets.chomp.to_f

       if initial_deposit<0
        puts "Initial deposit cannot be negative."
       else
        account=BankAccount.new(name,initial_deposit,aadhar_number)
        @accounts<<account
        puts "Customer registered successfully!"
        puts "Customer Id:#{account.customer_id}, Account Number:#{account.account_number}"
       end 
      else
        puts "Invalid Aadhar number. It have to be exactly 12 digits."
      end
    end

    #This will list all the customer
    def list_all_customers
      if @accounts.empty?
        puts "No customers registered yet. Please add some customers."
      
      else
        puts "-------List of All Customers--------"
        @accounts.each do |account|
          puts "Name:#{account.name}"
          puts "Customer ID:#{account.customer_id}"
          puts "Account Number:#{account.account_number}"
          puts "Aadhar No.:#{account.aadhar_number}"
          puts "balance:#{account.balance}"
        end
      end
    end
    
    #This will search a customer by their id only
    def serach_customer_by_id
      print "Enter the customer id you want to search:"
      customer_id=gets.chomp.to_i
      account=@accounts.find {|acc| acc.customer_id== customer_id}
      if account
        puts "--------Customer Details--------"
        puts "Name:#{account.name}"
        puts "Customer Id:#{account.customer_id}"
        puts "Account no.:#{account.account_number}"
        puts "Aadhar no.:#{account.aadhar_number}"
        puts "balance:#{account.balance}"
      else
        puts "Customer with ID#{customer_id} not found"      
      end
    end

    #Find an account by account number
    def find_account
      print "Enter Account Number: "
      account_number=gets.chomp.to_i
      @accounts.find {|acc| acc.account_number==account_number }
    end

    #Perform deposit
    def perform_deposit
      account=find_account
      if account
        print "Enter Deposit Amount: "
        amount=gets.chomp.to_f
        if amount<=0
          puts 'Deposit amount must be greater than 0.'
        else
          account.deposit(amount)
          
        end
      else
        puts "account not found!"
      end
    end

    #Perform Withdrawal
    def perform_withdraw
      account= find_account
      if account
        print "Enter the Withdrawal Amount: "
        amount =gets.chomp.to_f
        if amount<= 0
          puts "Withdrawal amount must be greater than 0"
        else
          account.withdraw(amount)
        end
      else
        puts "Account not found!"
      end
    end

    #perform balance chceck
    def perform_check_balance
      account= find_account
      if account
        account.check_balance
      else
        puts "Account not found !"
      end
    end
  end
end