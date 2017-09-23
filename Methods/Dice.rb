

def CalcDiceAvg(value)
	if value.to_f >= -10 && value.to_i <= 10  
		return value
	elsif value == 'D3'
		return 2
	elsif value == 'D6'
		return 3.5
	elsif value == '2D6'
		return 7
	elsif value == '2D3'
		return 4
	elsif value =='-D3'
		return -2
	elsif value =='3D6'
		return 10.5
	elsif value == '3D3'
		return 6
	elsif value == '4D6'
		return 14
	elsif value == '4D3'
		return 8
	elsif value == '6+D3'
		return 8
	else
		puts "No CalcDice Value for #{value}"
		abort
	end
end
	
def RollDice(value)
	if value.to_f >= -10 && value.to_i <= 10  
		return value
	elsif value == 'D3'
		return srand(1..3)
	elsif value == 'D6'
		return srand(1..6)
	elsif value == '2D6'
		dice1 = srand(1..6)
		dice2 = srand(1..6)
		return dice1 + dice2
	elsif value == '2D3'
		dice1 = srand(1..3)
		dice2 = srand(1..3)
		return dice1 + dice2
	elsif value == '-D3'
		dice = srand(1..3) * -1
		return dice
	elsif value == '3D6'
		dice1 = srand(1..6)
		dice2 = srand(1..6)
		dice3 = srand(1..6)
		return dice1 + dice2 + dice3
	elsif value == '3D3'
		dice1 = srand(1..3)
		dice2 = srand(1..3)
		dice3 = srand(1..3)
		return dice1 + dice2 + dice3
	elsif value == '4D6'
		dice1 = srand(1..6)
		dice2 = srand(1..6)
		dice3 = srand(1..6)
		dice4 = srand(1..6)
		return dice1 + dice2 + dice3 + dice4
	elsif value == '4D3'
		dice1 = srand(1..3)
		dice2 = srand(1..3)
		dice3 = srand(1..3)
		dice4 = srand(1..3)
		return dice1 + dice2 + dice3 + dice4
	elsif value == '6+D3'
		return 6 + srand(1..3)
	else
		puts "No RollDice Value for #{value}"
		abort
	end
end
	