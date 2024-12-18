module Account
 class BankAccount
  attr_accessor :account_number,:name, :balance, :customer_id, :aadhar_number
  @@account_number=100
  @@customer_id=0
  
  #To generate uniqie account number
  def initialize(name,initial_deposit,aadhar_number)
    @name=name
    @balance=initial_deposit
    @aadhar_number=aadhar_number
    @account_number=@@account_number+=1
    @customer_id=@@customer_id+=1
  end
 
  #this function will convert the object to hash
  def to_hash
    {
      name: @name,
      balance: @balance,
      aadhar_number: @aadhar_number,
      customer_id: @customer_id,
      account_number: @account_number
    }
  end

  #This is will create the new object from hash
  def self.new_from_hash(hash)
    account=new(hash[:name],hash[:balance],hash[:aadhar_number])
    account.account_number=hash[:account_number]
    account.customer_id=hash[:customer_id]
    account
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