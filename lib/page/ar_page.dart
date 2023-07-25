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

  ARNode? _webObjectNode;

  bool _loadGlb = false;

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
      showWorldOrigin: false,
      showAnimatedGuide: false,
      handleTaps: false,
      handleRotation: true,
      handlePans: true,
    );

    _arObjectManager.onInitialize();
  }

  void loadGlb(bool value){
    setState(() => _loadGlb = value);
  }

  Future<void> onWebObjectAtButtonPressed() async {
    loadGlb(true);
    if (_webObjectNode != null) {
      _arObjectManager.removeNode(_webObjectNode!);
      _webObjectNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri: "https://raw.githubusercontent.com/LoicLamailleEpsi/PayeTonKawa-Front/feat/coffeeAR/Nespresso.glb",
          scale: Vector3(0.1, 0.1, 0.1));
      bool? didAddWebNode = await _arObjectManager.addNode(newNode);
      _webObjectNode = (didAddWebNode!) ? newNode : null;
    }
    loadGlb(false);
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
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: !_loadGlb ? () => onWebObjectAtButtonPressed() : null, 
                    child: _loadGlb ? const SizedBox(width: 20,  height: 20, child: CircularProgressIndicator()) : const Text("Afficher la machine à café"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}