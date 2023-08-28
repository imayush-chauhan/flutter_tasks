import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagicText extends StatefulWidget {
  const MagicText({Key? key}) : super(key: key);

  @override
  State<MagicText> createState() => _MagicTextState();
}

class _MagicTextState extends State<MagicText> {

  double top = 0;
  double left = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData(){
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        top = top +  event.x*1.5;
        left = left +  event.y*1.5;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [

            const SizedBox(height: 100,),
            Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  height: 72,
                  width: 250,
                ),
                Positioned(
                  top: -50 + top,
                  left: -50 + left,
                  bottom: -50 - top,
                  right: -50 - left,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1558470598-a5dda9640f68?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1771&q=80',
                      fit:BoxFit.cover,
                    ),
                  ),
                ),
                CustomPaint(
                  painter: CutOutTextPainter(text: 'Hello World!'),
                ),
              ],
            ),

            const SizedBox(height: 20,),

            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -50 + top,
                  left: -50 + left,
                  bottom: -50 - top,
                  right: -50 - left,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1558470598-a5dda9640f68?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1771&q=80',
                      fit:BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black,width: 2)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CutOutTextPainter extends CustomPainter {
  CutOutTextPainter({required this.text}) {
    _textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 45.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    _textPainter.layout();
  }

  final String text;
  late final TextPainter _textPainter;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the text in the middle of the canvas
    final textOffset =
        size.center(Offset.zero) - _textPainter.size.center(Offset.zero);
    final textRect = textOffset & _textPainter.size;

    // The box surrounding the text should be 10 pixels larger, with 4 pixels corner radius
    final boxRect = RRect.fromRectAndRadius(
        textRect.inflate(10.0), const Radius.circular(4.0));
    final boxPaint = Paint()
      ..color = Colors.white
      ..blendMode = BlendMode.srcOut;

    canvas.saveLayer(boxRect.outerRect, Paint());

    _textPainter.paint(canvas, textOffset);
    canvas.drawRRect(boxRect, boxPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CutOutTextPainter oldDelegate) {
    return text != oldDelegate.text;
  }
}