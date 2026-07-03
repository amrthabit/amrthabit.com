// Born August 2001; month precision only, the exact day is not published
export function calcAge(now: Date = new Date()): number {
  return now.getFullYear() - 2001 - (now.getMonth() < 7 ? 1 : 0);
}
