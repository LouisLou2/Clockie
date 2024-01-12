import 'package:clockie/constant/location_collection.dart';
import 'package:clockie/constant/styles/app_styles.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';
import 'package:clockie/service/provider/resource_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../service/player.dart';

class ChooseRingtone extends StatelessWidget {
  const ChooseRingtone({super.key});

  @override
  Widget build(BuildContext context) {
    ResourceProvider rprov=PenthHouseProviders.resourceProvider!;
    return Scaffold(
      appBar: AppBar(
        title:const Text("Chose Ringtone",style: AppStyles.h1Style,)
      ),
      body:PopScope(
        canPop: true,
        onPopInvoked: (bool didPop){
          AudioPlayerManager.dispose(name: AudioPlayerManager.trailListenName);
        },
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 每行显示两个卡片
          ),
          itemCount: rprov.musicGenre.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: ()=>rprov.chooseRingtone(index),
              child:SizedBox(
                height: 300,
                width: 200,
                child:Stack(
                    alignment: Alignment.bottomCenter,
                    children:[
                      Selector<ResourceProvider,int>(
                        selector: (context,prov)=>prov.ringtoneIndex,
                        builder:(context,value,prov)=>Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.2),
                            border: Border.all(
                              color:value==index?Colors.blue:Colors.transparent,
                              width:6,
                            ),
                          ),
                          child:Padding(
                            padding:const EdgeInsets.all(3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:Image.asset(
                                LocationCollector.imagePrefix+rprov.musicGenre[index].item2, // 图片路径
                                width: 180,
                                height: 180, // 设置图片高度
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: Text(rprov.musicGenre[index].item1,style:AppStyles.cardLine),
                      ),
                    ]
                ),
              ),
            );
          },
        )
      ),
    );
  }
}

class CustomGridDelegate extends SliverGridDelegate {
  CustomGridDelegate({required this.dimension});
  final double dimension;
  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    // Determine how many squares we can fit per row.
    int count = constraints.crossAxisExtent ~/ dimension;
    if (count < 1) {
      count = 1; // Always fit at least one regardless.
    }
    final double squareDimension = constraints.crossAxisExtent / count;
    return CustomGridLayout(
      crossAxisCount: count,
      fullRowPeriod:
          3, // Number of rows per block (one of which is the full row).
      dimension: squareDimension,
    );
  }

  @override
  bool shouldRelayout(CustomGridDelegate oldDelegate) {
    return dimension != oldDelegate.dimension;
  }
}

class CustomGridLayout extends SliverGridLayout {
  const CustomGridLayout({
    required this.crossAxisCount,
    required this.dimension,
    required this.fullRowPeriod,
  })  : assert(crossAxisCount > 0),
        assert(fullRowPeriod > 1),
        loopLength = crossAxisCount * (fullRowPeriod - 1) + 1,
        loopHeight = fullRowPeriod * dimension;

  final int crossAxisCount;
  final double dimension;
  final int fullRowPeriod;

  // Computed values.
  final int loopLength;
  final double loopHeight;

  @override
  double computeMaxScrollOffset(int childCount) {
    if (childCount == 0 || dimension == 0) {
      return 0;
    }
    return (childCount ~/ loopLength) * loopHeight +
        ((childCount % loopLength) ~/ crossAxisCount) * dimension;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    final int loop = index ~/ loopLength;
    final int loopIndex = index % loopLength;
    if (loopIndex == loopLength - 1) {
      // Full width case.
      return SliverGridGeometry(
        scrollOffset: (loop + 1) * loopHeight - dimension, // "y"
        crossAxisOffset: 0, // "x"
        mainAxisExtent: dimension, // "height"
        crossAxisExtent: crossAxisCount * dimension, // "width"
      );
    }
    // Square case.
    final int rowIndex = loopIndex ~/ crossAxisCount;
    final int columnIndex = loopIndex % crossAxisCount;
    return SliverGridGeometry(
      scrollOffset: (loop * loopHeight) + (rowIndex * dimension), // "y"
      crossAxisOffset: columnIndex * dimension, // "x"
      mainAxisExtent: dimension, // "height"
      crossAxisExtent: dimension, // "width"
    );
  }

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    final int rows = scrollOffset ~/ dimension;
    final int loops = rows ~/ fullRowPeriod;
    final int extra = rows % fullRowPeriod;
    return loops * loopLength + extra * crossAxisCount;
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    // (See commentary above.)
    final int rows = scrollOffset ~/ dimension;
    final int loops = rows ~/ fullRowPeriod;
    final int extra = rows % fullRowPeriod;
    final int count = loops * loopLength + extra * crossAxisCount;
    if (extra == fullRowPeriod - 1) {
      return count;
    }
    return count + crossAxisCount - 1;
  }
}
