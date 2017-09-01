class Model
	def initialize(id, codex, name, gear)
		@id = id
		@statline = codex[name].getStats
		@gear = gear
	end
	
	def getID
		@id
	end
	
	def getGear()
		return @gear
	end
	### Return individual stats
	def getM 
		@stats['M']
	end
	def getWS
		@stats['WS']
	end
	def getBS 
		@stats['BS']
	end
	def getS 
		@stats['S']
	end
	def getT 
		@stats['T']
	end
	def getW 
		@stats['W']
	end
	def getA
		@stats['A']
	end
	def getLd 
		@stats['Ld']
	end
	def getSv 
		@stats['Sv']
	end
end