From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 26 Sep 2015 15:55:56 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: assign signed result to unsigned
	variable
In-Reply-To: <560684F3.9090700@users.sourceforge.net>
References: <1443099286-16559-1-git-send-email-a.hajda@samsung.com>
 <56041BE5.5010005@users.sourceforge.net> <56051D2B.5040802@samsung.com>
 <56064D0B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1509261106040.2737@hadrien>
 <56066866.1060602@users.sourceforge.net>
 <alpine.DEB.2.10.1509261144270.2737@hadrien>
 <56066AD4.9060306@users.sourceforge.net>
 <alpine.DEB.2.10.1509261154500.2737@hadrien>
 <560684F3.9090700@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1509261554100.2717@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 26 Sep 2015, SF Markus Elfring wrote:

> >> The connection between the SmPL specification "f(...)@e" and the desired return type
> >> was not obvious for me so far.
> >
> > The nearest enclosing expression of the ) is the whole function call itself.
>
> Thanks for your explanation.
>
> Now I guess that the enclosing context is a particular function implementation
> where specific calls are performed, isn't it?

No idea what yu mean by this.  Function calls are usually found within
function definitions.  But it could be in the definition of a macro as
well.  It doesn't matter, as long as the type is available.

>
>
> > e will thus match the entire expression.  e is declared to have type t
>
> Did you omit this detail in your suggestion a moment ago?

I don't thik so.  I said t e; where t could be whatever typep or set of
types one wants.

>
> > (where t is in practice signed int or whatever one wants to check for).
>
> How do you think about reuse another data type enumeration there?

No idea what you mean by this.

>
> How would you like to manage names for functions which are not defined
> in the current source file?

Why does it matter in this case?

julia

> Regards,
> Markus
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
