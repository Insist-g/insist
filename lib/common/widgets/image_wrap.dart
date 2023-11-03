import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/test_upload.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class SelectedImageUtil {
  /// 拍照
  static Future<AssetEntity?> photoCameraAction(BuildContext context) async {
    final permission = await Permission.camera.request();
    if (!permission.isGranted) {
      EasyLoading.showToast('未开启权限');
    }
    final AssetEntity? entity = await CameraPicker.pickFromCamera(context,
        pickerConfig: const CameraPickerConfig(
            resolutionPreset: ResolutionPreset.medium));
    return entity;
  }

  /// 相册选择
  static Future<List<AssetEntity>> photo(
    BuildContext context, {
    int maxAssets = 1,
    List<AssetEntity>? assets,
  }) async {
    List<AssetEntity>? result = await AssetPicker.pickAssets(context,
        pickerConfig: AssetPickerConfig(
            maxAssets: maxAssets,
            selectedAssets: assets,
            requestType: RequestType.image));
    // result.first.file.whenComplete(() => {print(result.first)});
    return result!;
  }

  static getCameraPhoto(BuildContext context) async {
    if (await Permission.camera.request().isGranted) {
      final AssetEntity? photoCamera = await photoCameraAction(context);
      // ignore: unnecessary_null_comparison
      if (photoCamera == null) {
        Navigator.pop(context, []);
        return;
      }
      Navigator.pop(context, [photoCamera]);
    } else {
      EasyLoading.showInfo("请开启相机权限");
    }
  }

  static getPhotos(BuildContext context,
      {int maxAssets = 1,
      List<AssetEntity>? assets,
      RequestType type = RequestType.common}) async {
    if (await Permission.camera.request().isGranted) {
      List<AssetEntity>? photoCamera = await AssetPicker.pickAssets(context,
          pickerConfig: AssetPickerConfig(
              maxAssets: maxAssets, selectedAssets: assets, requestType: type));
      if (photoCamera == null) {
        Navigator.pop(context, assets);
        return;
      }
      Navigator.pop(context, photoCamera);
    } else {
      EasyLoading.showInfo("请开启相册访问权限");
    }
  }

  static Future showSelectedSheet(BuildContext context,
      {int maxAssets = 1,
      RequestType type = RequestType.image,
      List<AssetEntity> assets = const []}) async {
    var img = showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      // enableDrag: false,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            color: AppColor.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 3,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: AppColor.primaryText,
                ),
              ),
              ListTile(
                onTap: () => getCameraPhoto(context),
                title: const Text(
                  '拍照',
                  style: AppTextStyle.primary_14_w500,
                  textAlign: TextAlign.center,
                ),
              ),
              ListTile(
                onTap: () => getPhotos(context,
                    maxAssets: maxAssets, assets: assets, type: type),
                title: const Text(
                  '相册',
                  style: AppTextStyle.primary_14_w500,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
    return img;
  }
}

class ImageWrap extends StatefulWidget {
  final RequestType type;
  final List? data;
  final bool enabled;
  final double radius;
  final Function(List<AssetEntity>)? onHandlerImageChange;

  ImageWrap({
    super.key,
    this.onHandlerImageChange,
    this.type = RequestType.image,
    this.data,
    this.enabled = true,
    this.radius = 3,
  });

  @override
  State<ImageWrap> createState() => _ImageWrapState();
}

class _ImageWrapState extends State<ImageWrap> {
  final addAssetEntity = AssetEntity(id: '', height: 0, typeInt: -1, width: 0);
  List<AssetEntity> photoList = [];

  @override
  void initState() {
    super.initState();
    if (widget.data != null && widget.data!.length > 0) {
      photoList.addAll(widget.data!
          .asMap()
          .keys
          .map(
            (index) => AssetEntity(
              id: '',
              typeInt: -2,
              width: 0,
              height: 0,
              title: widget.data![index],
            ),
          )
          .toList());
    }
    photoList.add(addAssetEntity);
  }

