import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment_rest/features/features_login/presentation/screens/get_otp_screen.dart';

import 'features/features_home/presentation/bloc/home_bloc.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize locator
  await setup();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<HomeBloc>(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GetOTPScreen(),
      ),
    ),
  );
}
