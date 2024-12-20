module Validate
  def get_validated_id(prompt)
    loop do
      print prompt                        #from google
      input=gets.chomp
      return input.to_i if input.match?(/^\d+$/)
      puts "Invalid Input.Customer ID must be Integer."
    end
  end

  def get_validated_amount(prompt)
    loop do
      print prompt
      input=gets.chomp
      return input.to_f if input.match?(/^\d+(\.\d{1,2})?$/)     #from Google
      puts "Invalid input.Amount must be Positive number."
    end
  end
end