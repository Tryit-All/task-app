import 'package:get/get.dart';

import '../modules/add_tim/bindings/add_tim_binding.dart';
import '../modules/add_tim/views/add_tim_view.dart';
import '../modules/all_team/bindings/all_team_binding.dart';
import '../modules/all_team/views/all_team_view.dart';
import '../modules/detail_tugas/bindings/detail_tugas_binding.dart';
import '../modules/detail_tugas/views/detail_tugas_view.dart';
import '../modules/edit_profil/bindings/edit_profil_binding.dart';
import '../modules/edit_profil/views/edit_profil_view.dart';
import '../modules/gantt_chart/bindings/gantt_chart_binding.dart';
import '../modules/gantt_chart/views/gantt_chart_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kalender/bindings/kalender_binding.dart';
import '../modules/kalender/views/kalender_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/navigation/bindings/navigation_binding.dart';
import '../modules/navigation/views/navigation_view.dart';
import '../modules/new_recurring_task/bindings/new_recurring_task_binding.dart';
import '../modules/new_recurring_task/views/new_recurring_task_view.dart';
import '../modules/new_task/bindings/new_task_binding.dart';
import '../modules/new_task/views/new_task_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/tugas/bindings/tugas_binding.dart';
import '../modules/tugas/views/tugas_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => NavigationView(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: _Paths.KALENDER,
      page: () => KalenderView(),
      binding: KalenderBinding(),
    ),
    GetPage(
      name: _Paths.TUGAS,
      page: () => TugasView(),
      binding: TugasBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_TUGAS,
      page: () => DetailTugasView(),
      binding: DetailTugasBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TIM,
      page: () => const AddTimView(),
      binding: AddTimBinding(),
    ),
    GetPage(
      name: _Paths.ALL_TEAM,
      page: () => const AllTeamView(),
      binding: AllTeamBinding(),
    ),
    GetPage(
      name: _Paths.NEW_TASK,
      page: () => NewTaskView(),
      binding: NewTaskBinding(),
    ),
    GetPage(
      name: _Paths.NEW_RECURRING_TASK,
      page: () => NewRecurringTaskView(),
      binding: NewRecurringTaskBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFIL,
      page: () => EditProfilView(),
      binding: EditProfilBinding(),
    ),
    GetPage(
      name: _Paths.GANTT_CHART,
      page: () => GanttChartView(),
      binding: GanttChartBinding(),
    ),
  ];
}
