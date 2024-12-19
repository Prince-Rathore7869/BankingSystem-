require_relative 'operation'
module Transaction
  #include Bankoperation
  
  def transfer_amount
    print "Enter Sender Customer ID:"
    sender_id=gets.chomp.to_i
    print "Enter Receiver Customer ID:"
    recevier_id=gets.chomp.to_i
    print "Enter the Amount to transfer:"
    amount=gets.chomp.to_f

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
       puts "Insufficient Fund in Sender's Account."
     end

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

  def show_transaction_history(account)
    account.display_transaction
  end
end