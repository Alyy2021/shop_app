import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter/modules/shop_app/logain/shop_logain.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
   @required this.image,
   @required this.title,
   @required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

List<BoardingModel> boarding = [
  BoardingModel(
    image: 'assets/images/onboarding.jpeg',
    title: 'Nutrition profile is your first step ',
    body: 'On Home page'
  ),
  BoardingModel(
    image: 'assets/images/onboarding.jpeg',
    title: 'We care your medical journey',
    body: 'Profile is your second step '
  ),
  BoardingModel(
    image: 'assets/images/onboarding.jpeg',
    title: 'Months achievements is the all happiness news  ',
    body: 'Get in to see your achievement '
  ),
];

bool isLast = false;

void submit () {

CacheHelper.saveData(
    key: 'onBoarding',
    value: true,
   ).then((value)
{
  if (value){
    navigateAndFinish(
        context,
        ShopLoginScreen()
    );
  }
}
);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: submit,
              text: 'SKIP'
          ),


        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index){
                  if (index == boarding.length-1)
                    {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      dotWidth: 5,
                      expansionFactor: 4,
                      spacing: 5,
                    ),
                    count: boarding.length
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if (isLast){
                    submit();
                  }else
                    {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 700,
                        ), curve: Curves.decelerate,);
                    }

                },
                child: Icon(
                  Icons.arrow_forward_ios
                ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget  buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage('${model.image}')),
      ),
      //SizedBox(height: 30,),
      Text('${model.title}',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 5),
      Text('${model.body}',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
