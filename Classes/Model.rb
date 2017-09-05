class Model
	def initialize(id, codex, name, gear)
		@id = id
		@statline = codex[name].getStats
		@gear = gear
		@rules = codex[name].getRules
	end
	
	def getID
		@id
	end
	
	def getGear()
		return @gear
	end
	### Return individual stats
	def getM 
		@statline['M']
	end
	def getWS
		@statline['WS']
	end
	def getBS 
		@statline['BS']
	end
	def getS 
		@statline['S']
	end
	def getT 
		@statline['T']
	end
	def getW 
		@statline['W']
	end
	def getA
		@statline['A']
	end
	def getLd 
		@statline['Ld']
	end
	def getSv 
		@statline['Sv']
	end
	def hasRule(rule)
		if @rules.include? rule
			return TRUE
		else
			return FALSE
		end
	end
end