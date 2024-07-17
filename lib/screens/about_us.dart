import 'package:flutter/material.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.5),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Terms & Conditions",
            style: getFontStyle(context),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/petit_taxi-04.png",
                  width: getScreenWidth(context) * 0.6,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Lorem ipsum dolor sit amet. Ut minus recusandae hic molestiae fugiat ut officiis tempore et harum tempore ea distinctio suscipit ut saepe enim et consequuntur quam. Ea ipsa numquam et fugiat voluptatem hic rerum dolore vel commodi doloribus ab nihil ipsam qui sapiente internos et consequatur laboriosam. Ut exercitationem veritatis ut numquam autem est tenetur soluta et omnis tempora et tempore soluta id sint eligendi. Eos rerum consequuntur nam animi culpa ex similique rerum qui quod omnis.",
                  style: getFontStyle(context).copyWith(fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
