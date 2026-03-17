import { z } from 'zod';

/**
 * 受け取り値（文字列／数値／Date）を Date オブジェクトに変換する前処理関数
 */
const coerceDate = () =>
  z.preprocess((arg) => {
    if (typeof arg === 'string' || typeof arg === 'number') {
      const d = new Date(arg);
      // 無効な日付文字列・数値なら元を返し、z.date() で弾く
      return Number.isNaN(d.getTime()) ? arg : d;
    }
    return arg;
  }, z.date());

export default coerceDate;
