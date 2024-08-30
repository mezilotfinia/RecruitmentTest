import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../core/utils/app_colors.dart';
import '../bloc/api_status.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadApiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(24.0), // Adjust the radius as needed
              ),
              title: const Text(
                'خروج از حساب کاربری',
                style: TextStyle(
                  fontFamily: 'IranSans',
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.right,
              ),
              content: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: const Text(
                  'از حساب کاربری‌تون خارج می‌شید؟',
                  style: TextStyle(
                    fontFamily: 'IranSans',
                    color: accountTextGreyColor,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: <Widget>[
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2.5,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: const BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    child: const Text(
                      'بله، خارج می‌شم',
                      style: TextStyle(
                        fontFamily: 'IranSans',
                        color: primaryColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Exit the app
                      SystemNavigator.pop();
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    child: const Text(
                      'نه، نمی‌شم',
                      style: TextStyle(
                        fontFamily: 'IranSans',
                        color: whiteColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
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
                'صفحه دریافت اطلاعات',
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
        body: SingleChildScrollView(
          child: Column(children: [
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) {
                /// rebuild just when CwStatus Changed
                if (previous.apiStatus == current.apiStatus) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                Logger().e(state);
                if (state.apiStatus is ApiLoading) {
                  return SizedBox(
                      height: MediaQuery.sizeOf(context).height / 1.2,
                      width: MediaQuery.sizeOf(context).width,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ));
                }

                if (state.apiStatus is ApiCompleted) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.apiStatus is ApiCompleted)
                        ListView.builder(
                          shrinkWrap:
                              true, // Ensures the ListView only takes up as much space as needed
                          physics:
                              const NeverScrollableScrollPhysics(), // Prevents scrolling within the ListView itself
                          itemCount: (state.apiStatus as ApiCompleted)
                              .apiEntity
                              .length,
                          itemBuilder: (context, index) {
                            final element = (state.apiStatus as ApiCompleted)
                                .apiEntity[index];
                            // Customize the widget to display element items
                            return ListTile(
                              title: Text(
                                element.title ?? 'No title',
                                style: const TextStyle(color: primaryColor),
                              ),
                              subtitle: Text(element.body ?? 'No content'),
                              // Add more details or actions as needed
                            );
                          },
                        ),
                      // Add other UI elements if necessary
                    ],
                  );
                }

                if (state.apiStatus is ApiError) {
                  return const Center(
                    child: Text(
                      'error',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return Container();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
