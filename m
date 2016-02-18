From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 17 Feb 2016 19:46:26 -0500 (EST)
Subject: [Cocci] [PATCH] scripts/coccinelle: modernize &
In-Reply-To: <56C50699.6000007@ti.com>
References: <1455750974-24339-1-git-send-email-Julia.Lawall@lip6.fr>
 <56C50699.6000007@ti.com>
Message-ID: <alpine.DEB.2.10.1602171946150.2506@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 17 Feb 2016, Nishanth Menon wrote:

> On 02/17/2016 05:16 PM, Julia Lawall wrote:
> > & is no longer allowed in column 0, since Coccinelle 1.0.4.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> >
> > ---
> >  scripts/coccinelle/iterators/use_after_iter.cocci |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
> > index f085f59..ce8cc9c 100644
> > --- a/scripts/coccinelle/iterators/use_after_iter.cocci
> > +++ b/scripts/coccinelle/iterators/use_after_iter.cocci
> > @@ -123,7 +123,7 @@ list_remove_head(x,c,...)
> >  |
> >  sizeof(<+...c...+>)
> >  |
> > -&c->member
> > + &c->member
> >  |
> >  c = E
> >  |
> >
>
>
> Verified with:
> spatch --version
> spatch byte-code version 1.0.4-00118-gc7cf750d1c44 compiled with OCaml
> version 4.01.0
>
>
> Tested-by: Nishanth Menon <nm@ti.com>

Thanks!

julia
