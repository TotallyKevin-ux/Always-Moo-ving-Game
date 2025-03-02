extends Node2D

# Define the grid size and tiles
const GRID_SIZE = 45
var grid = []
var tiles = []

# This represents the constraints for neighboring tiles
var adjacency = {
	"A": {"A": 1, "B": 1, "C": 0},
	"B": {"A": 1, "B": 1, "C": 0},
	"C": {"A": 0, "B": 0, "C": 1}
}

var row_of_entropy = []

var possible_tiles = {
	
}

func _ready():
	# Initialize the grid and possible tiles
	grid = []
	for i in range(GRID_SIZE):
		grid.append([])
	for i in range(GRID_SIZE):
		for j in range(GRID_SIZE):
			grid[j].append([])  # Correctly fill the grid 
			possible_tiles[Vector2(i, j)] = ["A", "B", "C", "D"]

# Example usage of calculating entropy
	for i in range(GRID_SIZE):
		row_of_entropy = []
		for j in range(GRID_SIZE):
			var entropy = calculate_entropy(i,j)
			row_of_entropy.append(entropy)
		row_of_entropy.append(3)
		grid.append(row_of_entropy)


	for n in grid:
		print(n)


func calculate_entropy(x: int, y: int) -> float:
	# Get the possible tiles for the given position
	var tile_options = possible_tiles.get(Vector2(x, y), [])
	
	# Entropy calculation
	var total_options = tile_options.size()
	if total_options == 0:
		return 0.0  # No options, entropy is 0

	return tile_options.size()



func wave_collapse():
	for x in range(GRID_SIZE):
		for y in range(GRID_SIZE):
			grid[x][y] = select_tile(x, y)

func select_tile(x: int, y: int) -> String:
	possible_tiles = []
	for tile in tiles:
		if is_valid_tile(tile, x, y):
			possible_tiles.append(tile)  
	if possible_tiles.size() > 0:
		# Randomly select a tile
		return possible_tiles[randi() % possible_tiles.size()]  
	else:
		return 'Failure'

func is_valid_tile(tile: String, x: int, y: int) -> bool:
	# Check neighboring tiles
	for dx in [-1, 0, 1]:
		for dy in [-1, 0, 1]:
			if dx == 0 and dy == 0:
				continue
			var neighbor_x = x + dx
			var neighbor_y = y + dy
			if neighbor_x >= 0 and neighbor_x < GRID_SIZE and neighbor_y >= 0 and neighbor_y < GRID_SIZE:
					var neighbor_tile = grid[neighbor_x][neighbor_y]
					if adjacency[tile][neighbor_tile] == 0:
						return false
	return true
