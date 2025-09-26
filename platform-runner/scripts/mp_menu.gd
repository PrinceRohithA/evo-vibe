extends Node


var peer
@export var address = "127.0.0.1"
@export var port = 1234

func _ready():
	multiplayer.peer_connected.connect(player_connected)
	multiplayer.peer_disconnected.connect(player_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)

func player_connected(id):
	print("player connected : " + str(id))
	SendPlayerInformation.rpc_id(1, $Control/Name.text, multiplayer.get_unique_id())

func player_disconnected(id):
	print("player disconnected : " + str(id))
	MpGlobal.players.erase(id)
	var players = get_tree().get_nodes_in_group("player")
	for i in players:
		if i.name == str(id):
			i.queue_free()

func connected_to_server():
	print("connected_to_server")

@rpc("any_peer")
func SendPlayerInformation(name, id):
	if !MpGlobal.players.has(id):
		MpGlobal.players[id] = {"name" : name , "id" : id }
	if multiplayer.is_server():
		for i in MpGlobal.players:
			SendPlayerInformation.rpc(MpGlobal.players[i].name,i)

func connection_failed():
	print("connection_failed")

@rpc("any_peer","call_local")
func start_game():
	var scene = load("res://Level Scenes/up_up_up.tscn").instantiate()
	get_tree().root.add_child(scene)
	$Control.visible = false


func _on_host_pressed():
	
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2)
	if error != OK:
		print("cannot host : " + str(error))
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	print("waiting for players")
	SendPlayerInformation($Control/Name.text, multiplayer.get_unique_id())

func _on_join_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)


func _on_start_game_pressed():
	start_game.rpc()
