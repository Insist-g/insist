import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class PhotoViewGalleryScreen extends StatefulWidget {
  final List images;
  final int index;
  final String heroTag;
  late PageController? controller;

  PhotoViewGalleryScreen(
      {Key? key,
      required this.images,
      this.index = 0,
      this.controller,
      required this.heroTag})
      : super(key: key) {
    controller = PageController(initialPage: index);
  }

  @override
  _PhotoViewGalleryScreenState createState() => _PhotoViewGalleryScreenState();
}

class _PhotoViewGalleryScreenState extends State<PhotoViewGalleryScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
                child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                // Uint8List bytes = convert.base64.decode(widget.images[index]);
                return widget.images[index] is String
                    ? PhotoViewGalleryPageOptions(
                        imageProvider: widget.images[index].startsWith('http')
                            ? CachedNetworkImageProvider(widget.images[index])
                            : AssetImage(widget.images[index]) as ImageProvider,
                        heroAttributes: widget.heroTag.isNotEmpty
                            ? PhotoViewHeroAttributes(tag: widget.heroTag)
                            : null,
                      )
                    : PhotoViewGalleryPageOptions(
                        imageProvider: AssetEntityImageProvider(
                            widget.images[index],
                            isOriginal: true));
              },
              itemCount: widget.images.length,
              loadingBuilder: (context, event) {
                return Container(
                  alignment: Alignment.center,
                  child: SpinKitFadingCube(size: 30, color: AppColor.mainColor),
                );
              },
              backgroundDecoration: null,
              pageController: widget.controller,
              enableRotation: false,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            )),
          ),
          Positioned(
            //图片index显示
            top: MediaQuery.of(context).padding.top + 15,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("${currentIndex + 1}/${widget.images.length}",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
          Positioned(
            //右上角关闭按钮
            right: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
