From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 10 May 2015 18:31:20 +0200 (CEST)
Subject: [Cocci] Fine-tuning for switch statements
In-Reply-To: <554F871F.6030500@users.sourceforge.net>
References: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
 <alpine.DEB.2.10.1505101453460.2645@hadrien>
 <554F871F.6030500@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1505101830240.2648@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 10 May 2015, SF Markus Elfring wrote:

> > @bad exists@
> > position p != ok.p;
> > expression E,e;
> > @@
> > switch at p (E) {
> > case e: ...
> > }
>
> How do you think about to restrict the label "e"
> to a constant expression by the means of the semantic
> patch language?
> http://en.cppreference.com/w/c/language/switch
>
> Does it matter to make the affected SmPL script
> a bit more precise?

I see no benefit from doing that.  The case is only there to satisfy the
SmPL parser, which for some reason doesn't allow just ...  There is no
intent to restrict what is matched in any way.

julia
