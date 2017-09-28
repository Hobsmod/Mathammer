class Model
	def initialize(id, codex, name, gear)
		@id = id
		@statline = codex[name].getStats
		@gear = gear
		@rules = codex[name].getRules
		@name = name
		@keywords = codex[name].getKeywords
	end
	
	def getID
		@id
	end
	
	def getName
		@name
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
			return true
		else
			return false
		end
	end
	def getInvuln()
		if @rules.include? 'Invulnerable - 3'
			return 3
		elsif @rules.include? 'Invulnerable - 4'
			return 4
		elsif @rules.include? 'Invulnerable - 5'
			return 5 
		elsif @rules.include? 'Invulnerable - 6'
			return 6
		else
			return 7
		end
	end
	def getFNP()
		unless @fnp
			@fnp = Array.new
			rules.each do |rule|
				if rule =~ /FNP/
					@FNP.push(rule[-1].to_f)
				end
			end
		end
		return @fnp
	end
			
	def hasKeyword(keyword)
		if @keywords.include? keyword
			return true
		else
			return false
		end
	end
	def addRule(rule)
		@rules.push(rule)
	end
end