From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Jul 2013 11:57:21 +0200 (CEST)
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <51DE75BF.3060207@monom.org>
References: <51DE6A05.9050008@monom.org>
 <alpine.DEB.2.02.1307111026390.2253@hadrien> <51DE75BF.3060207@monom.org>
Message-ID: <alpine.DEB.2.02.1307111156420.2253@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 11 Jul 2013, Daniel Wagner wrote:

> Hi Julia,
>
> On 07/11/2013 10:29 AM, Julia Lawall wrote:
> > > I'd like to convert a bunch of gboolean decleration to stdbool in our
> > > ConnMan
> > > code base. I am a noob with coccinelle. I have partial success so far but
> > > I do
> > > not thing I am doing the right thing. So any advice is welcome :)
> > >
> > >
> > > This here is my current coccinelle script for converting gboolean used as
> > > stack variable. I have also one for structs, which gave my good results.
> > > Another one is needed then for the function arguments. But let's first
> > > have a
> > > look on this part.
> > >
> > > @r1@
> > > position p;
> > > typedef gboolean;
> > > identifier func,x;
> > > @@
> > > func(...) {
> > > <...
> > > 	gboolean at p x;
> > > ...>
> > > }
> > >
> > > @r2@
> > > position r1.p;
> > > typedef bool;
> > > @@
> > > - gboolean at p
> > > + bool
> > >
> > > @r3@
> > > identifier r1.x;
> > > @@
> > > (
> > > - x = FALSE
> > > + x = false
> > > |
> > > - x = TRUE
> > > + x = true
> > > )
> > >
> > > int main(int argc, char *argv[])
> > > {
> > > 	gboolean b = TRUE;
> > >
> > > 	return 0;
> > > }
> > >
> > > results in
> > >
> > > int main(int argc, char *argv[])
> > > {
> > > -       gboolean b = TRUE;
> > > +       bool b = true;
> > >
> > >          return 0;
> > > }
> > >
> > > which is what I wanted. Now the problem is that I really have no clue to
> > > mach
> > > on things like
> > >
> > > int main(int argc, char *argv[])
> > > {
> > > 	gboolean b = TRUE, c = FALSE;
> > >
> > > 	return 0;
> > > }
> > >
> > > Any idea?
> >
> > Did you try just
> >
> > @@
> > @@
> >
> > - gboolean
> > + bool
> >
> > Also, for yoru TRUE -> true rule, you could consider
>
> Yes, the problem is that I can't replace all gbooleans because we are GLib,
> e.g. we are using quite a few timers
>
>
> guint g_timeout_add (guint interval, GSourceFunc function,
> 			 gpointer data);
>
> gboolean (*GSourceFunc) (gpointer user_data);
>
> https://developer.gnome.org/glib/2.36/glib-The-Main-Event-Loop.html#g-timeout-add
>
> So these gboolean should not be changed. BTW, when I tried your probosal it
> would not change this here
>
> 	gboolean b,c;
>
> changing the rules to
>
> 	- gboolean
> 	++ bool
>
> resulted int
>
> 	bool bool b,c;
>
> Also not what I wanted :)

OK, I will get back to you.

julia
