extends MarginContainer

var CarNode: VehicleBody3D

@onready var PresetList = $ScrollContainer/MarginContainer/List/Car/PresetList
@onready var DeleteButton = $ScrollContainer/MarginContainer/List/Car/PresetButtons/DeletePreset
@onready var LoadButton = $ScrollContainer/MarginContainer/List/Car/PresetButtons/LoadPreset

func _ready():
	if CarNode == null:
		queue_free()
		return
	
	# Example instancing fix
	var Wheels = {}
	for Wheel in CarNode.get_children():
		if Wheel is VehicleWheel3D:
			Wheels[Wheel.name] = Wheel

	for Items in Wheels:
		var Wheel = Wheels[Items]
		var ToInstance = preload("../scenes/wheelsettings.tscn").instantiate()
		ToInstance.get_child(0).text = Wheel.name
		ToInstance.name = Wheel.name
		ToInstance.get_node("Binding/BindedTo").add_item("none")
		for items in Wheels:
			if Wheels[items].name != Wheel.name:
				ToInstance.get_node("Binding/BindedTo").add_item(Wheels[items].name)
		ToInstance.set("WheelNode", { Wheel.name: Wheel })
		get_node("ScrollContainer/MarginContainer/List").add_child(ToInstance)

	GetPresets()
	if PresetList.item_count > 0:
		if PresetList.get_item_text(PresetList.item_count - 1) != "No Presets":
			PresetList.select(0)
			_on_PresetList_item_selected(0)
			LoadPreset()

# -------------------------
# Save Preset
# -------------------------
func SavePreset():
	var presetName = $ScrollContainer/MarginContainer/List/Car/SavePreset/PresetName
	if presetName.text.length() < 1:
		presetName.text = "Can't be Empty"
		return

	print("Generating Preset File")

	if not DirAccess.dir_exists_absolute("user://3d_car_customizable/"):
		DirAccess.make_dir_absolute("user://3d_car_customizable/")

	var preset_file = FileAccess.open("user://3d_car_customizable/" + presetName.text + ".json", FileAccess.WRITE)
	if preset_file == null:
		print("Could not open preset file for writing")
		return

	var CarPreset = {
		"MAX_ENGINE_FORCE": CarNode.get("MAX_ENGINE_FORCE"),
		"MAX_BRAKE": CarNode.get("MAX_BRAKE"),
		"MAX_STEERING": CarNode.get("MAX_STEERING"),
		"STEERING_SPEED": CarNode.get("STEERING_SPEED"),
		"mass": CarNode.mass,
		"weight": CarNode.weight,
		"wheel_names": ""
	}

	for Wheel in CarNode.get_children():
		if Wheel is VehicleWheel3D:
			CarPreset["wheel_names"] += Wheel.name + "."
			CarPreset[Wheel.name] = get_node("ScrollContainer/MarginContainer/List").get_node(NodePath(Wheel.name)).save()

	preset_file.store_line(JSON.stringify(CarPreset))
	preset_file.close()
	GetPresets()

# -------------------------
# Get Presets
# -------------------------
func GetPresets():
	PresetList.clear()
	if DirAccess.dir_exists_absolute("user://3d_car_customizable/"):
		var dir = DirAccess.open("user://3d_car_customizable/")
		if dir:
			for file_name in dir.get_files():
				if file_name.ends_with(".json"):
					PresetList.add_item(file_name.replace(".json", ""))
					PresetList.set_item_tooltip_enabled(PresetList.item_count - 1, false)
			if PresetList.item_count < 1:
				PresetList.add_item("No Presets")
				PresetList.set_item_tooltip_enabled(PresetList.item_count - 1, false)
	else:
		PresetList.add_item("No Presets")
		PresetList.set_item_tooltip_enabled(PresetList.item_count - 1, false)

