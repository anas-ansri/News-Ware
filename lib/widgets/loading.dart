import 'package:flutter/material.dart';
import 'package:news_ware/constants.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthValue = getWidthValue(context);
    return ListView.builder(
      // scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return buildCardShimmer(widthValue);
      },
    );
  }

  Widget buildCardShimmer(double widthValue) {
    return Card(
      shadowColor: Colors.black54,
      margin: const EdgeInsets.all(3),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.black38, width: 0)),
      child: Column(children: [
        const ListTile(
          trailing: Icon(Icons.more_vert),
          title: ShimmerWidget.rectangular(
            height: 16,
          ),
          subtitle: ShimmerWidget.rectangular(height: 10),
        ),
        ShimmerWidget.rectangular(height: 300),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: const [
            ShimmerWidget.rectangular(height: 17),
            SizedBox(height: 3),
            ShimmerWidget.rectangular(height: 10),
            ShimmerWidget.rectangular(height: 10),
          ]),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [
          SizedBox(
            width: 15,
          ),
          Icon(Icons.bookmark_border),
          Spacer(),
          Icon(Icons.share),
          SizedBox(
            width: 15,
          ),
        ]),
        const SizedBox(
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
  Widget build(BuildContext context) {
    double widthValue = getWidthValue(context);
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[200]!,
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
}
