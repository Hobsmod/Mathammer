require_relative 'ShootingMethods.rb'


def ShootingAtTarget(unit, gear_hash, target, range, moved)
	possible_grenade_users = Hash.new{|key, value| value = Array.new}
	total_dmg = 0.0
	#begin to calculate damage for each models
	unit.getModels.each do |model|

		#set up all the damage types
		main_dmg = 0.0
		grenade_dmg = 0.0 
		pistol_dmg = 0.0 
		
		model.getGear.each do |gear|
			if gear_hash[gear]
				weapon = gear_hash[gear]
				type = 'Blank'
				weapon_dmg = 0.0
				combi_dmg = 0.0
				
				#Iterate over each of the weapons firing modes -- firetypes
				weapon.getFiretypes.each do |firetype|
					#grab all the relevant stats for each weapon-firetype and target
					
					id = weapon.getID()
					save = target.getSv.to_f
					invuln = target.getInvuln.to_f
					
					## Calculate the number of hits
					hits = CalcHits(model, weapon, firetype, target, range, '',moved, false)
					#calculate the number of saves they must make
					saves = CalcWounds(hits[0], weapon, firetype, target, range, '')
					## Calculate the number of unsaved wounds
					unsaved_wounds = CalcSaves(saves[0], weapon, firetype, target, range, false, '')
					#calculate damage
					dmg_caused = CalcDamage(unsaved_wounds[0], weapon, firetype, target, range, '')

					
					# IF this is the firing mode that does the most damage pass it to the 
					# weapon_damage varaiable, else if it is combi add it to the combi_damage Variable
					if dmg_caused[0] > weapon_dmg && weapon.hasRule(firetype,'Combi') == false
						weapon_dmg = dmg_caused[0]
						type = weapon.getType(firetype)
					elsif weapon.hasRule(firetype ,'Combi') == true
						combi_dmg = combi_dmg + dmg_caused[0]
					end			
				end
				
				
				#check if the sum of combi modes is greater than the higher of the two modes

				if combi_dmg > weapon_dmg 
					weapon_dmg = combi_dmg
				end
				
				
				#If the weapon is of the right type, and there is not already 
				#a weapon of that type that does more damage
				if type == 'Pistol' && weapon_dmg > pistol_dmg
					pistol_dmg = weapon_dmg
				elsif type == 'Grenade' && weapon_dmg > grenade_dmg
					grenade_dmg = weapon_dmg
				else
					main_dmg = main_dmg + weapon_dmg
				end
				
				
			end	

		end
		
		#puts "Pistol Damage is #{pistol_dmg}, Grenade Damage is #{grenade_dmg}, Main Damage is #{main_dmg}"
			if pistol_dmg > main_dmg && pistol_dmg > grenade_dmg
				total_dmg = total_dmg + pistol_dmg
				#puts 'Used Pistol'
			elsif grenade_dmg > main_dmg
				possible_grenade_users[model.getID] = [grenade_dmg, main_dmg]
				#puts "may use grenade"
			else
				total_dmg = total_dmg + main_dmg
				#puts "Will just use the main guns"
			end
		
	end

	

	
	#pick the highest grenade dmg
	final_grenade_dmg = 0.0 
	grenade_user_id = 'Blank'
	possible_grenade_users.each do |key, value|
		if possible_grenade_users[key][0] >= final_grenade_dmg
			final_grenade_dmg = possible_grenade_users[key][0]
			grenade_user_id = key
		end
	end
	
	#Add the dmg from everyone who could have used a grenade but didn't
	total_dmg = total_dmg + final_grenade_dmg
	possible_grenade_users.each do |key,value|
		unless key == grenade_user_id
			#puts key
			total_dmg = total_dmg + possible_grenade_users[key][1].to_f
		end
	end
	

	#puts "The total dmg to #{targeted_unit} was #{total_dmg} wounds"	
	
	if grenade_user_id ==! 'Blanks'
		puts "Model #{grenade_user_id} used a grenade"
	end
	return total_dmg
end		
			