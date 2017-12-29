From: jeremy.lefaure@lse.epita.fr (=?UTF-8?B?SsOpcsOpbXk=?= Lefaure)
Date: Fri, 29 Dec 2017 18:28:00 +0100
Subject: [Cocci] [PATCH 1/1] Coccinelle: array_size: report even if
 include is missing
In-Reply-To: <alpine.DEB.2.20.1709141320170.3185@hadrien>
References: <20170914023807.12972-1-jeremy.lefaure@lse.epita.fr>
 <alpine.DEB.2.20.1709141320170.3185@hadrien>
Message-ID: <20171229182800.6c44a81e@jeremy-laptop>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

On Thu, 14 Sep 2017 13:21:13 +0200 (CEST)
Julia Lawall <julia.lawall@lip6.fr> wrote:

> On Wed, 13 Sep 2017, J?r?my Lefaure wrote:
> 
> > Rule r does not depend on rule i (which is the include of
> > linux/kernel.h) so the output should not depend on i in
> > org and report mode.
> >
> > Signed-off-by: J?r?my Lefaure <jeremy.lefaure@lse.epita.fr>  
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> I guess that if the incude is missing, the person updating the code can
> always add it.
> 
I don't see this patch upstream, is it lost somewhere or should I send
it to someone else ?


> 
> > ---
> >
> > I have tested this patch in report mode on the file
> > drivers/staging/rtlwifi/phydm/rtl8822b/halhwimg8822b_rf.c which does not
> > use ARRAY_SIZE and does not include linux/kernel.h.
> >
> >  scripts/coccinelle/misc/array_size.cocci | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/coccinelle/misc/array_size.cocci b/scripts/coccinelle/misc/array_size.cocci
> > index 6ec05710b017..09520f0941f0 100644
> > --- a/scripts/coccinelle/misc/array_size.cocci
> > +++ b/scripts/coccinelle/misc/array_size.cocci
> > @@ -72,13 +72,13 @@ position p;
> >   (sizeof(E)@p /sizeof(T))
> >  )
> >
> > - at script:python depends on i&&org@
> > + at script:python depends on org@
> >  p << r.p;
> >  @@
> >
> >  coccilib.org.print_todo(p[0], "WARNING should use ARRAY_SIZE")
> >
> > - at script:python depends on i&&report@
> > + at script:python depends on report@
> >  p << r.p;
> >  @@
> >
> > --
> > 2.14.1
> >
> >  
