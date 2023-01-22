import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:policesystem/api/applicant_api.dart';
import 'package:policesystem/panel/camera_panel.dart';
import 'package:signature/signature.dart';

class SignaturePanel extends StatefulWidget {
  const SignaturePanel({Key? key, required this.applicantId}) : super(key: key);

  final int applicantId;

  @override
  State<SignaturePanel> createState() => _SignaturePanelState();
}

class _SignaturePanelState extends State<SignaturePanel> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 4.0,
    exportBackgroundColor: Colors.transparent,
    penColor: Colors.black,
  );

  String? signature;
  String? image;

  void openCamera() async {
    image = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CameraPanel(),
      ),
    );
    print(image);

    addApplicantDetails({
      'applicant_id': widget.applicantId.toString(),
      'signature': signature,
      'picture': image
    });

    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void onSave() async {
    if (_controller.isNotEmpty) {
      final Uint8List? data = await _controller.toPngBytes();
      if (data != null) {
        final base64 = base64Encode(data);

        setState(() {
          signature = base64;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Image.memory(data),
            actions: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('Is this the Final Signature?'),
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        if (_controller != null) {
                          openCamera();
                        } else {
                          Navigator.of(context).pop(false);
                        }
                      },
                      child: const Text('Yes'),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('No'),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature Panel'),
      ),
      body: ListView(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Sign Signature Here:",
                style: TextStyle(fontSize: 20.0, fontFamily: 'RobotoMono'),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
            height: 460,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              elevation: 5,
              margin: const EdgeInsets.only(left: 450, right: 450),
              child: Signature(
                width: 450,
                height: 400,
                backgroundColor: const ui.Color.fromARGB(255, 202, 202, 202),
                controller: _controller,
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                onSave();
              },
              child: const Expanded(
                child: Text(
                  'Save',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _controller.clear();
              },
              child: const Text(
                'Clear',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
