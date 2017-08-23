From: keescook@chromium.org (Kees Cook)
Date: Wed, 23 Aug 2017 11:57:12 -0700
Subject: [Cocci] [PATCH] coccinelle: Improve setup_timer.cocci matching
In-Reply-To: <alpine.DEB.2.20.1708231512190.3150@hadrien>
References: <20170822235400.GA92944@beast>
 <alpine.DEB.2.20.1708231512190.3150@hadrien>
Message-ID: <CAGXu5jLgzcO8D1N8mkjHygd2tfoptGMAd1vK5j-8uZ5_xY9Egg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Aug 23, 2017 at 6:13 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Tue, 22 Aug 2017, Kees Cook wrote:
>
>> This improves the patch mode of setup_timer.cocci. Several patterns were
>> missing:
>>  - assignments-before-init_timer() cases
>>  - limiting the .data case removal to the struct timer_list instance
>>  - handling calls by dereference (timer->field vs timer.field)
>>
>> Running this on the current kernel tree produces a large diff that I
>> would like to get applied as the first step in removing the .data
>> field from struct timer_list:
>>
>>  208 files changed, 367 insertions(+), 757 deletions(-)
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  scripts/coccinelle/api/setup_timer.cocci | 129 +++++++++++++++++++++++++------
>>  1 file changed, 105 insertions(+), 24 deletions(-)
>>
>> diff --git a/scripts/coccinelle/api/setup_timer.cocci b/scripts/coccinelle/api/setup_timer.cocci
>> index eb6bd9e4ab1a..bc6bd8f0b4bf 100644
>> --- a/scripts/coccinelle/api/setup_timer.cocci
>> +++ b/scripts/coccinelle/api/setup_timer.cocci
>> @@ -2,6 +2,7 @@
>>  /// and data fields
>>  // Confidence: High
>>  // Copyright: (C) 2016 Vaishali Thakkar, Oracle. GPLv2
>> +// Copyright: (C) 2017 Kees Cook, Google. GPLv2
>>  // Options: --no-includes --include-headers
>>  // Keywords: init_timer, setup_timer
>>
>> @@ -10,60 +11,123 @@ virtual context
>>  virtual org
>>  virtual report
>>
>> +// Match the common cases first to avoid Coccinelle parsing loops with
>> +// "... when" clauses.
>> +
>>  @match_immediate_function_data_after_init_timer
>>  depends on patch && !context && !org && !report@
>>  expression e, func, da;
>>  @@
>>
>> --init_timer (&e);
>> -+setup_timer (&e, func, da);
>> +-init_timer
>> ++setup_timer
>> + ( \(&e\|e\)
>> ++, func, da
>> + );
>> +(
>> +-\(e.function\|e->function\) = func;
>> +-\(e.data\|e->data\) = da;
>> +|
>> +-\(e.function\|e->function\) = func;
>> +-\(e.data\|e->data\) = da;
>
> Same thing twice; I think you want to invert the last two lines.
>
>> +)
>> +
>> + at match_immediate_function_data_before_init_timer
>> +depends on patch && !context && !org && !report@
>> +expression e, func, da;
>> +@@
>>
>>  (
>> +-\(e.function\|e->function\) = func;
>> +-\(e.data\|e->data\) = da;
>> +|
>> +-\(e.function\|e->function\) = func;
>> +-\(e.data\|e->data\) = da;
>
> Same as in the previous case.

Oops, thanks! AIUI, missing these cases must makes runtime slower.
I'll fix it up and resend.

-Kees

-- 
Kees Cook
Pixel Security
