require_relative '..\Classes\CodexEntry.rb'
require 'yaml'


GKcodex = Hash.new{}

draigo_stats = [5,2,,2,4,4,7,5,9,2]
draigo_gear = ['The Titansword','Storm Bolter','Frag Grenade', 'Krak Grenade', 'Psykout Grenade', 'Smite']
draigo_cost = 240
draigo_rules = ['Invulnerable - 3', 'Chapter Master', 'Deepstrike',]
spacemarinecodex['Marneus Calgar'] = CodexEntry.new(calgar_stats, calgar_gear, calgar_rules, calgar_cost)