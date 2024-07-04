import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ktalk/auth/providers/auth_providers.dart';
import 'package:ktalk/auth/screens/opt_screen.dart';
import 'package:ktalk/common/utils/global_navigator.dart';
import 'package:ktalk/common/utils/locale/generated/l10n.dart';
import 'package:ktalk/common/widgets/custom_buttom_widget.dart';

import '../../common/utils/logger.dart';

class PhoneNumberInputScreen extends ConsumerStatefulWidget {
  const PhoneNumberInputScreen({super.key});

  @override
  ConsumerState<PhoneNumberInputScreen> createState() =>
      _PhoneNumberInputScreenState();
}

class _PhoneNumberInputScreenState
    extends ConsumerState<PhoneNumberInputScreen> {
  final countryController = TextEditingController();
  final phoneCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final countryCode = Platform.localeName.split('_')[1];
    final country = CountryParser.parseCountryCode(countryCode);
    countryController.text = country.name;
    phoneCodeController.text = country.phoneCode;
  }

  @override
  void dispose() {
    countryController.dispose();
    phoneCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> sendOTP() async {
    final phoneCode = phoneCodeController.text;
    final phoneNumber = phoneNumberController.text;

    try {
      await ref.read(authProvider.notifier).sendOTP(
            phoneNumber: '+$phoneCode$phoneNumber',
          );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(S.current.loginScreenText1),
          ),
          body: Center(
            child: Column(
              children: [
                Text(
                  S.current.loginScreenText2,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    controller: countryController,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down)),
                    onTap: () => showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        countryController.text = country.name;
                        phoneCodeController.text = country.phoneCode;
                        logger.d(country.name);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: phoneCodeController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            isDense: true,
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 0,
                              minWidth: 0,
                            ),
                            prefixIcon: Text("+"),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Form(
                          key: globalKey,
                          child: TextFormField(
                            controller: phoneNumberController,
                            decoration: const InputDecoration(
                              isDense: true,
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return S.current.loginScreenText1;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomButtonWidget(
                    onPressed: () async {
                      try {
                        FocusScope.of(context).unfocus();
                        final form = globalKey.currentState;
                        if (form == null || !form.validate()) {
                          return;
                        }
                        await sendOTP();
                        Navigator.pushNamed(
                          context,
                          OTPScreen.routeName,
                        );
                      } catch (e, stackTrace) {
                        GlobalNavigator.showAlertDialog(text: e.toString());
                        logger.d(stackTrace);
                      }
                    },
                    text: S.current.next,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
