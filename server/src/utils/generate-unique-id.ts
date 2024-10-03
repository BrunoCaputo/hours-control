export function generateUniqueNumericId(length = 6): number {
  const alphabet = "0123456789";

  let result = "";
  for (let i = 0; i < length; i++) {
    result += alphabet.charAt(Math.floor(Math.random() * alphabet.length));
  }

  return Number.parseInt(result, 10);
}
