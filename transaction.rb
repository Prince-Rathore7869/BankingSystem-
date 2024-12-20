require_relative 'operation'
require_relative 'validate_inputs'
require_relative 'bank_account'
module Transaction
  #include Bankoperation
  include Validate
  include Account
  
  def transfer_amount
    sender_id=get_validated_id("Enter sender's Customer ID: ")
    recevier_id=get_validated_id("Enter receiver's Customer ID: ")
    amount=get_validated_amount("Enter amount to be Transfer: ")
    if amount<0
      puts "Enter the Positive Number!"
    else
    #Find the sender and receiver accounts in the @accounts
    sender=@accounts[sender_id]
    recevier=@accounts[recevier_id]
    if sender.nil?
      puts "Sender with Customer id #{sender_id} not found."
      #return
    end
    if recevier.nil?
      puts "Receiver with Customer ID #{recevier_id} not found."
      #return
    end
     if sender.balance< amount
      sender.transaction << {type:"Insufficient Balance", amount: amount,balance: sender.balance}
      puts "Insufficient Fund in Sender's Account."
     else
     #Perform the transfer 
     sender.balance -=amount
     recevier.balance +=amount
      #update sender's transaction history
     sender.transaction << {type:"Transfer Sent", amount: amount,balance: sender.balance}
     #update receiver's transaction history
     recevier.transaction << {type:"Transfer recevied",amount: amount,balance: recevier.balance}
     puts "Transaction Successful!"
     puts "Sender's New Balance: #{sender.balance}"
     puts "Receiver's New Balance: #{recevier.balance}"
     end
    end
  end

  def show_transaction_history(account)
    account.display_transaction
  end
end