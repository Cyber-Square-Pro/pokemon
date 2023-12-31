import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/modules/add_credit_card/widgets/decoration.dart';
import 'package:app/shared/providers/auth_state_provider.dart';
import 'package:app/shared/providers/credit_card_provider.dart';
import 'package:app/shared/repositories/credit_card_db.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/utils/validators.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/app_layout.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddCreditCardPage extends StatefulWidget {
  const AddCreditCardPage({super.key});

  @override
  State<AddCreditCardPage> createState() => _AddCreditCardPageState();
}

class _AddCreditCardPageState extends State<AddCreditCardPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
          key: const Key('card'),
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
                  'Add your card',
                  style: TextStyle(
                    fontSize: 20.sp,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              body: Form(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Consumer<CreditCardProvider>(
                        builder: (context, provider, _) => CreditCardWidget(
                          padding: 20.w,
                          obscureCardNumber: false,
                          chipColor: Colors.yellow.shade600,
                          cardNumber: provider.cardNumber,
                          expiryDate: provider.expiry,
                          cardHolderName: provider.cardHolderName,
                          labelCardHolder: 'Card Holder Name',
                          frontCardBorder: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.15),
                          ),
                          backCardBorder: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.15),
                          ),
                          isHolderNameVisible: true,
                          cvvCode: provider.cvv,
                          cardBgColor: AppTheme.getColors(context).primaryColor,
                          //
                          showBackView: provider.showBackView,
                          onCreditCardWidgetChange: (CreditCardBrand brand) {},
                        ),
                      ),
                      SizedBox(
                        height: 450.h,
                        child: CreditCardForm(
                          formKey: formKey, // Required
                          cardNumber: context
                              .read<CreditCardProvider>()
                              .cardNumber, // Required
                          expiryDate: context
                              .read<CreditCardProvider>()
                              .expiry, // Required
                          cardHolderName: context
                              .read<CreditCardProvider>()
                              .cardHolderName, // Required
                          cvvCode: context
                              .read<CreditCardProvider>()
                              .cvv, // Required
                          onCreditCardModelChange: (CreditCardModel data) {
                            context.read<CreditCardProvider>().hideSaveButton();
                            context.read<CreditCardProvider>().setCardDetails(
                                  cardHolderName: data.cardHolderName,
                                  cardNumber: data.cardNumber,
                                  cvvCode: data.cvvCode,
                                  expiryDate: data.expiryDate,
                                  showBackView: data.isCvvFocused,
                                );
                          }, // Required
                          obscureCvv: true,
                          obscureNumber: false,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          enableCvv: true,
                          cardNumberValidator: (String? cardNumber) =>
                              FormValidators.cardNumberValidator(cardNumber),
                          expiryDateValidator: (String? expiryDate) =>
                              FormValidators.expiryDateValidator(expiryDate),
                          cvvValidator: (String? cvv) =>
                              FormValidators.cvvValidator(cvv),
                          cardHolderValidator: (String? cardHolderName) =>
                              FormValidators.cardHolderValidator(
                                  cardHolderName),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          disableCardNumberAutoFillHints: false,
                          ////////////////////////////////////
                          onFormComplete: () {
                            if (formKey.currentState!.validate()) {
                              print('done');
                              context
                                  .read<CreditCardProvider>()
                                  .cardEntryCompleted();
                            }
                          },
                          /////////////////////////////////////
                          inputConfiguration: InputConfiguration(
                            cardNumberDecoration: InputDecoration(
                              border: CreditCardInputDecoration.inputDecoration(
                                  context),
                              labelText: 'Number',
                              hintText: 'XXXX XXXX XXXX XXXX',
                            ),
                            expiryDateDecoration: InputDecoration(
                              border: CreditCardInputDecoration.inputDecoration(
                                  context),
                              labelText: 'Expired Date',
                              hintText: 'XX/XX',
                            ),
                            cvvCodeDecoration: InputDecoration(
                              border: CreditCardInputDecoration.inputDecoration(
                                  context),
                              labelText: 'CVV',
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: InputDecoration(
                              border: CreditCardInputDecoration.inputDecoration(
                                  context),
                              labelText: 'Card Holder',
                            ),
                            cardNumberTextStyle: TextStyle(
                              fontSize: 16.sp,
                            ),
                            cardHolderTextStyle: TextStyle(
                              fontSize: 16.sp,
                            ),
                            expiryDateTextStyle: TextStyle(
                              fontSize: 16.sp,
                            ),
                            cvvCodeTextStyle: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      hSpace(15),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppLayouts.horizontalPagePadding),
                        width: ScreenUtil.defaultSize.width,
                        child: MainElevatedButton(
                          label: 'Save Card',
                          icon: Icons.credit_card_rounded,
                          onPressed: Provider.of<CreditCardProvider>(context)
                                  .saveButtonVisible
                              ? () async {
                                  final username =
                                      context.read<AuthProvider>().username;
                                  final provider =
                                      context.read<CreditCardProvider>();
                                  // save
                                  try {
                                    await context
                                        .read<CreditCardDatabase>()
                                        .saveCard(
                                          username,
                                          number: provider.cardNumber,
                                          holderName: provider.cardHolderName,
                                          expiryDate: provider.expiry,
                                          cvv: provider.cvv,
                                        )
                                        .then((_) {
                                      provider.clearAll();
                                      context
                                          .read<CreditCardDatabase>()
                                          .getSavedCardsOfUser(username);
                                      Navigator.pop(context);
                                    });
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
