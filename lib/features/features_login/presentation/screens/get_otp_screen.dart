import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:recruitment_rest/features/features_home/presentation/screens/home_screen.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/utils/app_colors.dart';

class GetOTPScreen extends StatefulWidget {
  const GetOTPScreen({super.key});

  @override
  State<GetOTPScreen> createState() => _GetOTPScreenState();
}

class _GetOTPScreenState extends State<GetOTPScreen> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool isButtonVisible = false;
  int _start = 30;
  Timer? _timer;
  String? phoneNumber;

  void startTimer() {
    _start = 30;
    _timer?.cancel();
    setState(() {
      isButtonVisible = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          isButtonVisible = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              'ورود به حساب کاربری',
              style: TextStyle(
                fontFamily: 'IranSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(3.0), // Adjust the height as needed
          child: Container(
            color: darkWithTextColor, // Color of the separator line
            height: 3.0, // Thickness of the separator line
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding:
                EdgeInsets.only(top: 24.0, right: 16, left: 16, bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'کد تایید را وارد کنید',
                  style: TextStyle(
                    fontFamily: 'IranSans',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  overflow: TextOverflow.fade,
                  maxLines: 6,
                  softWrap: true,
                  textDirection: TextDirection.rtl,
                  'لطفا کد تایید اس ام اس شده را وارد کنید',
                  style: TextStyle(
                    fontFamily: 'IranSans',
                    fontSize: 12,
                    color: accountTextGreyColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 55,
                  child: PinCodeTextField(
                    controller: _otpController,
                    appContext: context,
                    keyboardType: TextInputType.number,
                    length: 5,
                    autoFocus: true,
                    textStyle: const TextStyle(fontFamily: 'IranSans'),
                    animationType: AnimationType.none,
                    animationDuration: Duration.zero,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(3),
                      fieldHeight: 55,
                      fieldWidth: 40,
                      activeColor: primaryColor,
                      selectedColor: primaryColor,
                      inactiveColor: primaryColor,
                    ),
                    cursorColor: primaryColor,
                    onChanged: (String value) {},
                    onCompleted: (String verificationCode) {
                      setState(() {
                        _otpController.text = verificationCode;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: RichText(
                    textDirection: TextDirection.rtl,
                    text: const TextSpan(
                      text: 'شرایط و قوانین استفاده',
                      style: TextStyle(
                        fontFamily: 'IranSans',
                        fontSize: 12,
                        color: redColor, // Red color for the specific text
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '. و سیاست نامه حریمه خصوصی اپلیکیشن\n را میپذیرم',
                          style: TextStyle(
                              fontFamily: 'IranSans',
                              fontSize: 12,
                              color:
                                  accountTextGreyColor // Original color for the rest of the text
                              ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            color: whiteColor,
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 16, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_otpController.text.length == 5) {
                          toastification.show(
                            showProgressBar: false,
                            // ignore: use_build_context_synchronously
                            context: context,
                            alignment: Alignment.bottomCenter,
                            closeOnClick: false,
                            direction: TextDirection.rtl,
                            pauseOnHover: true,
                            dragToClose: true,
                            applyBlurEffect: false,
                            type: ToastificationType.success,
                            title: const Text(
                              'ورود با موفقیت انجام شد',
                              style: TextStyle(
                                fontFamily: 'IranSans',
                                fontSize: 12,
                              ),
                            ),
                            style: ToastificationStyle.flatColored,
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ));
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 64, vertical: 12)),
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: const Text(
                        'ورود',
                        style: TextStyle(
                            fontFamily: 'IranSans',
                            color: whiteColor,
                            fontSize: 14),
                      ),
                    ),
                    const Spacer(), // Add some space between the button and the timer/text
                    isButtonVisible
                        ? ElevatedButton(
                            onPressed: () async {
                              _otpController.clear();
                              startTimer();
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 12)),
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: const Text(
                              'درخواست مجدد',
                              style: TextStyle(
                                  fontFamily: 'IranSans',
                                  color: whiteColor,
                                  fontSize: 14),
                            ),
                          )
                        : Text(
                            'درخواست مجدد $_start',
                            style: const TextStyle(
                                fontFamily: 'IranSans',
                                color: blackColor,
                                fontSize: 14),
                          ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
