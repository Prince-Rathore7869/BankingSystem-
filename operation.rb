require_relative 'employee_file'
require_relative 'bank_account'

module Bank_operation
  include Employee
  include Account

  DATA_FILE= './accounts_data.dat'

  class Banking_System
    def initialize
      @accounts=load_accounts
    end
    def run
      employee=Employee_Login.new
      until employee.login
      end

      loop do 
        puts "\n------Banking Sysem Menu-----"
        puts "1. Register Customer"
        puts "2. Deposit"
        puts "3. Withdraw"
        puts "4. Check balance"
        puts "5. Exit"

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
          puts "Exiting the banking System.Goodbye"
          break 
        else
          puts "Invalid option.Please try again."
        end
      end
    end
    
    private
    #Load accounts from the binary file
    def load_accounts
      if File.exist?(DATA_FILE)
        begin
        File.open(DATA_FILE,'rb') do |file|
        Marshal.load(file) || []
        end
        rescue => e
        puts "failed to load account data: #{e.message}"
         []
        end
      else
        []
      end
      
    end

    #Save accounts to the binary file
    def save_accounts
      
      File.open(DATA_FILE,'wb') do |file|
       Marshal.dump(@accounts,file)
      end
    end

    #Register anew Customer
    def register_customer
      print "Enter Customer Name: "
      name=gets.chomp
      print "Enter Initial Depost Amount: "
      initial_deposit=gets.chomp.to_f

      if initial_deposit<0
        puts "Initial deposit cannot be negative."
      else
        account=Bank_Account.new(name,initial_deposit)
        @accounts<<account
        puts "Customer registered successfully!
        Account Number:#{account.account_number}"
        save_accounts
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
          save_accounts
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
          save_accounts
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