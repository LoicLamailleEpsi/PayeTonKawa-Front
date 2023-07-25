import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

import '../../main.dart';

class ArView extends StatefulWidget {
  const ArView({super.key});

  @override
  State<ArView> createState() => _ArViewState();
}

class _ArViewState extends State<ArView> {
  late ARSessionManager _arSessionManager;
  late ARObjectManager _arObjectManager;

  ARNode? _webObjectNode;

  bool _loadGlb = false;
  bool _nodeIsLoad = false;

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
      handleRotation: false,
      handlePans: false,
    );

    _arObjectManager.onInitialize();
  }

  void loadGlb(bool value){
    setState(() => _loadGlb = value);
  }

  Future<void> onWebObjectAtButtonPressed() async {
    if(isEmulator) return;
    loadGlb(true);
    if (_webObjectNode != null) {
      _arObjectManager.removeNode(_webObjectNode!);
      _webObjectNode = null;
    } else {
      var newNode = ARNode(
        type: NodeType.webGLB,
        uri: "https://raw.githubusercontent.com/LoicLamailleEpsi/PayeTonKawa-Front/main/Nespresso.glb",
        scale: Vector3(0.1, 0.1, 0.1),
        position: Vector3(0, 0, 0)
      );
      bool? didAddWebNode = await _arObjectManager.addNode(newNode);
      _webObjectNode = (didAddWebNode!) ? newNode : null;
    }
    setState(() => _nodeIsLoad = true);
    loadGlb(false);
  }

  void moveNode(DragUpdateDetails swipe) {
    var x = _webObjectNode!.position.x;
    var y = _webObjectNode!.position.y;
    var z = _webObjectNode!.position.z;

    if(swipe.delta.dx > 1) x += 0.002;
    if(swipe.delta.dx < -1) x -= 0.002;
    if(swipe.delta.dy > 1) y -= 0.002;
    if(swipe.delta.dy < -1) y += 0.002;

    _webObjectNode!.position = Vector3(x, y, z);
  }

  void resetPositionNode(){
    _webObjectNode!.position = Vector3(0, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onPanUpdate: (details) => _nodeIsLoad ? moveNode(details) : null,
          child: !isEmulator ? ARView(
            onARViewCreated: onARViewCreated,
          ) : const SizedBox.shrink(),
        ),
        
        Container(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Visibility(
              visible: !_nodeIsLoad,
              replacement: ElevatedButton(
                onPressed: () => resetPositionNode(), 
                child: const Text("Rénitialiser la position"),
              ),
              child: SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: () => onWebObjectAtButtonPressed(), 
                  child: _loadGlb ? const SizedBox(width: 20,  height: 20, child: CircularProgressIndicator()) : const Text("Afficher la machine à café"),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}