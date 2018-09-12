From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 12 Sep 2018 23:20:32 +0200 (CEST)
Subject: [Cocci] Checking patches for questionable comma expressions in
 if conditions
In-Reply-To: <d16d096c-2598-32c3-e489-d7f00b2aec51@users.sourceforge.net>
References: <20180912123304.GA18497@osadl.at>
 <d16d096c-2598-32c3-e489-d7f00b2aec51@users.sourceforge.net>
Message-ID: <alpine.DEB.2.21.1809122318240.2437@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 12 Sep 2018, SF Markus Elfring wrote:

> > The below spatch works for me - and finds the cases I was looking
> > for in report mode.
>
> This is nice.
>
>
> > In patch mode it fixes some in a bad way though due to some additional "bugs"
> > in the if statement like:
> ?
> > -       if ((notify->event = event), event->refs) {
> > +       (notify->event = event);
> > +       if (event->refs) {
>
> I am curious on how software development considerations will evolve further
> for such generated patches.
>
> Will the shown script for the semantic patch language need any more fine-tuning?
>
> Would the following transformation variant result in desirable differences
> (after the specification of extra parentheses)?
>
>
> @badif@
> position P;
> statement S;
> expression E1,E2;
> @@
>  if at P ((E1),E2) S
>
> ?
>
> @fixbadif depends on patch && badif@
> position badif.P;
> statement S;
> expression badif.E1,badif.E2;
> @@
> +E1;
>  if at P (
> -      (E1),
>        E2)
>       S

Alternatively, I suspect that one could just do

- (
  E
- )
  ;

Or the original rule could be

+E1;
 if (
- (E1),
  E2) S1 else S2

>
>
> > -       if (mask = 0, data = 0, ram->diff.rammap_11_0a_03fe) {
> > +       mask = 0, data = 0;
> > +       if (ram->diff.rammap_11_0a_03fe) {
> >
> > In futher cases it is not clear if the unconditional part really was
> > intended to take effect outside the conditional code so it is not
> > clear if the placement before the if () is technically correct

I'm not sure to understand the problem here.  You want to also change the
, on the added line to a semicolon?

julia