# -------------------------
# Load Preset
# -------------------------
func LoadPreset():
	var selected = PresetList.get_selected_items()
	if selected.size() == 0:
		return
	var preset_name = PresetList.get_item_text(selected[0])
	var path = "user://3d_car_customizable/" + preset_name + ".json"

	if not FileAccess.file_exists(path):
		print("Preset doesn't exist")
		return

	var preset_file = FileAccess.open(path, FileAccess.READ)
	if preset_file == null:
		return

	var CarPreset = JSON.parse_string(preset_file.get_line())
	if typeof(CarPreset) != TYPE_DICTIONARY:
		print("Invalid preset file")
		return

	_on_MaxEngineForce_value_changed(CarPreset["MAX_ENGINE_FORCE"])
	_on_MaxBrake_value_changed(CarPreset["MAX_BRAKE"])
	_on_MaxSteering_value_changed(CarPreset["MAX_STEERING"])
	_on_SteeringSpeed_value_changed(CarPreset["STEERING_SPEED"])
	_on_Mass_value_changed(CarPreset["mass"])
	_on_Weight_value_changed(CarPreset["weight"])

	for WheelName in CarPreset["wheel_names"].split(".", false):
		if WheelName == "":
			continue
		CarPreset[WheelName] = get_node(NodePath("ScrollContainer/MarginContainer/List/" + str(WheelName))).save()
	preset_file.close()

func _on_MaxEngineForce_value_changed(value):
	get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/EngineForceText").text = "Max Engine Force = (" + str(value) + ")"
	if(get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/EngineForce/MaxEngineForce").value != value): get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/EngineForce/MaxEngineForce").value = value
	if(get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/EngineForce/MaxEngineForceBox").value != value): get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/EngineForce/MaxEngineForceBox").value = value
	CarNode.set("MAX_ENGINE_FORCE", value)

func _on_MaxBrake_value_changed(value):
	get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/BrakeText").text = "Max Brake Force = (" + str(value) + ")"
	if(get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/Brake/MaxBrake").value != value): get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/Brake/MaxBrake").value = value
	if(get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/Brake/MaxBrakeBox").value != value): get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/Brake/MaxBrakeBox").value = value
	CarNode.set("MAX_BRAKE", value)

func _on_MaxSteering_value_changed(value):
	get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/SteeringText").text = "Max Steering Angle = (" + str(value) + ")"
	if(get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/Steering/MaxSteering").value != value): get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/Steering/MaxSteering").value = value
	if(get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/Steering/MaxSteeringBox").value != value): get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/Steering/MaxSteeringBox").value = value
	CarNode.set("MAX_STEERING", value)

func _on_SteeringSpeed_value_changed(value):
	get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/SteeringSpeedText").text = "Steering Speed = (" + str(value) + ")"
	if(get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/SteeringSpeed/SteeringSpeed").value != value): get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/SteeringSpeed/SteeringSpeed").value = value
	if(get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/SteeringSpeed/SteeringSpeedBox").value != value): get_node("ScrollContainer/MarginContainer/List/Car/ScriptVariables/SteeringSpeed/SteeringSpeedBox").value = value
	CarNode.set("STEERING_SPEED", value)

func _on_Mass_value_changed(value):
	get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/MassText").text = "Mass = (" + str(value) + ")"
	if(get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Mass/Mass").value != value): get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Mass/Mass").value = value
	if(get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Mass/MassBox").value != value): get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Mass/MassBox").value = value
	CarNode.mass = value
	get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/WeightText").text = "Weight = (" + str(CarNode.weight) + ")"
	if(get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Weight/Weight").value != CarNode.weight): get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Weight/Weight").value = CarNode.weight
	if(get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Weight/WeightBox").value != CarNode.weight): get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Weight/WeightBox").value = CarNode.weight

func _on_Weight_value_changed(value):
	get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/WeightText").text = "Weight = (" + str(value) + ")"
	if(get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Weight/Weight").value != value): get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Weight/Weight").value = value
	if(get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Weight/WeightBox").value != value): get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Weight/WeightBox").value = value
	CarNode.weight = value
	get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/MassText").text = "Mass = (" + str(CarNode.mass) + ")"
	if(get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Mass/Mass").value != CarNode.mass): get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Mass/Mass").value = CarNode.mass
	if(get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Mass/MassBox").value != CarNode.mass): get_node("ScrollContainer/MarginContainer/List/Car/VehicleBody/Mass/MassBox").value = CarNode.mass

func _on_PresetList_item_selected(index):
	if(PresetList.get_item_text(index) == "No Presets"): return
	$ScrollContainer/MarginContainer/List/Car/PresetButtons.visible = true
	DeleteButton.disabled = false
	DeleteButton.text = "Delete Preset: " + PresetList.get_item_text(index)
	LoadButton.disabled = false
	LoadButton.text = "Load Preset: " + PresetList.get_item_text(index)
	$ScrollContainer/MarginContainer/List/Car/SavePreset/PresetName.text = PresetList.get_item_text(index)
