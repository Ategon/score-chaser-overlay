extends Control

@onready var FirstImage = $"VBoxContainer/LeaderboardEntry/TextureRect/TextureRect"
@onready var FirstName = $"VBoxContainer/LeaderboardEntry/TextureRect/RichTextLabel"
@onready var FirstDescription = $"VBoxContainer/LeaderboardEntry/TextureRect/RichTextLabel2"
@onready var SecondImage = $"VBoxContainer/LeaderboardEntry2/TextureRect/TextureRect"
@onready var SecondName = $"VBoxContainer/LeaderboardEntry2/TextureRect/RichTextLabel"
@onready var SecondDescription = $"VBoxContainer/LeaderboardEntry2/TextureRect/RichTextLabel2"
@onready var SecondPlace = $"VBoxContainer/LeaderboardEntry2/TextureRect/RichTextLabel3"
@onready var ThirdImage = $"VBoxContainer/LeaderboardEntry3/TextureRect/TextureRect"
@onready var ThirdName = $"VBoxContainer/LeaderboardEntry3/TextureRect/RichTextLabel"
@onready var ThirdDescription = $"VBoxContainer/LeaderboardEntry3/TextureRect/RichTextLabel2"
@onready var ThirdPlace = $"VBoxContainer/LeaderboardEntry3/TextureRect/RichTextLabel3"
@onready var FourthImage = $"VBoxContainer/LeaderboardEntry4/TextureRect/TextureRect"
@onready var FourthName = $"VBoxContainer/LeaderboardEntry4/TextureRect/RichTextLabel"
@onready var FourthDescription = $"VBoxContainer/LeaderboardEntry4/TextureRect/RichTextLabel2"
@onready var FourthPlace = $"VBoxContainer/LeaderboardEntry4/TextureRect/RichTextLabel3"
@onready var FifthImage = $"VBoxContainer/LeaderboardEntry5/TextureRect/TextureRect"
@onready var FifthName = $"VBoxContainer/LeaderboardEntry5/TextureRect/RichTextLabel"
@onready var FifthDescription = $"VBoxContainer/LeaderboardEntry5/TextureRect/RichTextLabel2"
@onready var FifthPlace = $"VBoxContainer/LeaderboardEntry5/TextureRect/RichTextLabel3"

@onready var First = $"VBoxContainer/LeaderboardEntry/TextureRect"
@onready var Second = $"VBoxContainer/LeaderboardEntry2/TextureRect"
@onready var Third = $"VBoxContainer/LeaderboardEntry3/TextureRect"
@onready var Fourth = $"VBoxContainer/LeaderboardEntry4/TextureRect"
@onready var Fifth = $"VBoxContainer/LeaderboardEntry5/TextureRect"

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_timer_timeout();
	SecondPlace.text = "[color=#999999]2nd"
	ThirdPlace.text = "[color=#ad6e44]3rd"
	FourthPlace.text = "[color=#4775c9]4th"
	FifthPlace.text = "[color=#4775c9]5th"
	First.texture = preload("res://images/leaderboardbgfirst.png")
	Second.texture = preload("res://images/leaderboardbgsecond.png")
	Third.texture = preload("res://images/leaderboardbgthird.png")
	Fourth.texture = preload("res://images/leaderboardbgother.png")
	Fifth.texture = preload("res://images/leaderboardbgother.png")
#
#	FirstName.text = "Pomo"
#	FirstDescription.text = "120000"
#	FirstImage.texture = preload("res://images/feba8db942c442f7cb5857d3fc77d501.png")
#
#	SecondName.text = "Kuviman"
#	SecondDescription.text = "110000"
#	SecondImage.texture = preload("res://images/c1183bfd83b6614a9ee7e146ce37ae58.png")
#
#	ThirdName.text = "Badcop"
#	ThirdDescription.text = "9000"
#	ThirdImage.texture = preload("res://images/320a77fbcbf2041e3853dd617ab9f177.png")
#
#	FourthName.text = "Outfrost"
#	FourthDescription.text = "5000"
#	FourthImage.texture = preload("res://images/50c8529a4e356a261209f2f957d7414c.png")
#
#	FifthName.text = "Ategon"
#	FifthDescription.text = "1"
#	FifthImage.texture = preload("res://images/8c68e034-020a-4513-9567-574c26f76a9d.png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var users = {}
	
	var f = FileAccess.open("res://data/users.txt", FileAccess.READ)
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line() 
		var localData = line.split('|');
		users[localData[0]] = localData;
	f.close()
	
	var data = []
	
	f = FileAccess.open("res://data/data.txt", FileAccess.READ)
	var i = 0
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		var localData = line.split('|');
		if(localData.size() <= 1): continue
		data.append([localData[0], int(localData[1])]);
		i += 1
	f.close()
	
	data.sort_custom(func(a, b): return a[1] - b[1] > 0)
	
	if (data.size() >= 1):
		FirstName.text = users[data[0][0]][1]
		FirstDescription.text = str(abs(data[0][1]))
		FirstImage.texture = load(users[data[0][0]][2])
	else:
		FirstName.text = ""
		FirstDescription.text = ""
		FirstImage.texture = null
	
	if (data.size() >= 2):
		SecondName.text = users[data[1][0]][1]
		SecondDescription.text = str(abs(data[1][1]))
		SecondImage.texture = load(users[data[1][0]][2])
	else:
		SecondName.text = ""
		SecondDescription.text = ""
		SecondImage.texture = null
	
	if (data.size() >= 3):
		ThirdName.text = users[data[2][0]][1]
		ThirdDescription.text = str(abs(data[2][1]))
		ThirdImage.texture = load(users[data[2][0]][2])
	else:
		ThirdName.text = ""
		ThirdDescription.text = ""
		ThirdImage.texture = null
	
	if (data.size() >= 4):
		FourthName.text = users[data[3][0]][1]
		FourthDescription.text = str(abs(data[3][1]))
		FourthImage.texture = load(users[data[3][0]][2])
	else:
		FourthName.text = ""
		FourthDescription.text = ""
		FourthImage.texture = null
	
	if (data.size() >= 5):
		FifthName.text = users[data[3][0]][1]
		FifthDescription.text = str(abs(data[3][1]))
		FifthImage.texture = load(users[data[3][0]][2])
	else:
		FifthName.text = ""
		FifthDescription.text = ""
		FifthImage.texture = null
