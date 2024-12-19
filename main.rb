require_relative 'operation'
require_relative 'employee_file'

include Bankoperation
#Start the Banking System

banking_system=BankingSystem.new
banking_system.run
