From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 27 Jan 2017 14:11:15 +0100 (CET)
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <1485507305.5851.1.camel@sipsolutions.net>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
 <1485437521.14760.5.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261518560.3109@hadrien>
 <1485440882.14760.8.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261644140.3109@hadrien>
 <1485445951.14760.16.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701270807230.1935@hadrien>
 <1485507305.5851.1.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1701271408210.3117@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 27 Jan 2017, Johannes Berg wrote:

> On Fri, 2017-01-27 at 08:09 +0100, Julia Lawall wrote:
> > Partial progress:??The github version will no longer match {} against
> > { 0, 1, 2 }, but it persists in matching {} against { .a = 1, .b = 2
> > },
> > and will still remove the outer braces without removing the rest.
>
> Out of curiosity: will it require some form of "..." to match something
> inside now?

No.

>
> We have a few things like this:
>
> @@
> identifier x;
> identifer fn;
> @@
> my_time x = {
> +#ifdef XYZ
>  .this_method_needs_xyz = fn,
> +#endif
>  ...
>  };
>
> in backports etc. and I've always wondered why it didn't need (or even
> accept, IIRC) ... before the +#ifdef line.

It considers that the rule writer has no knowledge or control of the field
names that are provided or the order in which they appear, so you can
specify any subset of them.  You only need ... when you want to add a new
one at the beginning or at the end of the structure.  The ... lets you
specify beginning or end.

I want to allow you to remove the {} only when all of the field
initializations are also removed.  Some work though is required.

julia
