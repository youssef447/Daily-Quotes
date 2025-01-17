part of '../pages/random_quote_page.dart';

class RandomQuoteGeneratorButton extends StatelessWidget {
  final RandomCubit cubit;
  const RandomQuoteGeneratorButton({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BouncingSlideAnimation(
      child: DefaultButton(
        onClicked: () {
          cubit.getRandomQuote();
        },
        backgroundColor:
            AppColorsProvider.of(context).appColors.secondaryPrimary,
        raduis: 25,
        width: 200.w,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Get Random Quote',
              style: AppTextStyles.font14RegularABeeZee.copyWith(
                  color: AppColorsProvider.of(context).appColors.icon),
            ),
            SizedBox(
              width: 10.w,
            ),
            Icon(
              Icons.format_quote_sharp,
              color: AppColorsProvider.of(context).appColors.icon,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
