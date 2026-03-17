/// Asia/Tokyo (UTC+9) 用の日時ユーティリティ。
/// すべての時刻表示を Asia で行うために使用する。
library;

/// UTC の [DateTime] を Asia/Tokyo の同じ瞬間に変換した [DateTime] を返す。
/// [d] がすでに local（isUtc == false）の場合はそのまま返す。
DateTime toAsiaTokyo(DateTime d) {
  const offset = Duration(hours: 9);
  return d.isUtc ? d.add(offset) : d;
}

/// [d]（JST として解釈した日時）を UTC の [DateTime] に変換する。
/// ピッカーで選んだ日時を「Asia/Tokyo の時刻」として API 用 UTC に変換するときに使う。
DateTime jstToUtc(DateTime d) {
  return DateTime.utc(
    d.year,
    d.month,
    d.day,
    d.hour,
    d.minute,
  ).subtract(const Duration(hours: 9));
}
