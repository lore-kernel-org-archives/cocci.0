From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 28 Aug 2017 13:34:29 +0200 (CEST)
Subject: [Cocci] Automatic replacement of function declarations
In-Reply-To: <CAGXu5jKhUYEMLNvmStT-x-h4UKKQkuEpFVxn4H8PPVfecUnzqg@mail.gmail.com>
References: <CAGXu5jKhUYEMLNvmStT-x-h4UKKQkuEpFVxn4H8PPVfecUnzqg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1708281329410.3266@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 27 Aug 2017, Kees Cook wrote:

>  Hi,
>
> So, I noticed that if I replace argument types in a function,
> coccinelle will normally replace them in any forward declarations too.
> However, this:
>
> @change_callback
>  depends on patch@
> identifier _callback;
> type _origtype;
> identifier _origarg;
> type _handletype;
> identifier _handle;
> @@
>
>  void _callback(
> -_origtype _origarg
> +struct timer_list *t
>  )
>  {
>         ... when != _origarg
>         _handletype *_handle =
> -(_handletype *)_origarg;
> +TIMER_CONTAINER(_handle, t, timer);
>         ... when != _origarg
>  }
>
> run against drivers/net/wireless/ray_cs.c will fix join_net and
> start_net correctly:
>
> -static void join_net(u_long local);
> -static void start_net(u_long local);
> +static void join_net(struct timer_list *t);
> +static void start_net(struct timer_list *t);
>
> but misses  verify_dl_startup and authenticate_timeout.
>
> The difference is the latter have forward declarations without an argument name:
>
> static void authenticate_timeout(u_long);
> static void verify_dl_startup(u_long);

This was the first use of u_long in the file, so it was considering it to
be a K&R parameter name.  Now, by default, as soon as there is any non-K&R
parameter, the parser gives up on trying to find K&R parameters.
--force-kr causes it to keep looking for K&R parameters, and --prevent-kr
causes it to never look for K&R parameters.

I don't know to what extent people are still working on K&R code.  Another
option would be to have --prevent-kr as the default.

In any case, the example works now with no extra command line arguments.

julia
