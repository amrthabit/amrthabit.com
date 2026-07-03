// The Arabic article must be served as an Arabic RTL document, not under the
// template's lang="en". Runs at prerender time, so the built /ar HTML is correct.
export async function handle({ event, resolve }) {
  const isArabic = event.url.pathname === '/ar' || event.url.pathname.startsWith('/ar/');
  return resolve(event, {
    transformPageChunk: ({ html }) =>
      isArabic ? html.replace('<html lang="en"', '<html lang="ar" dir="rtl"') : html
  });
}
