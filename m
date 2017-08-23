From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 23 Aug 2017 12:13:21 +0200 (CEST)
Subject: [Cocci] Matching function prototypes and casts
In-Reply-To: <CAGXu5jJAFEsBeRsSJPefu6wCDF+KdXr001ZbQWePERKFsgZsOw@mail.gmail.com>
References: <CAGXu5jJAFEsBeRsSJPefu6wCDF+KdXr001ZbQWePERKFsgZsOw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1708231204260.3150@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 22 Aug 2017, Kees Cook wrote:

> Hi,
>
> I'm working on a large type conversion for struct timer_list, and
> it'll require changing all of the callback prototypes and changing
> logic at their start. For example, if I start with this:
>
>
> void primary_callback(unsigned long arg);
> void alternate_callback(struct some_handle *handle);
> ...
>
> void primary_callback(unsigned long arg)
> {
>     struct some_handle *handle = (struct some_handle *)arg;
> ...
> }
>
> void alternate_callback(struct some_handle *handle)
> {
> ...
> }
>
> ...
> setup_timer(&ptr->timer_field, some_callback, (unsigned long)ptr);
> ...
> ptr->timer_field.function = (void (*)(unsigned long)alternate_callback;
>
>
> I'd like to end up with:
>
>
> void primary_callback(struct timer_list *t);
> void alternate_callback(struct timer_list *t);
> ...
>
> void primary_callback(struct timer_list *t)
> {
>     struct some_handle *handle = container_of(t, struct some_handle,
> timer_field);
> ...
> }
>
> void alternate_callback(struct timer_list *t)
> {
>     struct some_handle *handle = container_of(t, struct some_handle,
> timer_field);
> ...
> }
>
> ...
> setup_time(&ptr->timer_field, some_callback, &ptr->timer_field);
> ...
> ptr->timer_field.function = alternate_callback;
>
>
> I'm having trouble matching the callback arg type, and I'm having
> trouble identifying the callbacks. I think I can do things like this,
> but it's not quite working:
>
> @match_setup_timer@
> identifier _p;
> struct timer_list _timer_field;
> identifier _callback;
> type _cast;
> @@
>
> (
>  setup_timer(&_p->_timer_field, _setup_callback, _p);
> |
>  setup_timer(&_p->_timer_field, (_cast)_setup_callback, _p);

The code has setup_callback but the metavariable is just callback.

> )
>
> @match_function_assignment@
> identifier _p;
> struct timer_list _timer_field;

This is declaring a metavariable that matches an expression of type struct
timer_list.  You are trying to match a field name, so you just want an
identifier metavariable.  If you want to be sure that _p->_timer_field has
type struct timer_list, then you can make an expression metavariable of
that type, ie:

struct timer_list e;

and then put @e after _timer_field.  But maybe you don't even need
_p->_timer_field and can just use e?

> identifier _callback;
> type _cast;
> @@
>
> (
>  _p->_timer_field.function = _callback;
> |
>  _p->_timer_field.function = (_cast)_callback;
> )
>
> // callback(unsigned long arg)
> @change_callback_handle_cast
> depends on match_setup_timer || match_function_assignment@
> identifier ???._callback;
> struct timer_list ???._timer_field;
> type _origtype;
> identifier _origarg;
> type _handletype;
> identifier _handle;
> @@
>
> -void _callback(_origtype _origarg)
> +void _callback(struct timer_list *t)
>  {
> -    _handletype *_handle = (_handletype *)_origarg;
> +    _handletype *_handle = container_of(t, _handletype, _timer_field);
>
> // callback(struct something *handle)
> @change_callback_handle_arg
> depends on match_setup_timer || match_function_assignment@
> identifier ???._callback;

Is the concern here that you want to get the metavariable binding from two
different rules?

It might be possible to just have two metavariables inherited from
different places, and then have a disjunction in the function name
position.

Alternatively, maybe those two rules could be merged.

julia

> struct timer_list ???._timer_field;
> type _handletype;
> identifier _handle;
> @@
>
> -void _callback(_handletype *_handle)
> +void _callback(struct timer_list *t)
>  {
> +    _origtype *_origarg = container_of(t, _origtype, _timer_field);
>
>
> Namely, I don't seem to be matching casts or function arg types, and I
> sometimes seem to be missing cases of struct timer_list. Also, I can't
> figure out how to have the change_callback_* rules depend on either
> matching match_setup_timer or match_function_assignment and having
> access to the matched fields...
>
> What would be the best way to deal with these?
>
> Thanks!
>
> -Kees
>
> --
> Kees Cook
> Pixel Security
>
