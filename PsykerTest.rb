require_relative 'Methods\LoggedDuelEngine.rb'
require_relative 'Methods\LoadFromCSV.rb'
require_relative 'Methods\LoggedPsykerMethods'
require_relative 'Classes\Targets.rb'
require 'yaml'
require_relative 'Classes\Unit.rb'
require_relative 'Classes\CodexEntry.rb'
require_relative 'Classes\CodexTargets.rb'
require 'time'
start_time = Time.now
log_file = File.open('shit.txt', 'w')
out_file = File.open('DuelResults.csv', 'w')
space_marine_codex = YAML.load(File.read('Codices\SpaceMarineCodex.yml')) 
sm_wep = LoadWeapons('Codices\SMWeapons.csv')
imp_ind_1 = YAML.load(File.read('Codices\ImperialIndex1.yml')) 
imp_ind_wep = LoadWeapons('Codices\ImpInd1Weapons.csv')
hero_hash = Hash.new()

hero_hash['Chief Librarian Tigerius'] = Unit2.new()
hero_hash['Chief Librarian Tigerius'].addModels(space_marine_codex, sm_wep, 'Chief Librarian Tigerius', 1, [],[] )
hero_hash['Chief Librarian Tigerius'].getModels[0].addGear(sm_wep,['Null Zone','Might of Heroes'])

tigur_perm = hero_hash['Chief Librarian Tigerius'].getModels[0]

hero_hash['Marneus Calgar'] = Unit2.new()
hero_hash['Marneus Calgar'].addModels(space_marine_codex, sm_wep, 'Marneus Calgar', 1, [],[] )
calgar = hero_hash['Marneus Calgar'].getModels[0]


tigur = hero_hash['Chief Librarian Tigerius'].getModels[0]

