class Quote < ApplicationRecord

	def initialize 
		
		@quote = QUOTES.sample
	
	end

	def print_quote

		if @quote.length < 140

			@quote

		end

	end

end