require 'yaml'
require_relative 'Classes\Unit2.rb'
require_relative 'Classes\CodexEntry.rb'
require_relative 'Classes\CodexTargets.rb'
require_relative 'Methods\LoadFromCsv.rb'
require_relative 'Methods\LoggedOverwatch.rb'
require 'time'
start_time = Time.now
logfile = File.open('Logs\Overwatch.txt', 'w')
out_file = File.open('DuelResults.csv', 'w')
space_marine_codex = YAML.load(File.read('Codices\SpaceMarineCodex.yml')) 
sm_wep = LoadWeapons('Codices\SMWeapons.csv')
imp_ind_1 = YAML.load(File.read('Codices\ImperialIndex1.yml')) 
imp_ind_wep = LoadWeapons('Codices\ImpInd1Weapons.csv')
hero_hash = Hash.new()

hero_hash['Marneus Calgar'] = Unit2.new()
hero_hash['Marneus Calgar'].addModels(space_marine_codex, sm_wep, 'Marneus Calgar', 1, [],[] )

hero_hash.each do |key, value|
	value.ApplyAuras
	value.getModels[0].ApplyGear
	out_file.print "#{key},"
end


range = 6
calgar = hero_hash['Marneus Calgar'].getModels[0]
wep = calgar.getRangedWeapons

FireOverwatch(calgar,calgar,range,logfile)