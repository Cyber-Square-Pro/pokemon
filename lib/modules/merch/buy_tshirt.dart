import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/modules/add_credit_card/add_credit_card_page.dart';
import 'package:app/shared/providers/auth_state_provider.dart';
import 'package:app/shared/repositories/credit_card_db.dart';
import 'package:app/shared/repositories/payment_service.dart';
import 'package:app/shared/utils/page_transitions.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BuyShirtPage extends StatefulWidget {
  const BuyShirtPage({
    super.key,
    required this.credits,
    required this.colorName,
    required this.pokemonName,
  });

  final double credits;
  final String colorName;
  final String pokemonName;

  @override
  State<BuyShirtPage> createState() => _BuyShirtPageState();
}

class _BuyShirtPageState extends State<BuyShirtPage> {
  @override
  void initState() {
    super.initState();
    final username = context.read<AuthProvider>().username;
    context.read<CreditCardDatabase>().getSavedCardsOfUser(username);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        key: const Key('buy_shirt'),
        builder: (context) {
          return Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              systemOverlayStyle:
                  Theme.of(context).brightness == Brightness.dark
                      ? SystemUiOverlayStyle.light
                      : SystemUiOverlayStyle.dark,
              titleSpacing: 0,
              toolbarHeight: 60.h,
              title: Text(
                'Purchase this T-Shirt',
                style: TextStyle(
                  fontSize: 20.sp,
                  overflow: TextOverflow.fade,
                ),
              ),
              actions: [
                Icon(
                  CupertinoIcons.money_dollar_circle_fill,
                  size: 20.sp,
                ),
                wSpace(5),
                Text(widget.credits.toString()),
                wSpace(20),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppLayouts.horizontalPagePadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter Shipping Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomTextFormField(
                      prefixIcon: Icons.home,
                      labelText: '',
                      controller: TextEditingController(),
                      validator: (value) {
                        return null;
                      },
                      keyboardType: TextInputType.streetAddress,
                      isPassword: false,
                      maxLines: 5,
                      borderColor: Colors.blue,
                      errorBorderColor: Colors.red,
                      textColor: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  hSpace(25),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Payment Method',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      hSpace(10),
                      SizedBox(
                        width: double.maxFinite,
                        child: MainElevatedButton(
                          label: 'Pay with Card',
                          icon: CupertinoIcons.creditcard,
                          onPressed: () async {
                            // Navigator.push(
                            //   context,
                            //   TransitionPageRoute(
                            //     child: const AddCreditCardPage(),
                            //     transition: PageTransitions.slideLeft,
                            //     duration: Durations.long1,
                            //   ),
                            // );
                            await PaymentService.createPaymentIntent(250);
                          },
                        ),
                      ),
                    ],
                  ),
                  hSpace(5),
                  // Consumer<CreditCardDatabase>(
                  //   builder: (context, provider, _) {
                  //     if (provider.cards.isEmpty) {
                  //       return const Text('You have no saved cards');
                  //     }
                  //     return Expanded(
                  //       flex: 1,
                  //       child: ListView.separated(
                  //         separatorBuilder: (context, index) =>
                  //             const SizedBox(height: 15),
                  //         shrinkWrap: true,
                  //         itemCount: provider.cards.length,
                  //         itemBuilder: (context, index) {
                  //           final card = provider.cards[index];
                  //           return InkWell(
                  //             onTap: () {

                  //             },
                  //             borderRadius: BorderRadius.circular(15),
                  //             child: CreditCardWidget(
                  //               padding: 0,
                  //               cardNumber: card.number,
                  //               expiryDate: card.expiryDate,
                  //               cardHolderName: card.holderName,
                  //               cvvCode: card.cvv,
                  //               isHolderNameVisible: true,
                  //               showBackView: false,
                  //               isSwipeGestureEnabled: false,
                  //               onCreditCardWidgetChange: (_) {},
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),

                  hSpace(5),
                  SizedBox(
                    width: double.maxFinite,
                    child: MainElevatedButton(
                      label: 'Redeem with Credits',
                      icon: CupertinoIcons.money_dollar_circle_fill,
                      onPressed: () {},
                    ),
                  ),
                  hSpace(15),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
