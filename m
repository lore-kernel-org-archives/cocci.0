From: kborer@cpan.org (Kris Borer)
Date: Wed, 15 Jul 2015 13:42:20 -0400
Subject: [Cocci] logical not
In-Reply-To: <alpine.DEB.2.10.1507151015070.2919@hadrien>
References: <CAMy_N63xCDJbVkXnBvPyoDx6AUE37qsYGb5N2WHJWVR+6Zawxg@mail.gmail.com>
 <alpine.DEB.2.10.1507151015070.2919@hadrien>
Message-ID: <CAMy_N63u+w25yWb8rfdHHih1CL52br0NXntY2nfq+JDZ9cF4bg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Thank you, this approach works for me. I will look more into isomorphisms.

On Wed, Jul 15, 2015 at 10:17 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:

> > @@
> > identifier i;
> > expression E;
> > statement S;
> > @@
> >
> > + i = E;
> >   if (
> >   !
> > - (i = E)
> > + i
> >   ) S
>
> Try this one without the ! and with S converted to
>
> S1 else S2
>
> with S1 and S2 being statement metavariables.  I think that the various
> isoorphisms should cause this to do everything.  But you can check it by
> running spatch --parse-cocci file.cocci.  for this, it is more readable if
> you give your rule a short name, like r, because it will put the name of
> the rule in each metavariable that it prints, and the defaut is quite
> long.
>
> julia
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150715/a7758e90/attachment-0001.html>
