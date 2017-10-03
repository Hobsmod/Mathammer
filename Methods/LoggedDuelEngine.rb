require_relative 'Logged Melee Methods.rb'
require_relative 'LoggedShootingMethods.rb'
require_relative '../Classes/Weapon2.rb'
require_relative 'LoggedOverwatch.rb'
require_relative 'Dice.rb'

def Duel(wep_hash,charger,defender,iterations,logfile)
###each of these is a unit

	range = 6
	charger = charger.getModels[0]
	defender = defender.getModels[0]
	charger.ClearGameModifiers
	defender.ClearGameModifiers
	
	logfile.puts "----------------#{charger.getName} Charges #{defender.getName}--------------------------"
	## get all stats
	
	atk_arry = OptMeleeWeapon(charger,defender,logfile)
	atk_wep = atk_arry[0]
	atk_mode= atk_arry[1]
	atk_pistol_hash = OptimizePistolsCC(charger,defender,logfile)
	atk_wounds = charger.getW()
	
	def_arry = OptMeleeWeapon(defender,charger,logfile)
	def_ovwtch_wep = OptOvwWepProfiles(charger,defender,range,logfile)
	def_wep = def_arry[0]
	def_mode = def_arry[1]
	def_pistol_hash = OptimizePistolsCC(defender,charger,logfile)
	def_wounds = defender.getW

	
	defender_victories = 0
	attacker_victories = 0

	(1..iterations).each do |iter|
		charger.ClearGameModifiers
		defender.ClearGameModifiers
		dmg_to_charger = 0
		dmg_to_defender = 0
		rounds = 10
		

		logfile.puts "--------------Beginning Duel Number #{iter} of #{iterations} -----------------------"
		
		
		
		
		charger.ClearRoundModifiers
		#### Use Psyker Powers
		if charger.getPowers.size >= 1
			logfile.puts "#{charger.getName} can now use their psychic powers"
			cast_results = CastPowersWithDenier(charger,defender,range,logfile)
			dmg_to_defender = dmg_to_defender + cast_results[0]
			dmg_to_charger = dmg_to_charger + cast_results[1]
			if cast_results[0] > 0
				logfile.puts "#{defender.getName} took #{cast_results[0]} damage from psychic powers and has #{atk_wounds - dmg_to_charger} wounds left"
			end
			if cast_results[1] > 0
				logfile.puts "#{charger.getName} took #{cast_results[1]} damage from perils and has #{def_wounds - dmg_to_defender} wounds left"
			end
		end
					
		#### Check if anyone has won
		if dmg_to_charger >= atk_wounds && dmg_to_defender < def_wounds
			logfile.puts "The defender, #{defender.getName} won!"
			defender_victories = defender_victories + 1.0
			break
		end
		if dmg_to_defender >= def_wounds && dmg_to_charger < atk_wounds
			logfile.puts "The charger, #{charger.getName} won!"
			attacker_victories = attacker_victories + 1.0
			break
		end
		if dmg_to_defender >= def_wounds && dmg_to_charger >= atk_wounds
			logfile.puts "Both Characters were killed, this is counted as a half - victory"
			defender_victories = defender_victories + 0.5
			attacker_victories = attacker_victories + 0.5
			break
		end
	
		## Roll Overwatch!###
		logfile.puts "-------------------- Firing Overwatch at range of #{range} inches! ---------------------------------------"
		ovw_dmg = 0
		self_ovw_dmg = 0
		def_ovwtch_wep.each do |wep, profile_s|	
			if profile_s.is_a?(Array)
				profile_s.each do |profile|
					prof_dmg = FireOverwatch(charger,defender,wep,profile,range,logfile)
					ovw_dmg = ovw_dmg + prof_dmg[0]
					self_ovw_dmg = self_ovw_dmg + prof_dmg[1]
				end	
			else 
				prof_dmg = FireOverwatch(charger,defender,wep,profile_s,range,logfile)
				ovw_dmg = ovw_dmg + prof_dmg[0]
				self_ovw_dmg = self_ovw_dmg + prof_dmg[1]
				
			end
		end
		
		logfile.puts "Total OVW damage to charger: #{ovw_dmg}, total OVW damage to self #{self_ovw_dmg}"
		dmg_to_charger = dmg_to_charger + ovw_dmg
		dmg_to_defender = dmg_to_defender + self_ovw_dmg
		logfile.puts "#{charger.getName} took a total of #{ovw_dmg} from overwatch fire leaving them with #{atk_wounds - dmg_to_charger} wounds"

		
		#### Chech if Overwatch fire was enough to kill the charger
		#### Check if anyone has won
		if dmg_to_charger >= atk_wounds && dmg_to_defender < def_wounds
			logfile.puts "The defender, #{defender.getName} won!"
			attacker_victories = attacker_victories + 1.0
			next
		end
		if dmg_to_defender >= def_wounds && dmg_to_charger < atk_wounds
			logfile.puts "The charger, #{charger.getName} won!"
			defender_victories = defender_victories + 1.0
			next
		end
		if dmg_to_defender >= def_wounds && dmg_to_charger >= atk_wounds
			logfile.puts "Both Characters were killed, this is counted as a half - victory"
			defender_victories = defender_victories + 0.5
			attacker_victories = attacker_victories + 0.5
			next
		end
		
		
		(1..rounds).each do |round|
			logfile.puts " ----------------- Begin Round #{round}! -----------------------------"
			
			### Odd Rounds are the Chargers Turn
			if round.odd? 
				#### Healing - Charger can heal every odd round but the first
				if charger.hasRule('Healing - D3') == true && round > 1
					healed = RollDice('D3')
					dmg_to_charger = dmg_to_charger - healed
					if dmg_to_charger < 0
						dmg_to_charger = 0
					end
					logfile.puts "#{charger.getName} heals #{healed} wounds leaving then with #{atk_wounds - dmg_to_charger} wounds"
				end
				
				if round > 1
					charger.ClearRoundModifiers
				end
				
				#### Use Psyker Powers
				if charger.getPowers.size >= 1 && round > 1
					logfile.puts "#{charger.getName} can now use their psychic powers"
					cast_results = CastPowersWithDenier(charger,defender,range,logfile)
					dmg_to_defender = dmg_to_defender + cast_results[0]
					dmg_to_charger= dmg_to_charger + cast_results[1]
					if cast_results[0] > 0
						logfile.puts "#{defender.getName} took #{cast_results[0]} damage from psychic powers and has #{atk_wounds - dmg_to_charger} wounds left"
					end
					if cast_results[1] > 0
						logfile.puts "#{charger.getName} took #{cast_results[1]} damage from perils and has #{def_wounds - dmg_to_defender} wounds left"
					end
					#### Check if anyone has won
					if dmg_to_charger >= atk_wounds && dmg_to_defender < def_wounds
						logfile.puts "The defender, #{defender.getName} won!"
						defender_victories = defender_victories + 1.0
						break
					end
					if dmg_to_defender >= def_wounds && dmg_to_charger < atk_wounds
						logfile.puts "The charger, #{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
					if dmg_to_defender >= def_wounds && dmg_to_charger >= atk_wounds
						logfile.puts "Both Characters were killed, this is counted as a half - victory"
						defender_victories = defender_victories + 0.5
						attacker_victories = attacker_victories + 0.5
						break
					end
				end
				
				
				### On odd rounds beyond the first, charger can fire their pistol
				
				if round > 1 && charger.getPistols.size > 0
					pistol_dmg = 0
					logfile.puts "---- In their Shooting Phase the charger gets to fire all their pistols ------"
					
					atk_pistol_hash.each do |pistol, mode|
						pistol_dmg = RollWeaponShooting(defender,charger,pistol,mode,1,false,logfile)
						dmg_to_defender = dmg_to_defender + pistol_dmg[0]
						dmg_to_charger = dmg_to_charger + pistol_dmg[1]
					end
					
					logfile.puts "Total DMG inflincted: #{pistol_dmg[0]} total self inflincted damage #{pistol_dmg[1]}"
					
					#### Check if anyone has won
					if dmg_to_charger >= atk_wounds && dmg_to_defender < def_wounds
						logfile.puts "The defender, #{defender.getName} won!"
						defender_victories = defender_victories + 1.0
						break
					end
					if dmg_to_defender >= def_wounds && dmg_to_charger < atk_wounds
						logfile.puts "The charger, #{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
					if dmg_to_defender >= def_wounds && dmg_to_charger >= atk_wounds
						logfile.puts "Both Characters were killed, this is counted as a half - victory"
						defender_victories = defender_victories + 0.5
						attacker_victories = attacker_victories + 0.5
						break
					end
				end
						
						
							
		
				## If defender always fights first they go here!
				if defender.hasRule('Always Strikes First') == true && charger.hasRule('Always Strikes First') == false
					logfile.puts "                      #{defender.getName} always strikes first!                    "
					logfile.puts "                        Roll Defenders round #{round} Attacks                  "
					dmg_to_charger = dmg_to_charger + RollMeleeWeapon(defender,charger,def_wep,def_mode,false,logfile)
					logfile.puts "#{charger.getName} has #{atk_wounds - dmg_to_charger} wounds left"
					if dmg_to_charger >= atk_wounds
						logfile.puts "The defender, #{defender.getName} won!"
						defender_victories = defender_victories + 1.0
						break
					end
				end
				### Have the Charger fight for their intial round
				if round == 1
					logfile.puts "                  Roll Initital Charge!                             "
					dmg_to_defender = dmg_to_defender + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,true,logfile)
					logfile.puts "#{defender.getName} has #{def_wounds - dmg_to_defender} wounds left"
					if dmg_to_defender >= def_wounds
						logfile.puts "The charger, #{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
				else
					logfile.puts "                   Roll Chargers Round #{round} Attacks                  "
					dmg_to_defender = dmg_to_defender + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,false,logfile)
					logfile.puts "#{defender.getName} has #{def_wounds - dmg_to_defender} wounds left"
					if dmg_to_defender >= def_wounds
						logfile.puts "The charger, #{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
				end
			
				### IF they both get to fight first or if defender fight second defender fights here
				if defender.hasRule('Always Strikes First') == false or
					(charger.hasRule('Always Strikes First') == true &&
					defender.hasRule('Always Strikes First') == true)
				
					logfile.puts "                        Roll Defenders round #{round} Attacks                  "
					dmg_to_charger = dmg_to_charger + RollMeleeWeapon(defender,charger,def_wep,def_mode,false,logfile)
					logfile.puts "#{charger.getName} has #{atk_wounds - dmg_to_charger} wounds left"
					if dmg_to_charger >= atk_wounds
						logfile.puts "The defender, #{defender.getName} won!"
						defender_victories = defender_victories + 1.0
						break
					end
				end
			end
			
			### Even Rounds are the defenders turn
			if round.even? 
			
				## defender heals
				if defender.hasRule('Healing Balms - D3')
					healed = RollDice('D3')
					dmg_to_defender = dmg_to_defender - healed
					if dmg_to_defender < 0
						dmg_to_defender = 0
					end
					logfile.puts "#{defender.getName} heals #{healed} wounds leaving then with #{def_wounds - dmg_to_defender} wounds"
				end	
				
				
				defender.ClearRoundModifiers
				
				#### Use Psyker Powers
				if defender.getPowers.size >= 1
					logfile.puts "#{defender.getName} can now use their psychic powers"
					cast_results = CastPowersWithDenier(defender,charger,range,logfile)
					dmg_to_defender = dmg_to_defender + cast_results[1]
					dmg_to_charger= dmg_to_charger + cast_results[0]
					
					### Print damage to logfile
					if cast_results[1] > 0
						logfile.puts "#{defender.getName} took #{cast_results[1]} damage from psychic powers and has #{atk_wounds - dmg_to_charger} wounds left"
					end
					if cast_results[0] > 0
						logfile.puts "#{charger.getName} took #{cast_results[0]} damage from perils and has #{def_wounds - dmg_to_defender} wounds left"
					end
					
					#### Check if anyone has won
					if dmg_to_charger >= atk_wounds && dmg_to_defender < def_wounds
						logfile.puts "The defender, #{defender.getName} won!"
						defender_victories = defender_victories + 1.0
						break
					end
					if dmg_to_defender >= def_wounds && dmg_to_charger < atk_wounds
						logfile.puts "The charger, #{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
					if dmg_to_defender >= def_wounds && dmg_to_charger >= atk_wounds
						logfile.puts "Both Characters were killed, this is counted as a half - victory"
						defender_victories = defender_victories + 0.5
						attacker_victories = attacker_victories + 0.5
						break
					end
				end
				
				
				#### On even rounds the defender gets to fire their pistol
				if round > 1 && defender.getPistols.size > 0
					logfile.puts "---- In their Shooting Phase the defender gets to fire all their pistols ------"
					pistol_dmg = 0
					def_pistol_hash.each do |pistol, mode|
						pistol_dmg = RollWeaponShooting(charger,defender,pistol,mode,1,false,logfile)
						dmg_to_defender = dmg_to_defender + pistol_dmg[1]
						dmg_to_charger = dmg_to_charger + pistol_dmg[0]
					end
					
					logfile.puts "Total DMG inflincted: #{pistol_dmg[0]} total self inflincted damage #{pistol_dmg[1]}"
					#### Check if anyone has won
					if dmg_to_charger >= atk_wounds && dmg_to_defender < def_wounds
						logfile.puts "The defender, #{defender.getName} won!"
						defender_victories = defender_victories + 1.0
						break
					end
					if dmg_to_defender >= def_wounds && dmg_to_charger < atk_wounds
						logfile.puts "The charger, #{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
					if dmg_to_defender >= def_wounds && dmg_to_charger >= atk_wounds
						logfile.puts "Both Characters were killed, this is counted as a half - victory"
						defender_victories = defender_victories + 0.5
						attacker_victories = attacker_victories + 0.5
						break
					end
				end
		
				## If Attacker always fights first they go here!
				if charger.hasRule('Always Strikes First') == true && defender.hasRule('Always Strikes First') == false
					logfile.puts "                      #{charger.getName} always strikes first!                    "
					logfile.puts "                        Roll Chargers round #{round} Attacks                  "
					dmg_to_defender = dmg_to_defender + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,false,logfile)
					logfile.puts "#{defender.getName} has #{def_wounds - dmg_to_defender} wounds left"
					if dmg_to_defender >= def_wounds
						logfile.puts " The Charger, #{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
				end
				
				
				logfile.puts "                   Roll Defenders Round #{round} Attacks                  "
				dmg_to_charger = dmg_to_charger + RollMeleeWeapon(defender,charger,def_wep,def_mode,false,logfile)
				logfile.puts"#{charger.getName} has #{atk_wounds - dmg_to_charger} wounds left"
				if dmg_to_charger >= atk_wounds
					logfile.puts "The Defender, #{defender.getName} won!"
					defender_victories = defender_victories + 1.0
					break
				end
			
			
				### If they both get to fight first or if the charger fights second, the charger fights here
				if charger.hasRule('Always Strikes First') == false or
					(charger.hasRule('Always Strikes First') == true &&
					defender.hasRule('Always Strikes First') == true)
				
					logfile.puts "                        Roll Charger's round #{round} Attacks                  "
					dmg_to_defender = dmg_to_defender + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,false,logfile)
					logfile.puts "#{defender.getName} has #{def_wounds - dmg_to_defender} wounds left"
					if dmg_to_defender >= def_wounds
						logfile.puts "The Charger, #{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
				end
			
		
				
				
			end
			
				
				
			
			if round == 20
				logfile.puts "It was a draw after 20 rounds"
				attacker_victories = attacker_victories + 0.5
				defender_victories = defender_victories + 0.5
				break
			end
		end	
	end

	odds = attacker_victories / iterations

	#logfile.puts "#{charger.getName()} won #{attacker_victories} times"
	#logfile.puts "#{defender.getName()} won #{defender_victories} times"
	return odds
end
		
		
	
	