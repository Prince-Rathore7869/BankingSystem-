require_relative 'operation'

module TestModule
  #include Bankoperation

  #In this dummy data only we have to give the name,balance,aadhar no. because we are creating
  #the data in hash and in the dummy info have the valid customer id values
  def dummy_data(accounts)
    dummy_info=[{name:"Prince Singh Rathore", balance: 1000, aadhar_number:"123456789789"},
    {name: "Ayush Gupta",balance: 2000, aadhar_number:"987654321321"},
    {name:"Shivam mahajan",balance: 500, aadhar_number: "456789123456"},
    {name: "Vivek Sony",balance: 500, aadhar_number: "123123456789"}
  ]

  dummy_info.each do |data|
    account=BankAccount.new(data[:name],data[:balance],data[:aadhar_number])
    accounts[account.customer_id]=account       #Add to the hash
   end
  end
end