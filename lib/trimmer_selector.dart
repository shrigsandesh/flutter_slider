import 'package:custom_slider/selector_widget.dart';
import 'package:flutter/material.dart';

class VideoTrimmerSelector extends StatefulWidget {
  const VideoTrimmerSelector({super.key});

  @override
  State<VideoTrimmerSelector> createState() => _VideoTrimmerSelectorState();
}

class _VideoTrimmerSelectorState extends State<VideoTrimmerSelector> {
  double thumbnailHeight = 100.0;
  double thumbnailWidth = 60;

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trimmer ui"),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                SizedBox(
                    height: thumbnailHeight,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 13,
                      itemBuilder: (context, index) {
                        return Container(
                            color: index.isEven ? Colors.blue : Colors.grey,
                            child: Center(child: Text(" frame $index")));
                      },
                    )),
                SelectorWidget(
                    initialWidth: 13 * thumbnailWidth - 20,
                    height: thumbnailHeight)
              ],
            ),
          )
        ],
      ),
    );
  }
}
