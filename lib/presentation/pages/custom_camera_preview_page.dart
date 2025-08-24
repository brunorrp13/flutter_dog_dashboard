import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class CustomCameraPage extends ConsumerStatefulWidget {
  const CustomCameraPage({super.key});

  @override
  ConsumerState<CustomCameraPage> createState() => _CustomCameraPageState();
}

class _CustomCameraPageState extends ConsumerState<CustomCameraPage> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  int _currentIndex = 0; // 0 = back, 1 = front

  @override
  void initState() {
    super.initState();
    _initCameras();
  }

  Future<void> _initCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      // default to back camera
      _currentIndex = 0;
      _initCamera(_cameras[_currentIndex]);
    }
  }

  Future<void> _initCamera(CameraDescription camera) async {
    _controller =
        CameraController(camera, ResolutionPreset.high, enableAudio: false);

    _controller!.addListener(() {
      if (mounted) setState(() {});
      if (_controller!.value.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Camera error: ${_controller!.value.errorDescription}")),
        );
      }
    });

    try {
      await _controller!.initialize().timeout(const Duration(seconds: 3));
      if (mounted) setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ Camera not available."),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _toggleCameraLens() {
    if (_cameras.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ Front camera not available."),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Switch between back (0) and front (1)
    _currentIndex = _currentIndex == 0 ? 1 : 0;
    _initCamera(_cameras[_currentIndex]);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pet Camera")),
      body: _controller == null || !_controller!.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : CameraPreview(_controller!),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "toggleCamera",
            child: const Icon(Icons.cameraswitch),
            onPressed: _toggleCameraLens,
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: "takePhoto",
            child: const Icon(Icons.camera),
            onPressed: () async {
              if (_controller != null && _controller!.value.isInitialized) {
                try {
                  final file = await _controller!.takePicture();
                  await ref
                      .read(getDogProvider.notifier)
                      .updateOwnerPhoto(file.path);

                  if (mounted) {
                    Navigator.pop(context);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("❌ Failed to take photo: $e"),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
