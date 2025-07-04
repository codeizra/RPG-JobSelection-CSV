extends Control

# onready nodes
@onready var job_dropdown = $VBoxContainer/JobDropdown
@onready var job_name_label = $VBoxContainer/JobNameLabel
@onready var job_description_label = $VBoxContainer/JobDescriptionLabel
@onready var skills_box = $VBoxContainer/SkillsBox
@onready var job_image = $HBoxContainer/JobImage
@onready var job_card_image = $HBoxContainer/JobCardImage


# skills box font
var skill_font = preload("res://asset/fonts/oldstyle_hplhs/OLDSH___.TTF")

# array to store job data
var jobs: Array[Dictionary] = []

# dictionary to store path to imgs
var job_assets = {
	"Warrior": preload("res://asset/jobs/ER_Class_Vagabond.png"),
	"Mage": preload("res://asset/jobs/ER_Class_Confessor.png"),
	"Thief": preload("res://asset/jobs/ER_Class_Bandit.png")
}

# dictionary to store path to imgs
var job_cards = {
	"Warrior": preload("res://asset/cards/WARRIOR_CARD.jpg"),
	"Mage": preload("res://asset/cards/MAGE_CARD.jpg"),
	"Thief": preload("res://asset/cards/THIEF_CARD.jpg")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_csv("res://resource/classes.csv")
	
	# isi dropdown
	for job in jobs:
		job_dropdown.add_item(job["JOBNAME"])
		
	job_dropdown.item_selected.connect(_on_job_dropdown_item_selected) # signal

	
	if jobs.size() > 0:
		update_ui(0)

func load_csv(file_path: String) -> void:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		push_error("‣ Could not open CSV file at %s" % file_path)
		return
		
	# read first row (header)
	var headers = file.get_csv_line(",")
		
	# read data rows
	while not file.eof_reached():
		var row = file.get_csv_line(",")
		if row.size() != headers.size() or row[0].is_empty():
			continue
		
		var job = {}
		for i in headers.size():
			job[headers[i]] = row[i].strip_edges()
			
		# parse SKILLS
		var skills_raw = job.get("SKILLS", "").split(";", false)
		var skills = []
		for skill in skills_raw:
			var trimmed = skill.strip_edges()
			if not trimmed.is_empty():
				skills.append(trimmed)
		job["SKILLS"] = skills
		
		jobs.append(job)
	
	file.close()
	
func update_ui(job_index : int) -> void:
	if job_index < 0 or job_index >= jobs.size():
		return
		
	var job = jobs[job_index]
	
	job_name_label.text = job.get("JOBNAME", "")
	job_description_label.text = job.get("DESCRIPTION", "")
	
	job_image.texture = job_assets.get(job.get("JOBNAME", ""), null)
	job_card_image.texture = job_cards.get(job.get("JOBNAME", ""), null)
	
	# clear
	for child in skills_box.get_children():
		child.queue_free()
		
	# isi
	for skill in job["SKILLS"]:
		var skill_label := Label.new()
		skill_label.text = "- %s" % skill
		skill_label.add_theme_font_override("font", skill_font)
		skill_label.add_theme_font_size_override("font_size", 20)
		skills_box.add_child(skill_label)
		
func _on_job_dropdown_item_selected(index: int) -> void:
	update_ui(index)
