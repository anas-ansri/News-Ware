import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return buildCardShimmer();
      },
    );
  }

  Widget buildCardShimmer() {
    return Card(
      shadowColor: Colors.black54,
      margin: const EdgeInsets.all(3),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black38, width: 0)),
      child: Column(children: [
        const ListTile(
          trailing: Icon(Icons.more_vert),
          title: ShimmerWidget.rectangular(
            height: 16,
          ),
          subtitle: ShimmerWidget.rectangular(height: 10),
        ),
        const ShimmerWidget.rectangular(height: 200),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: const [
            ShimmerWidget.rectangular(height: 17),
            SizedBox(height: 3),
            ShimmerWidget.rectangular(height: 10),
          ]),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [
          SizedBox(
            width: 15,
          ),
          Icon(Icons.bookmark_border),
          const Spacer(),
          Icon(Icons.share),
          SizedBox(
            width: 15,
          ),
        ]),
        SizedBox(
          height: 10,
        )
      ]),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular(
      {this.width = double.infinity, required this.height})
      : this.shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey[300]!,
        period: Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      );
}
