class ModelWithWeapons
	def initialize(id, codex, gear_hash, name, gear)
		@id = id
		@statline = codex[name].getStats
		@rules = codex[name].getRules
		@name = name
		@keywords = codex[name].getKeywords
		### Add Weapon Objects to Model
		@gear = Array.new()
		gear.each do |item|
			@gear.push(gear_hash[item])
		end
	end
	
	def getID
		@id
	end
	
	def getName
		@name
	end
	def getRules
		@rules
	end
	
	def ApplyFactionKeywords(faction, keyword)
		@keywords.delete(keyword)
		@keywords.push(faction)
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
	def addS(n)
		@statline['S'] = @statline['S'] + n
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
	
	def addA(n)
		@statline['A'] = @statline['A'] + n
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
		if @rules.include? 'Invulnerable-3'
			return 3
		elsif @rules.include? 'Invulnerable-4'
			return 4
		elsif @rules.include? 'Invulnerable-5'
			return 5 
		elsif @rules.include? 'Invulnerable-6'
			return 6
		else
			return 7
		end
	end
	def getFNP()
		unless @fnp
			@fnp = Array.new
			@rules.each do |rule|
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