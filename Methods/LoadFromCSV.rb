require 'csv'
require_relative '..\Classes\Weapon.rb'

def LoadTargets(target_file)
	csv = CSV.read(target_file, headers: true)
	
	target_hash = Hash.new
	
	csv.each do |row|
		name = row['Name']
		stats = Array.new
		(1..8).each do |n|
			if row[n]
				stats.push(row[n])
			end
		end
		target_hash[name] = Target.new(name, stats)
		
	end
	
	return target_hash

end

def LoadWeapons(target_file)
	csv = CSV.read(target_file, headers: true)
	
	weapon_hash = Hash.new
	stats = Array.new
	rules = Array.new
	
	csv.each do |row|
		rules = ['']
		name = row['Weapon'] 
		firetype = row['Firetype']
		stats = row[2..8]
		(9..12).each do |n|
			if row[n]
				rules.push(row[n])
			end
		end
		
		if weapon_hash[name]
			weapon_hash[name].addProfile(firetype, stats, rules)
		else
			weapon_hash[name] = Weapon.new(name)
			weapon_hash[name].addProfile(firetype, stats, rules)
		end
	end
	
	return weapon_hash
end
			