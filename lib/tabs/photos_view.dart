import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../properties/config.dart';

class PhotosView extends StatelessWidget {
  const PhotosView({Key? key}) : super(key: key);

  //final int countColumn = 2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: MasonryGridView(
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        children: chatImageList.map(
          (image) {
            return Padding(
              padding: const EdgeInsets.all(smallBorderRadius),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(smallBorderRadius),
                child: image,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

// вместо этих данных нужно принимать данные чата.
List<Image> chatImageList = [
  Image.asset('lib/images/74efb9686dd96a393184203bf6b6fd54.jpg'),
  Image.asset('lib/images/461d5a44-fe0f-4eff-b0a2-bb4e3258a324.jpg'),
  Image.asset('lib/images/1920x.webp'),
  Image.asset('lib/images/1920x (1).webp'),
  Image.asset('lib/images/1920x (2).webp'),
  Image.asset('lib/images/1920x (3).webp'),
  Image.asset('lib/images/88267fe876849887f8b553a6b1a296c8.jpg'),
  Image.asset(
      'lib/images/1644930022_23-fikiwiki-com-p-smeshnie-kartinki-smesharikov-27.png'),
  Image.asset('lib/images/74efb9686dd96a393184203bf6b6fd54.jpg'),
  Image.asset('lib/images/461d5a44-fe0f-4eff-b0a2-bb4e3258a324.jpg'),
  Image.asset('lib/images/1920x.webp'),
  Image.asset('lib/images/1920x (1).webp'),
  Image.asset('lib/images/1920x (2).webp'),
  Image.asset('lib/images/1920x (3).webp'),
  Image.asset('lib/images/88267fe876849887f8b553a6b1a296c8.jpg'),
  Image.asset(
      'lib/images/1644930022_23-fikiwiki-com-p-smeshnie-kartinki-smesharikov-27.png'),
];
