From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 1 Oct 2014 15:08:54 +0200 (CEST)
Subject: [Cocci] string parameter concatenation
In-Reply-To: <20141001130215.GB4701@rei.suse.cz>
References: <20141001130215.GB4701@rei.suse.cz>
Message-ID: <alpine.DEB.2.10.1410011504340.2489@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 1 Oct 2014, Cyril Hrubis wrote:

> Hi!
> I've found a small nit in the handling of strings that spans over
> multiple lines:
>
> nit.c:
> int main(void)
> {
>         f("This is a string that continues to the next line"
>           " just string continuation");
> }
>
> nit.cocci:
> @@
> expression list L;
> @@
> - f(L);
> + g(L);
>
>
> spatch nit.cocci nit.c
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> HANDLING: nit.c
> diff =
> --- nit.c
> +++ /tmp/cocci-output-8374-71ffd9-nit.c
> @@ -1,5 +1,4 @@
>  int main(void)
>  {
> -       f("This is a string that continues to the next line"
> -         " just string continuation");
> +       g("This is a string that continues to the next line"" just string continuation");
>  }
>
> While this produces perfectly correct C code it would be nicer if the
> strings were merged into one single C string. Othewise this still breaks
> what LKML coding style says about being able to grep user-visible
> strings in the source code.

I can try to see what to do about it.  String made up of multiple
concatenated strings are perhaps not so well supported.  I don't think
that automatic concatenation would be a good idea, because some users
might not want it.

Thanks!

julia