  @override
  Widget build(BuildContext context) {
    final width = (context.width - 60) / 3;
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      children: photoList.asMap().keys.map((index) {
        if (photoList[index].typeInt == -1) {
          return Visibility(
            visible: widget.enabled,
            child: _selectedImgWidget(width),
          );
        }
        return SizedBox(
          width: width,
          height: width,
          child: Stack(
            children: [
              Positioned.fill(
                left: 5,
                right: 5,
                top: 5,
                bottom: 5,
                child: GestureDetector(
                  onTap: () async {
                    var list = [];
                    photoList.map((e) {
                      if (e.typeInt == -2) {
                        list.add(e.title);
                      } else if (e.typeInt != -1) {
                        list.add(e);
                      }
                    }).toList();
                    Utils.showViewBigPhoto(
                      index: index,
                      images: list,
                    );
                  },
                  child: SizedBox(
                    width: width,
                    height: width,
                    child: photoList[index].typeInt == -2
                        ? checkVideoFromURL(photoList[index].title ?? "")
                            ? VideoView(url: photoList[index].title ?? "")
                            : netImageCached(photoList[index].title ?? "",
                                radius: widget.radius)
                        : (photoList[index].type == AssetType.video)
                            ? VideoView(
                                url: "${photoList[index].relativePath}/${photoList[index].title}",
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(widget.radius),
                                  ),
                                ),
                                child: Image(
                                  image: AssetEntityImageProvider(
                                      photoList[index]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.enabled,
                child: Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        photoList.remove(photoList[index]);
                        if (photoList.length < 9 &&
                            photoList.last.typeInt != -1) {
                          photoList.add(addAssetEntity);
                        }
                        if (widget.onHandlerImageChange != null) {
                          List<AssetEntity> _list = [];
                          for (AssetEntity entity in photoList) {
                            if (entity.typeInt != -1) _list.add(entity);
                          }
                          widget.onHandlerImageChange!(_list);
                        }
                        setState(() {});
                      },
                      child: Image(
                        width: 20,
                        height: 20,
                        image: AssetImage("assets/images/pic_del.png"),
                      ),
                    )),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _selectedImgWidget(double width) {
    return GestureDetector(
      child: Container(
        width: width,
        height: width,
        padding: EdgeInsets.all(5),
        child: Image(
          image: AssetImage("assets/images/pic_add.png"),
        ),
      ),
      onTap: () {
        if (!widget.enabled) return;
        List<AssetEntity> _assetImg = [];
        List<AssetEntity> _images = [];
        for (AssetEntity element in photoList) {
          if (element.typeInt >= 0) {
            _assetImg.add(element);
          } else {
            _images.add(element);
          }
        }
        int _maxAssets = 0;
        if (_assetImg.length <= 9) {
          _maxAssets = 10 - _images.length;
        }
        SelectedImageUtil.showSelectedSheet(Get.context!,
                maxAssets: _maxAssets, assets: _assetImg, type: widget.type)
            .then((value) {
          List? _photoList = value;
          if (_photoList != null && _photoList.isNotEmpty) {
            for (AssetEntity photo in _photoList) {
              bool isHave = false;
              for (AssetEntity element in photoList) {
                if (photo.id.toString() == element.id.toString()) {
                  isHave = true;
                  break;
                }
              }
              if (!isHave) {
                photoList.insert(photoList.length - 1, photo);
              }
            }
            if (photoList.length < 9 && photoList.last.typeInt != -1) {
              photoList.add(addAssetEntity);
            }
            if (photoList.length > 9) {
              photoList.removeLast();
            }
            if (widget.onHandlerImageChange != null) {
              List<AssetEntity> _list = [];
              for (AssetEntity entity in photoList) {
                if (entity.typeInt != -1) _list.add(entity);
              }
              widget.onHandlerImageChange!(_list);
            }
            setState(() {});
          }
        });
      },
    );
  }
}

bool checkVideoFromURL(String url) {
  if (url.contains('mp4') ||
      url.contains('avi') ||
      url.contains('mkv') ||
      url.contains('video')) {
    return true;
  }
  return false;
}
