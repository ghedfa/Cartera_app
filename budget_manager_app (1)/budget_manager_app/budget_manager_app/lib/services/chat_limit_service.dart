import 'package:shared_preferences/shared_preferences.dart';

class ChatLimitService {
  static const String _lastResetDateKey = 'last_reset_date';
  static const String _dailyUsageCountKey = 'daily_usage_count';
  static const int maxDailyPrompts = 10;

  final SharedPreferences _prefs;

  ChatLimitService(this._prefs);

  static Future<ChatLimitService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return ChatLimitService(prefs);
  }

  Future<bool> canSendMessage() async {
    final now = DateTime.now();
    final lastResetDate = DateTime.fromMillisecondsSinceEpoch(
      _prefs.getInt(_lastResetDateKey) ?? 0,
    );

    // Reset count if it's a new day
    if (!_isSameDay(lastResetDate, now)) {
      await _resetDailyCount(now);
      return true;
    }

    final dailyCount = _prefs.getInt(_dailyUsageCountKey) ?? 0;
    return dailyCount < maxDailyPrompts;
  }

  Future<void> incrementUsage() async {
    final count = _prefs.getInt(_dailyUsageCountKey) ?? 0;
    await _prefs.setInt(_dailyUsageCountKey, count + 1);
  }

  int getRemainingPrompts() {
    final dailyCount = _prefs.getInt(_dailyUsageCountKey) ?? 0;
    return maxDailyPrompts - dailyCount;
  }

  Future<void> _resetDailyCount(DateTime now) async {
    await _prefs.setInt(_lastResetDateKey, now.millisecondsSinceEpoch);
    await _prefs.setInt(_dailyUsageCountKey, 0);
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
