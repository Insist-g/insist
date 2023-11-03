import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image.dart';

class ItemBanner extends StatelessWidget {
  final String imgUrl;
  final String title;

  const ItemBanner({super.key, required this.imgUrl, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        netImageCached(
          imgUrl,
          width: double.infinity,
          height: double.infinity,
          radius: 5,
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x7F000000),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
    );
  }
}
