From: keescook@chromium.org (Kees Cook)
Date: Wed, 23 Aug 2017 13:44:13 -0700
Subject: [Cocci] Matching function prototypes and casts
In-Reply-To: <alpine.DEB.2.20.1708231204260.3150@hadrien>
References: <CAGXu5jJAFEsBeRsSJPefu6wCDF+KdXr001ZbQWePERKFsgZsOw@mail.gmail.com>
 <alpine.DEB.2.20.1708231204260.3150@hadrien>
Message-ID: <CAGXu5jK1Kufzuf17iwwz20G=j5yMMFJtYpP4ika56kifKW2OOg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I think I'm getting closer. Here are some specific examples that don't
seem to work:

---match_callback.cocci---
virtual patch

@match_timer_function_usage
 depends on patch@
expression _E;
struct timer_list _e;
identifier _timer;
identifier _callback;
type _cast_func, _cast_data;
@@

(
-setup_timer(&_E->_timer at _e, _callback, _E);
|
-setup_timer(&_E->_timer at _e, &_callback, _E);
|
-setup_timer(&_E->_timer at _e, _callback, (_cast_data)_E);
|
-setup_timer(&_E->_timer at _e, &_callback, (_cast_data)_E);
|
-setup_timer(&_E->_timer at _e, (_cast_func)_callback, _E);
|
-setup_timer(&_E->_timer at _e, (_cast_func)&_callback, _E);
|
-setup_timer(&_E->_timer at _e, (_cast_func)_callback, (_cast_data)_E);
|
-setup_timer(&_E->_timer at _e, (_cast_func)&_callback, (_cast_data)_E);
|
-_E->_timer at _e.function = _callback;
|
-_E->_timer at _e.function = &_callback;
|
-_E->_timer at _e.function = (_cast_func)_callback;
|
-_E->_timer at _e.function = (_cast_func)&_callback;
)
---EOF---

Doesn't match drivers/ide/ide-probe.c which has:

setup_timer(&hwif->timer, &ide_timer_expiry, (unsigned long)hwif);

Even this doesn't:

(
-setup_timer(&_E->_timer at _e, &_callback, (_cast_data)_E);
)

Unless I remove the "@_e" part...? Am I using that wrong?

-Kees
