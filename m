From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 24 Aug 2017 07:26:58 +0200 (CEST)
Subject: [Cocci] Matching function prototypes and casts
In-Reply-To: <CAGXu5j+NRPWX6KZPW-UqijzzCkXsLF-QB6WY_cL=QSB9s2fL-Q@mail.gmail.com>
References: <CAGXu5jJAFEsBeRsSJPefu6wCDF+KdXr001ZbQWePERKFsgZsOw@mail.gmail.com>
 <alpine.DEB.2.20.1708231204260.3150@hadrien>
 <CAGXu5jK1Kufzuf17iwwz20G=j5yMMFJtYpP4ika56kifKW2OOg@mail.gmail.com>
 <alpine.DEB.2.20.1708232317360.2025@hadrien>
 <CAGXu5j+NRPWX6KZPW-UqijzzCkXsLF-QB6WY_cL=QSB9s2fL-Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1708240719010.2149@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > For me it works.  Do you have the latest version of Coccinelle from
> > github?  I used the option --all-includes.
>
> Ah-ha! Thank you. :) I had --no-includes in my .cocci. :)

>From a performance point of view, you might want to do what you can with
--no-includes first.  It will then only be doing the --all-includes on
files that still contain init_timer.

> More insane corner cases:
>
> I have this function:
>
> static void
> hfcmulti_dbusy_timer(struct hfc_multi *hc)
> {
> }
>
> And this rule (which is using the working change_timer_function_usage
> rule to find identifiers):
>
> // callback(struct something *handle)
> @change_callback_handle_arg
>  depends on patch &&
>             change_timer_function_usage &&
>             !change_callback_handle_cast@
> identifier change_timer_function_usage._callback;
> identifier change_timer_function_usage._timer;
> type _handletype;
> identifier _handle;
> @@
>
> -static void _callback(_handletype *_handle)
> +static void _callback(struct timer_list *t)
>  {
> +       _handletype *_handle = TIMER_CONTAINER(_handle, t, _timer);
>         ...
>  }
>
> It correctly produces:
>
> -static void
> -hfcmulti_dbusy_timer(struct hfc_multi *hc)
> +static void hfcmulti_dbusy_timer(struct timer_list *t)
>  {
> +       struct hfc_multi *hc = TIMER_CONTAINER(hc, t, timer);
>  }
>
> But since this was an empty function originally, I don't want to add
> just the variable declaration. I tried various ()-like things, but
> they didn't work:
>
> -static void _callback(_handletype *_handle)
> +static void _callback(struct timer_list *t)
>  {
> (
> +       _handletype *_handle = TIMER_CONTAINER(_handle, t, _timer);
>         ...
> |
> )
>  }
>
> etc...

Really what you care about is whether _handle was used.  I think that you
will need two rules:

@exists@
@@

-static void _callback(_handletype *_handle)
+static void _callback(struct timer_list *t) {
+  _handletype *_handle = TIMER_CONTAINER(_handle, t, _timer);
  ...
  _handle
  ... when any
}

and

-static void _callback(_handletype *_handle)
+static void _callback(struct timer_list *t) { ...
}

to clean up the rest.

julia
