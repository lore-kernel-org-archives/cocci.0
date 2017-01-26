From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Jan 2017 14:17:58 +0100 (CET)
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <1485433691.14760.1.camel@sipsolutions.net>
References: <1485433691.14760.1.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1701261415040.3109@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 26 Jan 2017, Johannes Berg wrote:

> Hi,
>
> I've been playing with C99 initializers a bit, what I'm trying to do is
> replace them with explicit memset()/assignments.
>
> This works as expected:
>
> @@
> identifier x;
> type t;
> @@
> ?t x =
> -{0};
> +{};
>
>
> This actually removes the braces, but not only if they're empty, and it
> leaves the inner content there without braces, which won't even compile
> afterwards:
>
> @@
> identifier x;
> type t;
> @@
> ?t x
> - ={}
> ?;

I'm not sure what you are trying to do here.  Remove only the empty ones?

>
> e.g.:
>
> -	const u8 q[] = { 1, (const u8) '*', 0 };
> +	const u8 q[] 1, (const u8) '*', 0;
>
>
> I've also not managed to add any memset(&x, 0, sizeof(x)); in the same
> patch, especially since it should go after all other declarations.

Here you would want something like:

f(...) {
  when != S
+ memset(...);
  S1
  ...
}

S and S1 should be statements.  If there could be multiple memsets at the
beginning of a single function, use ++ instead of +.

julia

>
> Do you think this is possible at all?
>
> johannes
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
