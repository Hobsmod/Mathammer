# Hey, was having trouble sleeping so I figured I'd go ahead and make some suggestions.

class Model
	# attr_accessor creates getters and setters for you.  Give it a list of symbols
	# and it does the rest.  For example :id will create @id instance variable, define
	# a method called id and another called id= which are the getter and setter respectively
	# the setter is especially cool because ruby syntax allows it to be called like
	# model.id = 2, which calls the method id= despite the space.
	# there is also attr_reader if you only want to create the getters
	attr_accessor :id, :statline, :gear, :rules, :name, :keywords

	# I believe it's still possible to directly set the instance variables defined with
	# attr_accessor, but it's more typical to use the methods you just made
	def initialize(id, codex, name, gear)
		self.id = id
		self.statline = codex[name].getStats
		self.gear = gear
		self.rules = codex[name].getRules
		self.name = name
		self.keywords = codex[name].getKeywords
		# the self is usually optional within class methods, but it's common to have args
		# with the same name and the self keeps the compiler from getting confused
	end

	# def getID
	# 	@id
	# end
	#
	# def getName
	# 	@name
	# end
	#
	# def getGear()
	# 	return @gear
	# end
	# handled by attr_accessor

	### Return individual stats
	# I recommend just doing model.statline['M'], model.statline['WS'], etc.
	# the generated getter can return the hash np :)
	# def getM
	# 	@statline['M']
	# end
	# def getWS
	# 	@statline['WS']
	# end
	# def getBS
	# 	@statline['BS']
	# end
	# def getS
	# 	@statline['S']
	# end
	# def getT
	# 	@statline['T']
	# end
	# def getW
	# 	@statline['W']
	# end
	# def getA
	# 	@statline['A']
	# end
	# def getLd
	# 	@statline['Ld']
	# end
	# def getSv
	# 	@statline['Sv']
	# end

	# It's idiomatic to end boolean methods with '?' just like the include? method
	# It's a nice hint about the return value
	def hasRule?(rule)
		# Everything in Ruby has a return value, so you can make this a single line
		# by just letting this statement be your function return value.  rules will
		# resolve to self.rules aka the getter method from attr_accessor
		rules.include? rule
	end

	# It's idiomatic to omit the parens when there are no parameters for the function
	def getInvuln
		# The if statement actually returns a value so you can use it like this
		if rules.include? 'Invulnerable-3'
			3
		elsif rules.include? 'Invulnerable-4'
			4
		elsif rules.include? 'Invulnerable-5'
			5
		elsif rules.include? 'Invulnerable-6'
			6
		else
			7
		end
		# You usually only do the return keyword in Ruby if you want to exit the function early
		# I like to avoid conditionals whenever possible, so I would probably make rules
		# a hash and return rules[:invulnerable]
	end

	def getFNP
		# here's kind of a fancy syntax to replace the unless functionality
		# it returns fnp if it isn't nil, otherwise it performs the assignment, returning
		# the assigned value
		#
		# select is a function on the enumerable class similar to each.  It creates an array
		# of all the things in the collection that match the condition.  Prefer the more specific
		# enumerable methods to each, as it makes your code more declarative.  Enumerable methods
		# are one of my favorite things in the language :)  The curly brackets are the exact same
		# as using do |rule| ... end but it is idiomatic to use curly brackets when you only care
		# about the return value of the enumerable method.
		fnp ||= rules.select{ |rule| rule =~ /FNP/ }
		# unless @fnp
		# 	@fnp = Array.new
		# 	rules.each do |rule|
		# 		if rule =~ /FNP/
		# 			@FNP.push(rule[-1].to_f)
		# 		end
		# 	end
		# end
		# return @fnp
	end

# Boolean method :)
	def hasKeyword?(keyword)
		keywords.include? keyword
	end

	def addRule(rule)
		# Ruby is a bit weird in that it often has several ways to do the same thing
		# .push is perfectly fine, but I more often see the shovel operator '<<'
		# it does the same thing: rules << rule
		# the parens are optional for function calls (except when they aren't because
		# of ambiguity, heh, but that's rare)

		rules.push rule
	end
end
