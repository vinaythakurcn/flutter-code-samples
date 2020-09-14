import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

const List<Map<String, String>> imageData = [
  {
    'label': 'Math Order of Operations',
    'url':
        'http://www.latestseotutorial.com/wp-content/uploads/2019/02/Nature-Images-2-300x200.jpg',
  },
  {
    'label': 'Math Probability Back-to-School',
    'url':
        'https://s1.1zoom.me/prev2/568/Germany_Forests_Schwarzwald_Trees_Rays_of_light_567955_300x200.jpg',
  },
  {
    'label': 'Math Order of Operations',
    'url':
        'https://thumbs-prod.si-cdn.com/Tm8Jizcg87lbpwrBJtWXwETGlj4=/800x600/filters:no_upscale()/https://public-media.si-cdn.com/filer/b3/c7/b3c739f2-980a-40bd-979c-6ab14be52f45/42-65716299.jpg',
  },
  {
    'label': 'Math Probability Back-to-School',
    'url':
        'http://s1.1zoom.net/prev2/565/Closeup_Mushrooms_nature_Amanita_564818_300x200.jpg',
  },
];

class SubCategories extends StatelessWidget {
  static const PAGEID = 'sub-categories';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kAppBackgroundColor),
        leading: Icon(
          Icons.keyboard_arrow_left,
          color: Color(kAccentColor),
          size: 30,
        ),
      ),
      body: SafeArea(
        child: CategorisList(),
      ),
    );
  }
}

class CategorisList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageData.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(          
          // height: 200,
          // width: 300,
          margin: EdgeInsets.only(left: 12, right: 12, top: 18, bottom: 5),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details-credit'),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: GestureDetector(
                    onTap: null,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(8.0),
                      child: Image.network(
                        imageData[index]['url'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 12.0,
                    left: 20,
                  ),
                  child: AppText(
                    text: imageData[index]['label'],
                    color: Color(kPrimaryColor),
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
