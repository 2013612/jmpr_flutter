import 'point_setting.dart';
import 'setting.dart';

class History {
  PointSetting pointSetting;
  Setting setting;

  History({required this.pointSetting, required this.setting});

  @override
  String toString() {
    return '''
    {
      pointSetting: $pointSetting,
      setting: $setting,
    }
    ''';
  }
}
