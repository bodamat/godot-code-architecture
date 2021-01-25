tool
extends EditorScenePostImport

func post_import(scene):
	scene = scene as Spatial
	var mesh = scene.get_child(0).get_child(0) as MeshInstance
	mesh.create_trimesh_collision()
	
	return scene
