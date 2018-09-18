From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 18 Sep 2018 12:41:33 +0200 (CEST)
Subject: [Cocci] moving const instead of not matching?
In-Reply-To: <1537262433.2957.18.camel@sipsolutions.net>
References: <1537262433.2957.18.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1809181239470.3737@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 18 Sep 2018, Johannes Berg wrote:

> I was trying to do something like this:
>
> @@
> typedef u8;
> expression D, T, S2;
> @@
> (
>  memcpy(
> -(u8 *)(D)
> +D
>  ,
> -(u8 *)(T)
> +T
>  , S2)
> |
>  memcpy(
> -(u8 *)(D)
> +D
>  ,
> -(T)
> +T
>  , S2)
> |
>  memcpy(
> -(D)
> +D
>  ,
> -(u8 *)(T)
> +T
>  , S2)
> )
>
>
> but then I ran across a place that had a const, and the result was
> rather unexpected:
>
> $ spatch --sp-file /tmp/test3.spatch /tmp/test.c
> init_defs_builtins: /usr/lib64/coccinelle/standard.h
> HANDLING: /tmp/test.c
> diff =
> --- /tmp/test.c
> +++ /tmp/cocci-output-8879-8411db-test.c
> @@ -1,4 +1,4 @@
>  int main()
>  {
> -	memcpy(dst, (const u8 *)src, sz);
> +	memcpy(dst, src const, sz);
>  }
>
>
> Why is the const being moved there, rather than not matching?

To get it to not match this case, put disable optional_qualifier in the
rule header.  There is an isomorphism that allows it to not care about
whether things like const or volatile are present or not, but apparently
it is not deleting it as it should be.

If you want to match the const case, you can make some other rules with
const explicitly.

> spatch version 1.0.6.

You may want to upgrade, although it's unrelated to this issue.

julia
