import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/app_title.dart';
import 'package:education_app/components/appbar_iconbtn.dart';
import 'package:education_app/components/custom_image_slider.dart';
import 'package:education_app/constants.dart';
import 'package:education_app/screens/games/create-game.dart';
import 'package:flutter/material.dart';

const List<Map<String, String>> imageData = [
  {
    'label': 'Image 1',
    'url':
        'http://www.latestseotutorial.com/wp-content/uploads/2019/02/Nature-Images-2-300x200.jpg',
  },
  {
    'label': 'Image 2',
    'url':
        'https://s1.1zoom.me/prev2/568/Germany_Forests_Schwarzwald_Trees_Rays_of_light_567955_300x200.jpg',
  },
  {
    'label': 'Image 3',
    'url':
        'https://thumbs-prod.si-cdn.com/Tm8Jizcg87lbpwrBJtWXwETGlj4=/800x600/filters:no_upscale()/https://public-media.si-cdn.com/filer/b3/c7/b3c739f2-980a-40bd-979c-6ab14be52f45/42-65716299.jpg',
  },
  {
    'label': 'Image 4',
    'url':
        'http://s1.1zoom.net/prev2/565/Closeup_Mushrooms_nature_Amanita_564818_300x200.jpg',
  },
];

class BrowserCategories extends StatelessWidget {
  static const PAGEID = 'browse-categories';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppTitle(
                    text: 'Catalog',
                    color: Color(kPrimaryTitleColor),
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(CreateGame.PAGEID);
                    },
                    child: AppTitle(
                      text: 'Create Game',
                      color: Color(kPrimaryColor),
                      size: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                title: AppTitle(
                  text: 'Recently',
                  size: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(kPrimaryTitleColor),
                ),
                trailing: AppBarIconButton(
                  icon: Icons.arrow_forward_ios,
                  color: Color(kAccentColor),
                  onPressed: null,
                ),
              ),
            ),
            CustomImageSlider(
              images: imageData,
              imageHeight: 150,
              imageWidth: 200,
              sliderHeight: 200,
              isText: true,
              showBullets: false,
              viewportFrac: 200 / MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                title: AppTitle(
                  text: 'Featured',
                  size: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(kPrimaryTitleColor),
                ),
                trailing: AppBarIconButton(
                  icon: Icons.arrow_forward_ios,
                  color: Color(kAccentColor),
                  onPressed: null,
                ),
              ),
            ),
            CustomImageSlider(
              images: imageData,
              imageHeight: 100,
              imageWidth: 120,
              sliderHeight: 150,
              isText: false,
              showBullets: false,
              viewportFrac: 120 / MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                title: AppTitle(
                  text: 'Category',
                  size: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(kPrimaryTitleColor),
                ),
                trailing: AppBarIconButton(
                  icon: Icons.arrow_forward_ios,
                  color: Color(kAccentColor),
                  onPressed: null,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36),
              child: AppText(
                text: 'Math',
                color: Color(kPrimaryColor),
                size: 24,
              ),
            ),
            CustomImageSlider(
              images: imageData,
              imageHeight: 200,
              imageWidth: 200,
              sliderHeight: 250,
              isText: false,
              showBullets: false,
              viewportFrac: 200 / MediaQuery.of(context).size.width,
              handler: (i) => {
                // i is the index
                // print(i);
                Navigator.pushNamed(context, 'sub-categories')
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class ListImages extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: imageData.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Container(
//           height: 200,
//           width: 300,
//           child: Text(imageData[index]['label']),
//         );
//       },
//     );
//   }
// }
