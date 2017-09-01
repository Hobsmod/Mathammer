require_relative '..\Classes\Weapon.rb'
require 'yaml'
require 'csv'

spacemarineweapons = Hash.new{}




puts spacemarinecodex.inspect
File.write('SpaceMarineCodex.yml', spacemarinecodex.to_yaml)