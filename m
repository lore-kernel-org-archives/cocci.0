From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 23 Aug 2017 23:19:43 +0200 (CEST)
Subject: [Cocci] Matching function prototypes and casts
In-Reply-To: <CAGXu5jK1Kufzuf17iwwz20G=j5yMMFJtYpP4ika56kifKW2OOg@mail.gmail.com>
References: <CAGXu5jJAFEsBeRsSJPefu6wCDF+KdXr001ZbQWePERKFsgZsOw@mail.gmail.com>
 <alpine.DEB.2.20.1708231204260.3150@hadrien>
 <CAGXu5jK1Kufzuf17iwwz20G=j5yMMFJtYpP4ika56kifKW2OOg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1708232317360.2025@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 23 Aug 2017, Kees Cook wrote:

> I think I'm getting closer. Here are some specific examples that don't
> seem to work:
>
> ---match_callback.cocci---
> virtual patch
>
> @match_timer_function_usage
>  depends on patch@
> expression _E;
> struct timer_list _e;
> identifier _timer;
> identifier _callback;
> type _cast_func, _cast_data;
> @@
>
> (
> -setup_timer(&_E->_timer at _e, _callback, _E);
> |
> -setup_timer(&_E->_timer at _e, &_callback, _E);
> |
> -setup_timer(&_E->_timer at _e, _callback, (_cast_data)_E);
> |
> -setup_timer(&_E->_timer at _e, &_callback, (_cast_data)_E);
> |
> -setup_timer(&_E->_timer at _e, (_cast_func)_callback, _E);
> |
> -setup_timer(&_E->_timer at _e, (_cast_func)&_callback, _E);
> |
> -setup_timer(&_E->_timer at _e, (_cast_func)_callback, (_cast_data)_E);
> |
> -setup_timer(&_E->_timer at _e, (_cast_func)&_callback, (_cast_data)_E);
> |
> -_E->_timer at _e.function = _callback;
> |
> -_E->_timer at _e.function = &_callback;
> |
> -_E->_timer at _e.function = (_cast_func)_callback;
> |
> -_E->_timer at _e.function = (_cast_func)&_callback;
> )
> ---EOF---
>
> Doesn't match drivers/ide/ide-probe.c which has:
>
> setup_timer(&hwif->timer, &ide_timer_expiry, (unsigned long)hwif);
>
> Even this doesn't:
>
> (
> -setup_timer(&_E->_timer at _e, &_callback, (_cast_data)_E);
> )
>
> Unless I remove the "@_e" part...? Am I using that wrong?

For me it works.  Do you have the latest version of Coccinelle from
github?  I used the option --all-includes.

julia
