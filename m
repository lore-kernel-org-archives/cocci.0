From: keescook@chromium.org (Kees Cook)
Date: Wed, 23 Aug 2017 14:54:25 -0700
Subject: [Cocci] Matching function prototypes and casts
In-Reply-To: <alpine.DEB.2.20.1708232317360.2025@hadrien>
References: <CAGXu5jJAFEsBeRsSJPefu6wCDF+KdXr001ZbQWePERKFsgZsOw@mail.gmail.com>
 <alpine.DEB.2.20.1708231204260.3150@hadrien>
 <CAGXu5jK1Kufzuf17iwwz20G=j5yMMFJtYpP4ika56kifKW2OOg@mail.gmail.com>
 <alpine.DEB.2.20.1708232317360.2025@hadrien>
Message-ID: <CAGXu5j+NRPWX6KZPW-UqijzzCkXsLF-QB6WY_cL=QSB9s2fL-Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Aug 23, 2017 at 2:19 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Wed, 23 Aug 2017, Kees Cook wrote:
>
>> I think I'm getting closer. Here are some specific examples that don't
>> seem to work:
>>
>> ---match_callback.cocci---
>> virtual patch
>>
>> @match_timer_function_usage
>>  depends on patch@
>> expression _E;
>> struct timer_list _e;
>> identifier _timer;
>> identifier _callback;
>> type _cast_func, _cast_data;
>> @@
>>
>> (
>> -setup_timer(&_E->_timer at _e, _callback, _E);
>> |
>> -setup_timer(&_E->_timer at _e, &_callback, _E);
>> |
>> -setup_timer(&_E->_timer at _e, _callback, (_cast_data)_E);
>> |
>> -setup_timer(&_E->_timer at _e, &_callback, (_cast_data)_E);
>> |
>> -setup_timer(&_E->_timer at _e, (_cast_func)_callback, _E);
>> |
>> -setup_timer(&_E->_timer at _e, (_cast_func)&_callback, _E);
>> |
>> -setup_timer(&_E->_timer at _e, (_cast_func)_callback, (_cast_data)_E);
>> |
>> -setup_timer(&_E->_timer at _e, (_cast_func)&_callback, (_cast_data)_E);
>> |
>> -_E->_timer at _e.function = _callback;
>> |
>> -_E->_timer at _e.function = &_callback;
>> |
>> -_E->_timer at _e.function = (_cast_func)_callback;
>> |
>> -_E->_timer at _e.function = (_cast_func)&_callback;
>> )
>> ---EOF---
>>
>> Doesn't match drivers/ide/ide-probe.c which has:
>>
>> setup_timer(&hwif->timer, &ide_timer_expiry, (unsigned long)hwif);
>>
>> Even this doesn't:
>>
>> (
>> -setup_timer(&_E->_timer at _e, &_callback, (_cast_data)_E);
>> )
>>
>> Unless I remove the "@_e" part...? Am I using that wrong?
>
> For me it works.  Do you have the latest version of Coccinelle from
> github?  I used the option --all-includes.

Ah-ha! Thank you. :) I had --no-includes in my .cocci. :)

More insane corner cases:

I have this function:

static void
hfcmulti_dbusy_timer(struct hfc_multi *hc)
{
}

And this rule (which is using the working change_timer_function_usage
rule to find identifiers):

// callback(struct something *handle)
@change_callback_handle_arg
 depends on patch &&
            change_timer_function_usage &&
            !change_callback_handle_cast@
identifier change_timer_function_usage._callback;
identifier change_timer_function_usage._timer;
type _handletype;
identifier _handle;
@@

-static void _callback(_handletype *_handle)
+static void _callback(struct timer_list *t)
 {
+       _handletype *_handle = TIMER_CONTAINER(_handle, t, _timer);
        ...
 }

It correctly produces:

-static void
-hfcmulti_dbusy_timer(struct hfc_multi *hc)
+static void hfcmulti_dbusy_timer(struct timer_list *t)
 {
+       struct hfc_multi *hc = TIMER_CONTAINER(hc, t, timer);
 }

But since this was an empty function originally, I don't want to add
just the variable declaration. I tried various ()-like things, but
they didn't work:

-static void _callback(_handletype *_handle)
+static void _callback(struct timer_list *t)
 {
(
+       _handletype *_handle = TIMER_CONTAINER(_handle, t, _timer);
        ...
|
)
 }

etc...

-Kees

-- 
Kees Cook
Pixel Security
