module Account
 class BankAccount
  attr_reader :account_number,:name, :balance
  @@account_number=100
  
  #To generate uniqie account number
  def initialize(name,initial_deposit)
    @name=name
    @balance=initial_deposit
    @account_number=@@account_number+=1
  end

  #Deposit money
  def deposit(amount)
    @balance +=amount
    puts "Deposit successful!
    New balance: #{balance}"
  end

  #Withdraw money
  def withdraw(amount)
    if amount> @balance
      puts "Insufficient fund! Current balance:#{balance}"
    else 
      @balance -=amount
      puts "Withdrawal Successful! Remaining balance:#{balance}"
    end
  end

  #check_balance
  def check_balance
    puts "Account number: #{@account_number} | Name: #{name} | Balance: #{balance}"
  end
 end
end