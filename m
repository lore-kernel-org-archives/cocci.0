From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 22 Jul 2017 08:39:19 +0200 (CEST)
Subject: [Cocci] [PATCH] EDAC: remove unnecessary static in
 edac_fake_inject_write()
In-Reply-To: <20170722063602.GB2050@nazgul.tnic>
References: <20170704214440.GA9462@embeddedgus>
 <20170717083946.GB23129@nazgul.tnic>
 <alpine.DEB.2.20.1707212205410.2232@hadrien>
 <20170722063602.GB2050@nazgul.tnic>
Message-ID: <alpine.DEB.2.20.1707220838410.2068@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 22 Jul 2017, Borislav Petkov wrote:

> On Fri, Jul 21, 2017 at 10:08:12PM +0200, Julia Lawall wrote:
> > Someone pointed out that the rule is probably not OK when the address of
> > the static variable is taken, because then it is likely being used as
> > permanent storage.
>
> Makes sense to me.
>
> > An improved rule is:
>
> Do you think it is worth having it in scripts/coccinelle/ ?

Sure.  Now that it has been a bit more sanity checked.

> I don't think Gustavo would mind putting it there :)

OK, I will check with him.

julia

>
> Thanks.
>
> --
> Regards/Gruss,
>     Boris.
>
> ECO tip #101: Trim your mails when you reply.
> --
>
