require "awesome_print"
require "csv"

headers = ["id", "name", "mass", "distance"]

planets = [
	[1, "Mercury", 0.055, 0.4],
 	[2, "Venus", 0.815, 0.7], 
	[3, "Earth", 1.0, 1.0], 
	[4, "Mars", 0.107, 1.5]
]


# add the headers and the planet deatils to a new csv file called `planet_data.csv`
CSV.open("planet_data.csv", "w") do |file|
	file << headers

	planets.each do |planet|
		file << planet
	end
end

CSV.open("planet_data.csv", "a") do |file|
  file << [5, "Jupiter", 1234, 3321]
end

csv_with_headers = CSV.open("planet_data.csv", "r", headers: true, header_converters: :symbol)
csv_with_headers.each do |row|
  ap row
end

CSV.open("planet_data.csv", "r", headers: true, header_converters: :symbol).each do |row|
  ap "#{row[:name]} has a mass of #{row[:mass]} and distance of #{row[:distance]}"
end

################################################################################################################
# Game design starts from here
require "catpix"
require "launchy"

$solar_system_data = CSV.read("Solar System.csv", headers: true, header_converters: :symbol)

ap "WELCOME TO THE SOLAR SYSTEM!!"

def explore_planet
  ap $solar_system_data.by_col[:name]

  prompt = "Where would you like to start? 0 - #{$solar_system_data.length}"
  ap prompt

  input = gets.chomp
  $selected_planet = $solar_system_data[input.to_i]

  until $selected_planet && /\d/.match(input)
    ap prompt 
    input = gets.chomp
    $selected_planet = $solar_system_data[input.to_i]
  end

  ap $selected_planet

  prompt = "Do you want to LEARN or SEE"
  ap prompt

  while input = gets.chomp
    case input.downcase 
    when "learn" 
      Launchy.open($selected_planet[:uri])
      return 
    when "see"
      Catpix::print_image $selected_planet[:image]
      return
    else
      ap prompt
    end
  end
end

explore_planet()