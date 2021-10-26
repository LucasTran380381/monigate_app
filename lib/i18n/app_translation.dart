import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'home_appbar_title': 'Hi, @name',
          'home_checking_status_false': 'Not have checking',
          'home_checking_status_true': 'Checking successful',
          'home_report_button_label': 'Report health',
          'bottom_navigation_home': 'Home',
          'bottom_navigation_attendance': 'Attendance',
          'menu_setting': 'Setting',
          'menu_notification': 'Notification',
          'menu_edit_user_info': 'Edit user information',
          'menu_tracking_contact': 'Tracking contact',
          'menu_vietnamese': 'Vietnamese',
          'tracking_appbar_title': 'Attendance',
          'tracking_contact': '@numOfContact contact',
          'tracking_contacts': '@numOfContact contacts',
          'tracking_this_week': 'This week',
          'tracking_last_week': 'Last week',
        },
        'vn_VN': {
          'home_appbar_title': 'Chào, @name',
          'home_checking_status_false': 'Chưa có thông tin checking',
          'home_checking_status_true': 'Checking thành công',
          'home_report_button_label': 'Báo cáo y tế',
          'bottom_navigation_home': 'Trang chủ',
          'bottom_navigation_attendance': 'Điểm danh',
          'menu_setting': 'Cài đặt',
          'menu_notification': 'Thông báo',
          'menu_edit_user_info': 'Chỉnh sửa thông tin',
          'menu_tracking_contact': 'Theo dõi tiếp xúc',
          'menu_vietnamese': 'Tiếng việt',
          'tracking_appbar_title': 'Điểm danh',
          'tracking_contact': '@numOfContact tiếp xúc',
          'tracking_contacts': '@numOfContact tiếp xúc',
          'tracking_this_week': 'Tuần này',
          'tracking_last_week': 'Tuần trước',
        }
      };
}
