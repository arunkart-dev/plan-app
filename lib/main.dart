import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_plan/services/local_notifications.dart';
import 'package:make_plan/services/timezone_service.dart';
import 'package:make_plan/viewmodel/auth_provider.dart';
import 'package:make_plan/viewmodel/bottom_nav_provider.dart';
import 'package:make_plan/viewmodel/planner_provider.dart';
import 'package:make_plan/viewmodel/profile_provider.dart';
import 'package:make_plan/viewmodel/progress_provider.dart';
import 'package:make_plan/viewmodel/roadmap_chat_provider.dart';
import 'package:make_plan/viewmodel/roadmap_provider.dart';
import 'package:make_plan/viewmodel/search_provider.dart';
import 'package:make_plan/viewmodel/todo_provider.dart';
import 'package:make_plan/views/signup_view.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🌍 Timezone
  TimezoneService.init();

  // 🔔 Notifications (NO Supabase usage here)
  await NotificationService.init();

  // 🔐 Notification permission
  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  await plugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  // 🔐 SUPABASE MUST BE INITIALIZED FIRST
  await Supabase.initialize(
    url: 'https://krdksommzmbfbemzgcab.supabase.co',
    anonKey: 'sb_publishable_cp_R4L83U95bnMC9Ut-aRA_dvzgXRNI',
  );

  // 🔔 START REMINDERS ONLY AFTER SUPABASE INIT
  await NotificationService.startHourlyReminder();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoProvider>(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => PlannerProvider()),
        ChangeNotifierProvider(create: (_) => RoadmapProvider()),
        ChangeNotifierProvider(create: (_) => RoadmapChatProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final p = ProfileProvider();
            p.init(); // 🔥 REQUIRED
            return p;
          },
        ),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Make Plan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        home: SignupView(),
      ),
    );
  }
}
