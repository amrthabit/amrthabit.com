<script>
  import { calcAge } from '$lib';
  import Appearance from '$lib/components/Appearance.svelte';

  const age = calcAge();

  // client-side navigation from / must retarget the document language
  $effect(() => {
    const root = document.documentElement;
    root.lang = 'ar';
    root.dir = 'rtl';
  });
</script>

<svelte:head>
  <title>عمرو ثابت</title>
  <meta
    name="description"
    content="مطور برمجيات مقيم في أونتاريو بكندا، شغوف بالحلول النظيفة والأنيقة."
  />
  <link rel="alternate" hreflang="en" href="https://amrthabit.com/" />
  <link rel="alternate" hreflang="ar" href="https://amrthabit.com/ar" />
  <meta property="og:title" content="عمرو ثابت" />
  <meta property="og:description" content="مطور برمجيات مقيم في أونتاريو بكندا، شغوف بالحلول النظيفة والأنيقة." />
  <meta property="og:type" content="profile" />
  <meta property="og:url" content="https://amrthabit.com/ar" />
  <meta property="og:locale" content="ar_AR" />
</svelte:head>

<div class="chrome" dir="rtl" lang="ar">
  <header class="site-head">
    <a class="wordmark" href="/ar">
      <span class="wm">ويكيبيديا</span>
      <span class="tagline">الموسوعة الحرة</span>
    </a>
    <form
      class="search"
      action="https://ar.wikipedia.org/wiki/خاص:بحث"
      method="get"
      target="_blank"
      rel="noopener noreferrer"
    >
      <input type="search" name="search" placeholder="ابحث في ويكيبيديا" aria-label="ابحث في ويكيبيديا" />
      <button type="submit">بحث</button>
    </form>
    <Appearance
      labels={{
        button: 'المظهر',
        text: 'النص',
        color: 'اللون',
        width: 'العرض',
        small: 'صغير',
        standard: 'قياسي',
        large: 'كبير',
        auto: 'تلقائي',
        light: 'فاتح',
        dark: 'داكن',
        wide: 'عريض'
      }}
    />
  </header>

  <article class="page">
    <div class="langbar"><a href="/" hreflang="en" lang="en">English</a></div>
    <h1>عمرو ثابت</h1>
    <div class="site-sub">من ويكيبيديا، الموسوعة الحرة</div>

    <div class="hatnote">
      للنطاق، أنت هنا بالفعل. لا يُخلط بينه وبين آخرين يحملون اسم عمرو ثابت، ولهم أن يبنوا
      موسوعاتهم الخاصة.
    </div>

    <aside class="infobox">
      <div class="ib-title">عمرو ثابت</div>
      <table>
        <tbody>
          <tr>
            <th>وُلد</th>
            <td>أغسطس 2001 (العمر {age})<br /><a href="https://ar.wikipedia.org/wiki/اليمن" target="_blank" rel="noopener noreferrer">اليمن</a></td>
          </tr>
          <tr>
            <th>الإقامة</th>
            <td><a href="https://ar.wikipedia.org/wiki/هاميلتون_(أونتاريو)" target="_blank" rel="noopener noreferrer">هاميلتون، أونتاريو</a>، كندا</td>
          </tr>
          <tr><th>التعليم</th><td>مدرسة غلينديل الثانوية (2019)</td></tr>
          <tr>
            <th>الجامعة</th>
            <td><a href="https://ar.wikipedia.org/wiki/جامعة_ماكماستر" target="_blank" rel="noopener noreferrer">جامعة ماكماستر</a> (بكالوريوس، 2025)</td>
          </tr>
          <tr><th>المهنة</th><td>مهندس أنظمة بث</td></tr>
          <tr><th>صاحب العمل</th><td>إيفرتز مايكروسيستمز</td></tr>
          <tr><th>المنصب</th><td>مهندس مشاريع من الدرجة الثانية</td></tr>
          <tr><th>معروف بـ</th><td>التعاون والتعلم والبناء</td></tr>
          <tr><th>الموقع</th><td><a href="/ar">amrthabit.com</a></td></tr>
        </tbody>
      </table>
    </aside>

    <p class="lead">
      <b>عمرو ثابت</b> مطوّر برمجيات ومهندس أنظمة بث كندي، معروف بشغفه بالحلول النظيفة
      والأنيقة<sup class="cn">[بحاجة لمصدر]</sup>. درس علوم الحاسوب في
      <a href="https://ar.wikipedia.org/wiki/جامعة_ماكماستر" target="_blank" rel="noopener noreferrer">جامعة ماكماستر</a>
      ويعمل مهندس مشاريع من الدرجة الثانية في شركة إيفرتز مايكروسيستمز.<sup><a href="#ref1">[1]</a></sup>
    </p>
    <p>
      يمكن التواصل معه عبر <a href="mailto:contact@amrthabit.com">البريد الإلكتروني</a>، كما
      يمكن متابعته على <a href="https://github.com/amrthabit" target="_blank" rel="noopener noreferrer">غيت هاب</a>
      و<a href="https://linkedin.com/in/AmrThabit" target="_blank" rel="noopener noreferrer">لينكد إن</a>
      و<a href="https://instagram.com/thbbit" target="_blank" rel="noopener noreferrer">إنستغرام</a>.
    </p>

    <nav class="toc" aria-label="المحتويات">
      <div class="toc-h">المحتويات</div>
      <ol>
        <li><a href="#education">النشأة والتعليم</a></li>
        <li><a href="#career">المسيرة المهنية</a></li>
        <li><a href="#works">أعمال مختارة</a></li>
        <li><a href="#selfhosting">الاستضافة الذاتية</a></li>
        <li><a href="#references">مراجع</a></li>
      </ol>
    </nav>

    <h2 id="education">
      النشأة والتعليم
      <span class="edit">[<a href="mailto:contact@amrthabit.com?subject=%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B9%D8%AF%D9%8A%D9%84">عدّل</a>]</span>
    </h2>
    <p>
      وُلد ثابت في <a href="https://ar.wikipedia.org/wiki/اليمن" target="_blank" rel="noopener noreferrer">اليمن</a>
      في أغسطس 2001، ونشأ في <a href="https://ar.wikipedia.org/wiki/الرياض" target="_blank" rel="noopener noreferrer">الرياض</a>
      في <a href="https://ar.wikipedia.org/wiki/السعودية" target="_blank" rel="noopener noreferrer">المملكة العربية السعودية</a>،
      ثم انتقل إلى <a href="https://ar.wikipedia.org/wiki/هاميلتون_(أونتاريو)" target="_blank" rel="noopener noreferrer">هاميلتون</a>
      في أونتاريو بكندا، حيث أنهى دراسته الثانوية في مدرسة غلينديل الثانوية شرقي المدينة عام 2019.
    </p>
    <p>
      درس علوم الحاسوب في جامعة ماكماستر بين عامي 2020 و2025، وتخرّج بمعدل 3.82 وضمن لائحة شرف
      العميد.<sup><a href="#ref1">[1]</a></sup> وهناك، كما تشير السجلات، اكتسب عادة التعاون
      والتعلم والبناء، بهذا الترتيب تقريبًا.<sup class="cn">[بحاجة لمصدر]</sup>
    </p>

    <h2 id="career">
      المسيرة المهنية
      <span class="edit">[<a href="mailto:contact@amrthabit.com?subject=%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B9%D8%AF%D9%8A%D9%84">عدّل</a>]</span>
    </h2>
    <p>
      انضم ثابت إلى شركة إيفرتز مايكروسيستمز، المصنّعة لمعدات البث ومقرها برلينغتون في أونتاريو،
      متدرّبًا في هندسة المشاريع في يناير 2024. أمضى فترة التدريب في نشر خوادم البث عبر شبكة
      متعددة المواقع، وتنفيذ ترقيات للأنظمة والبرامج الثابتة عبر أكثر من ثلاثين محطة، وإرشاد
      متدرّبَين زميلين، وكتابة أكثر من اثني عشر دليلًا تقنيًا في الطريق. وفي أول تقييم له رُقّي
      إلى مهندس مشاريع من الدرجة الثانية بتوصية من رئيسه.<sup><a href="#ref1">[1]</a></sup>
    </p>
    <p>
      واعتبارًا من عام 2026، يتولى نشر وصيانة أنظمة البث وإدارة الأصول الإعلامية لكبرى شبكات
      البث الأمريكية. يملك خطوط إنتاج المحتوى، من ترجمة الجداول إلى استيراد الوسائط إلى مزامنة
      البيانات الوصفية، ويبني حولها أدواتها: نصوص استرداد آلية، وفحوص سلامة، وتدقيقات إعدادات،
      ولوحات خدمة ذاتية تتيح لفرق التشغيل الإجابة عن أسئلتها بنفسها.<sup><a href="#ref1">[1]</a></sup>
    </p>
    <p>
      ويأخذه العمل إلى استكشاف الأعطال عبر المنظومة كلها، من خوادم
      <a href="https://ar.wikipedia.org/wiki/لينكس" target="_blank" rel="noopener noreferrer">لينكس</a>
      إلى تنسيق الحاويات، مسترشدًا بمبدأ يراه بديهيًا: أي مشكلة لا يستطيع إصلاحها فلا بد أنها
      قادمة من المنبع.<sup class="cn">[بحاجة لمصدر]</sup> وهو ملمّ بنقل الفيديو عبر الشبكات
      وبمعيار SMPTE ST 2110، ولا سيما الجزء ST 2110-40 الذي يحمل البيانات المساعدة: الترجمات
      النصية، وإشارات الإعلانات، والرمز الزمني، ومعظم المشكلات المثيرة للاهتمام.
    </p>
    <p>
      وقبل عمله في مجال البث، شغّل الآلات في مخبز في أنكاستر يُنتج بيغل ومافن
      <a href="https://ar.wikipedia.org/wiki/تيم_هورتونز" target="_blank" rel="noopener noreferrer">تيم هورتونز</a>،
      وكان بعضها يُؤكل طازجًا من خط الإنتاج على سبيل ضبط الجودة،<sup class="cn">[بحاجة لمصدر]</sup>
      وعمل في مستودع لشركة أديداس في باريس (أونتاريو)، يشحن أحذية «ييزي» إلى أشخاص أرادوها
      بشدة. وكان أقرب ما وصلت إليه الوظيفتان من خطوط الوسائط هو المذياع، الذي لم
      يكن بالإمكان، لأسفه الشديد، إعادة تحزيمه أو إعادة ترميزه أو تمريره عبر
      <a href="https://ar.wikipedia.org/wiki/FFmpeg" target="_blank" rel="noopener noreferrer">FFmpeg</a>.<sup class="cn">[بحاجة لمصدر]</sup>
    </p>

    <h2 id="works">
      أعمال مختارة
      <span class="edit">[<a href="mailto:contact@amrthabit.com?subject=%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B9%D8%AF%D9%8A%D9%84">عدّل</a>]</span>
    </h2>
    <table class="wikitable">
      <thead>
        <tr><th>العمل</th><th>النوع</th><th>ملاحظات</th></tr>
      </thead>
      <tbody>
        <tr>
          <td dir="ltr">amrthabit.com</td>
          <td>موقع شخصي (Svelte)</td>
          <td>الصفحة التي تقرأها الآن</td>
        </tr>
        <tr>
          <td dir="ltr"><a href="https://ketype.com" target="_blank" rel="noopener noreferrer">ketype.com</a></td>
          <td>لعبة كتابة</td>
          <td>اكتب بسرعة</td>
        </tr>
        <tr>
          <td dir="ltr"><a href="https://wordle.amr.ooo" target="_blank" rel="noopener noreferrer">wordle.amr.ooo</a></td>
          <td>لعبة كلمات جماعية</td>
          <td>ووردل، لكن يمكنك أن تخسر أمام أصدقائك</td>
        </tr>
        <tr>
          <td dir="ltr"><a href="https://snake.amr.ooo" target="_blank" rel="noopener noreferrer">snake.amr.ooo</a></td>
          <td>لعبة أركيد جماعية</td>
          <td>الثعبان، حيث العقبة هي الآخرون</td>
        </tr>
        <tr>
          <td dir="ltr"><a href="https://outlier.amr.ooo" target="_blank" rel="noopener noreferrer">outlier.amr.ooo</a></td>
          <td>لعبة جماعية</td>
          <td>جِد المختلف</td>
        </tr>
        <tr>
          <td dir="ltr"><a href="https://tetris.amr.ooo" target="_blank" rel="noopener noreferrer">tetris.amr.ooo</a></td>
          <td>لعبة ألغاز جماعية</td>
          <td>قيد التجربة</td>
        </tr>
        <tr>
          <td dir="ltr"><a href="https://brockmsa.ca" target="_blank" rel="noopener noreferrer">brockmsa.ca</a></td>
          <td>موقع مجتمعي</td>
          <td>بُني لرابطة الطلبة المسلمين في جامعة بروك</td>
        </tr>
      </tbody>
    </table>

    <h2 id="selfhosting">
      الاستضافة الذاتية
      <span class="edit">[<a href="mailto:contact@amrthabit.com?subject=%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B9%D8%AF%D9%8A%D9%84">عدّل</a>]</span>
    </h2>
    <p>
      يستضيف ثابت كل ما يبنيه تقريبًا على أجهزته الخاصة في منزله، ويَعُدّ ذلك ميزة لا
      هواية.<sup class="cn">[بحاجة لمصدر]</sup> تُقدَّم ألعابه الجماعية من خادم منزلي منخفض
      الاستهلاك، ويؤكد ثابت أن المنظومة بأكملها أبسط مما تبدو.<sup class="cn">[بحاجة لمصدر]</sup>
    </p>
    <p>
      ومن المفترض أن يكون كل ما في هذه الصفحة متاحًا على الدوام. فإذا تعذّر تحميل إحدى الصفحات
      فتلك حادثة حقيقية؛ ويُشجَّع القراء على
      <a href="mailto:contact@amrthabit.com?subject=%D8%B4%D9%8A%D8%A1%20%D9%85%D8%A7%20%D9%85%D8%AA%D9%88%D9%82%D9%81">الإبلاغ عنها</a>،
      ليصبحوا في تلك اللحظة جزءًا من منظومة المراقبة.<sup class="cn">[بحاجة لمصدر]</sup>
    </p>

    <h2 id="references">
      مراجع
      <span class="edit">[<a href="mailto:contact@amrthabit.com?subject=%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B9%D8%AF%D9%8A%D9%84">عدّل</a>]</span>
    </h2>
    <ol class="refs">
      <li id="ref1">
        <span class="up">^</span> «عمرو ثابت، مهندس مشاريع من الدرجة الثانية».
        <a href="https://linkedin.com/in/AmrThabit" target="_blank" rel="noopener noreferrer"><i>لينكد إن</i></a>. اطُّلع عليه في 3 يوليو 2026.
      </li>
    </ol>

    <div class="stub">
      <span class="stub-icon" aria-hidden="true">&#9998;</span>
      هذه بذرة مقالة عن مطوّر برمجيات. يمكنك المساعدة
      <a href="mailto:contact@amrthabit.com">بمراسلته</a>.
    </div>

    <div class="catlinks">
      <b>تصنيفات:</b>
      <a href="https://ar.wikipedia.org/wiki/تصنيف:مواليد_2001" target="_blank" rel="noopener noreferrer">مواليد 2001</a>
      <span>|</span>
      <a href="https://ar.wikipedia.org/wiki/تصنيف:أشخاص_أحياء" target="_blank" rel="noopener noreferrer">أشخاص أحياء</a>
      <span>|</span>
      <a href="https://ar.wikipedia.org/wiki/تصنيف:خريجو_جامعة_ماكماستر" target="_blank" rel="noopener noreferrer">خريجو جامعة ماكماستر</a>
    </div>

    <footer class="page-foot">
      <p>آخر تعديل لهذه الصفحة كان في 3 يوليو 2026، على يد صاحبها، وهو ما يفسّر الكثير.</p>
      <p>
        هذا الموقع محاكاة ودّية لمقالة ويكيبيديا، ولا صلة له بويكيبيديا أو مؤسسة ويكيميديا،
        التي تُعدّ مراجعها أكثر دقة.
      </p>
      <p>
        <a href="mailto:contact@amrthabit.com">تواصل</a> &middot;
        <a href="https://github.com/amrthabit" target="_blank" rel="noopener noreferrer">غيت هاب</a> &middot;
        <a href="https://linkedin.com/in/AmrThabit" target="_blank" rel="noopener noreferrer">لينكد إن</a> &middot;
        <a href="https://instagram.com/thbbit" target="_blank" rel="noopener noreferrer">إنستغرام</a>
      </p>
    </footer>
  </article>
</div>

<style>
  /* Only per-language rules live here; the shared article skin is in styles.scss */
  .wordmark {
    line-height: 1.2;
  }
  .wm {
    display: block;
    font-size: 22px;
    font-weight: 700;
  }
  .tagline {
    display: block;
    font-size: 11px;
    color: var(--mut);
  }
  .wikitable td[dir='ltr'] {
    text-align: left;
  }
</style>
