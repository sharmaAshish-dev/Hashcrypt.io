import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashcrypt/widgets/social.dart';
import 'package:layout/layout.dart';
import 'package:url_launcher/url_launcher.dart';

import '../values/colors.dart';
import '../values/sizes.dart';
import '../values/strings.dart';

List<SocialData> socialData = [
  SocialData(
    name: Strings.GITHUB,
    iconData: FontAwesomeIcons.github,
    url: Strings.GITHUB_URL,
  ),
  SocialData(
    name: Strings.LINKED_IN,
    iconData: FontAwesomeIcons.linkedin,
    url: Strings.LINKED_IN_URL,
  ),
  SocialData(
    name: Strings.MEDIUM,
    iconData: FontAwesomeIcons.medium,
    url: Strings.MEDIUM_URL,
  ),
];

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
    this.height,
    this.width,
    this.backgroundColor = AppColors.primaryColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Sizes.PADDING_16, Sizes.PADDING_16, Sizes.PADDING_16, Sizes.PADDING_8),
      width: width ?? context.layout.size.width,
      color: backgroundColor,
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return const SimpleFooterSm();
            } else {
              return const SimpleFooterLg();
            }
          },
        ),
      ),
    );
  }
}

class SimpleFooterSm extends StatelessWidget {
  const SimpleFooterSm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyText1?.copyWith(
      color: AppColors.accentColor,
      fontSize: Sizes.TEXT_SIZE_14,
    );
    return Column(
      children: [
        Socials(socialData: socialData),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.COPYRIGHT,
              style: style,
            ),
          ],
        ),
        const SizedBox(height: 4),
        const BuiltWithFlutter(),
      ],
    );
  }
}

class SimpleFooterLg extends StatelessWidget {
  const SimpleFooterLg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyText1?.copyWith(
      color: AppColors.accentColor,
      fontSize: Sizes.TEXT_SIZE_14,
    );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Socials(socialData: socialData),
          ],
        ),
        SizedBox(height: context.layout.value(xs: 20, sm: 20, md: 20, lg: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.COPYRIGHT,
              style: style,
            ),
          ],
        ),
        SizedBox(height: context.layout.value(xs: 8, sm: 8, md: 8, lg: 8)),
        const BuiltWithFlutter(),
      ],
    );
  }
}

class BuiltWithFlutter extends StatelessWidget {
  const BuiltWithFlutter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyText1?.copyWith(
      color: AppColors.accentColor,
      fontSize: Sizes.TEXT_SIZE_14,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          Strings.BUILT_WITH_FLUTTER,
          style: style,
        ),
        const FlutterLogo(size: 14),
        Text(
          " with ",
          style: style,
        ),
        const Icon(
          FontAwesomeIcons.solidHeart,
          size: 14,
          color: AppColors.errorRed,
        )
      ],
    );
  }
}
