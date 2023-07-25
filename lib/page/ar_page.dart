import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

class ArPage extends StatefulWidget {
  const ArPage({super.key});

  @override
  State<ArPage> createState() => _ArPageState();
}

class _ArPageState extends State<ArPage> {
  late ARSessionManager _arSessionManager;
  late ARObjectManager _arObjectManager;

  ARNode? _localObjectNode;
  ARNode? _webObjectNode;

  void onARViewCreated(
    ARSessionManager arSessionManager, 
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager
  ){
    _arSessionManager = arSessionManager;
    _arObjectManager = arObjectManager;

    _arSessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      customPlaneTexturePath: "assets/png/triangle.png",
      showWorldOrigin: true,
      showAnimatedGuide: true,
      handleTaps: false
    );

    _arObjectManager.onInitialize();
  }

  Future<void> onLocalObjectButtonPressed() async {
    // 1
    if (_localObjectNode != null) {
      _arObjectManager.removeNode(_localObjectNode!);
      _localObjectNode = null;
    } else {
      // 2
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "assets/gltf/chicken/Chicken_01.gltf",
          scale: Vector3(0.2, 0.2, 0.2),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      // 3
      bool? didAddLocalNode = await _arObjectManager.addNode(newNode);
      _localObjectNode = (didAddLocalNode!) ? newNode : null;
    }
  }

  Future<void> onWebObjectAtButtonPressed() async {
    if (_webObjectNode != null) {
      _arObjectManager.removeNode(_webObjectNode!);
      _webObjectNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri: "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb",
          scale: Vector3(0.2, 0.2, 0.2));
      bool? didAddWebNode = await _arObjectManager.addNode(newNode);
      _webObjectNode = (didAddWebNode!) ? newNode : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AR"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ARView(
              onARViewCreated: onARViewCreated,
              
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => onLocalObjectButtonPressed(), 
                  child: const Text("Add local object")
                ),
                ElevatedButton(
                  onPressed: () => onWebObjectAtButtonPressed(), 
                  child: const Text("Add online object")
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}