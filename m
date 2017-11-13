From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 13 Nov 2017 13:32:31 +0900
Subject: [Cocci] [PATCH] coccinelle: orplus: reodganize to improve
	performance
In-Reply-To: <alpine.DEB.2.20.1711121935400.10412@hadrien>
References: <alpine.DEB.2.20.1711121935400.10412@hadrien>
Message-ID: <CAK7LNAS06r9B-ZTA0K0LrH8g64ibft-Kzt3A6y0tJqW7_HHh2w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,


2017-11-13 3:41 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
> Adding two #define constants is less common than performing & and |
> operations on them, so put the addition first to reduce the set of cases
> that have to be considered in detail.  At the same time, add & and |
> patterns for both arguments of +, to account for commutativity and obtain
> more results.
>
> Running time is divided by 3 when applying this to the while kernel on my
> laptop with an Intel i5-6200U CPU.
>

Nit:

Missing Signed-off-by.


>
> diff --git a/scripts/coccinelle/misc/orplus.cocci b/scripts/coccinelle/misc/orplus.cocci
> index 81fabf3..08de5be 100644
> --- a/scripts/coccinelle/misc/orplus.cocci
> +++ b/scripts/coccinelle/misc/orplus.cocci
> @@ -14,7 +14,19 @@ virtual report
>  virtual context
>
>  @r@
> -constant c;
> +constant c,c1;
> +identifier i,i1;
> +position p;
> +@@
> +
> +(
> + c1 + c - 1
> +|
> + c1 at i1 + at p c at i
> +)
> +
> + at s@
> +constant r.c, r.c1;
>  identifier i;
>  expression e;
>  @@
> @@ -27,28 +39,31 @@ e & c at i
>  e |= c at i
>  |
>  e &= c at i
> +|
> +e | c1 at i
> +|
> +e & c1 at i
> +|
> +e |= c1 at i
> +|
> +e &= c1 at i
>  )
>
> - at s@
> -constant r.c,c1;
> -identifier i1;
> -position p;
> + at depends on s@
> +position r.p;
> +constant c1,c2;
>  @@
>
> -(
> - c1 + c - 1
> -|
> -*c1 at i1 + at p c
> -)
> +* c1 + at p c2
>
> - at script:python depends on org@
> -p << s.p;
> + at script:python depends on s && org@
> +p << r.p;
>  @@
>
>  cocci.print_main("sum of probable bitmasks, consider |",p)
>
> - at script:python depends on report@
> -p << s.p;
> + at script:python depends on s && report@
> +p << r.p;
>  @@
>
>  msg = "WARNING: sum of probable bitmasks, consider |"



-- 
Best Regards
Masahiro Yamada
