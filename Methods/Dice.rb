

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
	if value == 'D3'
		return rand(1..3).to_i
		puts "Matches D3"
	elsif value == 'D6'
		return rand(1..6).to_i
	elsif value == '2D6'
		dice1 = rand(1..6).to_i
		dice2 = rand(1..6).to_i
		return dice1 + dice2
	elsif value == '2D3'
		dice1 = rand(1..3).to_i
		dice2 = rand(1..3).to_i
		return dice1 + dice2
	elsif value == '-D3'
		dice = rand(1..3).to_i * -1
		return dice
	elsif value == '3D6'
		dice1 = rand(1..6).to_i
		dice2 = rand(1..6).to_i
		dice3 = rand(1..6).to_i
		return dice1 + dice2 + dice3
	elsif value == '3D3'
		dice1 = rand(1..3).to_i
		dice2 = rand(1..3).to_i
		dice3 = rand(1..3).to_i
		return dice1 + dice2 + dice3
	elsif value == '4D6'
		dice1 = rand(1..6).to_i
		dice2 = rand(1..6).to_i
		dice3 = rand(1..6).to_i
		dice4 = rand(1..6).to_i
		return dice1 + dice2 + dice3 + dice4
	elsif value == '4D3'
		dice1 = rand(1..3).to_i
		dice2 = rand(1..3).to_i
		dice3 = rand(1..3).to_i
		dice4 = rand(1..3).to_i
		return dice1 + dice2 + dice3 + dice4
	elsif value == '6+D3'
		return 6 + rand(1..3).to_i
	else
		return value.to_i
	end
end

def RerollAll(rolls, to_suceed)
	rolls = rolls.map! { |r| r < to_suceed ? rand(1..6) : r}
end

def RerollOnes(rolls)
	rolls = rolls.map! { |r| r == 1 ? rand(1..6) : r}
end
	