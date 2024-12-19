require_relative 'employee_file'
require_relative 'bank_account'
require_relative 'dummy_data'
require_relative 'transaction'

module Bankoperation
  include Employee
  include Account
  include TestModule
  include Transaction
  
  class BankingSystem
    def initialize
      @accounts= {}              #it holds the inistance of Banking System
      dummy_data(@accounts)      #populate the dummy data
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
        puts "7. Transfer Amount"
        puts "8. Exit"

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
            transfer_amount
        when 8
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
      print "Enter your Aadhar Number:"
      aadhar_number=gets.chomp
      if aadhar_number.match?(/^\d{12}$/)
      
       print "Enter Initial Depost Amount: "
       initial_deposit=gets.chomp.to_f

       if initial_deposit<0
        puts "Initial deposit cannot be negative."
       else
        account=BankAccount.new(name,initial_deposit,aadhar_number)
        @accounts[account.customer_id]=account
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
      end
        puts "-------List of All Customers--------"
        @accounts.each_value do |account|
          puts "Customer ID:#{account.customer_id}, Name:#{account.name},Balance:#{account.balance},AadharNo:#{account.aadhar_number}"
      end
    end
    
    #This will search a customer by their id only
    def serach_customer_by_id
      print "Enter the customer id you want to search:"
      customer_id=gets.chomp.to_i
      customer=@accounts[customer_id]
      if customer
        puts "--------Customer Details--------"
        puts "Name:#{customer.name}"
        puts "Customer Id:#{customer.customer_id}"
        puts "Account no.:#{customer.account_number}"
        puts "Aadhar no.:#{customer.aadhar_number}"
        puts "balance:#{customer.balance}"
      else
        puts "Customer with ID#{customer_id} not found:"      
      end
    end

    #Perform deposit
    def perform_deposit
      print "Enter Customer ID for Deposit: "
      customer_id=gets.chomp.to_i
      account=@accounts[customer_id]
      if account.nil?
        puts "Customer with ID #{customer_id} not found."
        return
      end
        print "Enter Deposit Amount: "
        amount=gets.chomp.to_f
        account.deposit(amount)
    end

    #Perform Withdrawal
    def perform_withdraw
      print "Enter Customer ID for Withdrawal:"
      customer_id=gets.chomp.to_i
      account=@accounts[customer_id]
      if account.nil?
        puts "Customer ID #{customer_id} not found. "
      end
      print "Enter withdrawal amount: " 
      amount=gets.chomp.to_f
      account.withdraw(amount)
    end

    #perform balance chceck
    def perform_check_balance
      print "Enter the Customer ID to check balance: "
      customer_id=gets.chomp.to_i
      account=@account[customer_id]
      if account.nil?
        puts "Account not found !"
      end
      account.check_balance
    end
  end
end