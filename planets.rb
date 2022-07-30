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