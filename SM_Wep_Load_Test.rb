require_relative 'Methods\LoadFromCSV'
require_relative 'Methods\ShootingAtTarget'
require_relative 'Classes\Targets.rb'
require 'yaml'
require_relative 'Classes\Unit.rb'
require_relative 'Classes\CodexEntry.rb'

space_marine_codex = YAML.load(File.read('F:\Mathammer\Codices\SpaceMarineCodex.yml'))

target_file = 'F:\Mathammer\SMWeapons.csv'

csv = CSV.read(target_file, headers: true)




weapon_hash = Hash.new
stats = Array.new
rules = Array.new

csv.each do |row|
		rules = Array.new
		name = row['Weapon'] 
		firetype = row['Firetype']
		stats = row[2..8]
		puts name
		puts firetype
		puts row
		
		(9..12).each do |n|
			if row[n]
				rules.push(row[n])
			end
		end
		
		if weapon_hash[name]
			weapon_hash[name].addFireType(firetype, stats, rules)
		else
			weapon_hash[name] = Weapon.new(name)
			weapon_hash[name].addFireType(firetype, stats, rules)
		end
end
