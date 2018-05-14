From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 14 May 2018 16:35:11 +0200 (CEST)
Subject: [Cocci] Moving a function body to an other source code place
 with SmPL
In-Reply-To: <704e29ae-bd49-6b84-eb96-45f6d3ad004e@users.sourceforge.net>
References: <704e29ae-bd49-6b84-eb96-45f6d3ad004e@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805141632540.17398@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 14 May 2018, SF Markus Elfring wrote:

> Hello,
>
> I am curious on how good the Coccinelle software can support a specific
> source code transformation:
> It would be occasionally nice if an implementation of a function could be
> completely stored into a metavariable.
> Is a statement list variable appropriate for this use case?

Yes.

@@
identifier f;
statement list SS;
@@

f() {
  SS
}

A statement list metavariable should only be used as the body of a block
{}.  If it is not working at the top of a function, it should be possible
to fix that.

> Can these data be moved to an other function (or macro definition)?

Yes.  A statement list variable can be added anywhere a list of statements
is allowed, ie not necessarily as the complete body of a block.

julia

>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
