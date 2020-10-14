import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> camerasList;

class OpenCamera extends StatefulWidget {
  @override
  _OpenCameraState createState() => _OpenCameraState();
}

class _OpenCameraState extends State<OpenCamera> {
  CameraController controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),floatingActionButton: FloatingActionButton(
      child: Icon(Icons.camera_alt),
      onPressed: ()async{
        try{
          await _initializeControllerFuture;
          final path = join(
            (await getTemporaryDirectory()).path,
            '${DateTime.now()}.jpg',
          );
          await controller.takePicture(path);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayPictureScreen(imagePath: path),
            ),
          );
        }catch(e){
          print(e);
        }
      },

    ),
    );
  }

  Future<void> initCamera() async {
    camerasList = await availableCameras();
    controller = new CameraController(camerasList[1], ResolutionPreset.medium);
    _initializeControllerFuture = controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }
}
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.upload_rounded),
        onPressed: (){
          uploadImageToFirebase(context);
        },
      ),
    );
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(imagePath);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(File(imagePath));
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );
  }
  }
