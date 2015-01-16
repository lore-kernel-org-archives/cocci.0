From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 16 Jan 2015 18:51:43 +0100 (CET)
Subject: [Cocci] Find all variables/parameters of a given type.
In-Reply-To: <528DE554-4455-43F3-86D0-A4A1BE677755@gmail.com>
References: <528DE554-4455-43F3-86D0-A4A1BE677755@gmail.com>
Message-ID: <alpine.DEB.2.10.1501161851000.2549@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 16 Jan 2015, Eliseo Mart?nez wrote:

> Hi,
>
> I?m trying to write a semantic patch to be able to find all `long` variables/function parameters in my code.
> I?ve tried a lot of variations, the last of them being:
>
> ```
> @@ identifier i; @@
>
> * long i;
>
> @@ identifier i, f; @@
>
> (
> * f(long i) { ... }
> |
> * f(long i, ...) { ... }
> |
> * f(..., long i, ...) { ... }
> |
> * f(..., long i) { ... }
> )

You can't put function definitions in a disjunction.  But you don't need
to either.  The third case will take care of everything.

julia

> ```
>
> But I get parse errors no matter what I try.
> Where?s my error?
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
