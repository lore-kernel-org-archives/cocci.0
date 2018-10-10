From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 10 Oct 2018 18:10:03 +0200 (CEST)
Subject: [Cocci] Dummy rule for simplifying "depends on" clauses?
In-Reply-To: <CAOZdJXW8Ve+Rwhg_xjrQR49=0vt1xLfqWWmOp3Z5ieT0fFKnbw@mail.gmail.com>
References: <CAOZdJXUWj-U87j6p-AK8wx_V4qRPD2ogyLyOgLE7pSFofzQ_Gw@mail.gmail.com>
 <alpine.DEB.2.21.1810100741210.2477@hadrien>
 <CAOZdJXXgW3SOgiVOKijaooPipwDNUqMm3ScZ0XUU2d3F4Yok8A@mail.gmail.com>
 <alpine.DEB.2.20.1810101735550.3396@hadrien>
 <CAOZdJXW8Ve+Rwhg_xjrQR49=0vt1xLfqWWmOp3Z5ieT0fFKnbw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1810101807370.3396@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 10 Oct 2018, Timur Tabi wrote:

> On Wed, Oct 10, 2018 at 10:37 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
> > You can't put multiple @@'s at the beginning of a rule.  This should be
> > just:
> >
> > @r depends on rules@
> > ...
> > @@
>
> I'll admit, I don't really understand any of the @ syntax.  I must
> have copy/pasted too aggressively.  Thanks, it works now.

You have one @@ before the metavariables and one after.  The one before
can contain some other information.  The grammar is not completely
correct, but youcan get an idea of what you can put between the initial @@
on page 2 here: docs/manual/main_grammar.pdf

julia
