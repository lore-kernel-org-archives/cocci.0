From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 3 Dec 2015 23:12:56 +0100 (CET)
Subject: [Cocci] how to find missing initializer
In-Reply-To: <56608E06.9060003@metafoo.de>
References: <56603DC3.8040609@hurleysoftware.com> <56608E06.9060003@metafoo.de>
Message-ID: <alpine.DEB.2.10.1512032310280.2777@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Usually you'd do something like first find all that have the initializer and
> then match all that where not matched before using a position metavariable. E.g.
>
> @r1@
> identifier fops;
> identifier fn;
> position p;
> @@
> struct tty_operations fops at p = {
>     ...,
>     .cleanup = fn,
>     ...
> };

You don't need the ...  Coccinelle is very relaxed about matching
structure initializers.    What you provide should be a subset, in any
order, of what is present.  The ... would only be needed if you want to
add a new field initialization, and to force it to the beginning or end
of the structure.

Luis, why did you use a regular expression for cleanup?

Thanks for the contributions.

julia

> @@
> identifier fops;
> identifier fn;
> position p != r1.p;
> @@
> *struct tty_operations fops at p = {
>     ...
> };
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
