From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Dec 2015 13:54:15 +0100 (CET)
Subject: [Cocci] Finding labelled statements with SmPL
In-Reply-To: <566817F9.9010800@users.sourceforge.net>
References: <5667F25B.1080901@users.sourceforge.net>
 <alpine.DEB.2.10.1512091114520.2491@hadrien>
 <566817F9.9010800@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1512091352250.2491@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 9 Dec 2015, SF Markus Elfring wrote:

> > A label has to be an identifier.
>
> This wording fits only to a jump label for the statement "goto", doesn't it?

The labels for switch have "case" in front of them.  They won't be matched
by a pattern like label:

>
> > A sequence of all capital letters is also an identifier.
>
> Does this feedback mean that the following SmPL approach should also work
> for case labels?
>
>
> @label_used@
> identifier label;
> @@
> *label:
>
>
> How much do constant expressions matter in such a source code analysis?
>
> Why did I get the message "minus: parse error"?

Probably because a label by itself is not valid C code.  It needs a
statement after it.

julia
