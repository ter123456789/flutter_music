import 'package:flutter/widgets.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xFFE0E0E0),
      child: const Center(
        child: Image(image: AssetImage('assets/images/image.png')),
      ),
    );
  }
}
