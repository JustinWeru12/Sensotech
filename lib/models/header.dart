import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sensotech/models/spacers.dart';
import 'package:sensotech/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:sensotech/models/spinner.dart';

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String title;
  final String subTitle;
  final String image;
  final bool refreshing;
  final Function() refresh;
  final Color color;

  const CustomSliverAppBarDelegate({
    required this.title,
    required this.subTitle,
    required this.expandedHeight,
    required this.image,
    required this.refreshing,
    required this.color,
    required this.refresh,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    const size = 100;
    final top = expandedHeight - shrinkOffset - size;
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          // overflow: Overflow.visible,
          children: [
            buildBackground(shrinkOffset),
            buildAppbarOverlay(shrinkOffset),
            buildAppBar(shrinkOffset, context),
            Positioned(
              top: top,
              left: 10,
              right: 10,
              child: Opacity(
                opacity: disappear(shrinkOffset) * disappear(shrinkOffset),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    smallHorizontalSpacer,
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: kAppBarstyle.copyWith(
                                    color: kBackgroundColor, fontSize: 24),
                              ),
                              Text(
                                subTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: kregularTextstyle.copyWith(
                                    color: kBackgroundColor, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    smallHorizontalSpacer,
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - (shrinkOffset / expandedHeight);

  Widget buildAppBar(double shrinkOffset, context) => Opacity(
        opacity: appear(shrinkOffset) < 0.7
            ? appear(shrinkOffset) * 0.5
            : appear(shrinkOffset),
        child: Center(
          child: SizedBox(
            height: expandedHeight,
            child: AppBar(
              leading: BackButton(
                color: kBackgroundColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(color: color),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title,
                  style: kAppBarstyle.copyWith(color: kBackgroundColor),
                ),
              ),
              centerTitle: true,
              actions: [action()],
            ),
          ),
        ),
      );

  Widget buildBackground(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Container(
          color: color,
          child: Opacity(
            opacity: 0.1,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );

  Widget buildAppbarOverlay(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(
            color: kBackgroundColor,
            onPressed: () {},
          ),
          actions: [action()],
        ),
      );

  Widget action() => !refreshing
      ? InkWell(
          onTap: () => refresh(),
          child: SizedBox(
            height: 52,
            width: 52,
            child: Center(
              child: Icon(
                PhosphorIconsBold.arrowClockwise,
                color: kBackgroundColor,
                size: 20,
              ),
            ),
          ),
        )
      : ProgressLoader(color: kBackgroundColor);

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
