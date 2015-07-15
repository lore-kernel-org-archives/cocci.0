From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 15 Jul 2015 10:17:01 -0400 (EDT)
Subject: [Cocci] logical not
In-Reply-To: <CAMy_N63xCDJbVkXnBvPyoDx6AUE37qsYGb5N2WHJWVR+6Zawxg@mail.gmail.com>
References: <CAMy_N63xCDJbVkXnBvPyoDx6AUE37qsYGb5N2WHJWVR+6Zawxg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1507151015070.2919@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @@
> identifier i;
> expression E;
> statement S;
> @@
>
> + i = E;
> ? if (
> ? !
> - (i = E)
> + i
> ? ) S

Try this one without the ! and with S converted to

S1 else S2

with S1 and S2 being statement metavariables.  I think that the various
isoorphisms should cause this to do everything.  But you can check it by
running spatch --parse-cocci file.cocci.  for this, it is more readable if
you give your rule a short name, like r, because it will put the name of
the rule in each metavariable that it prints, and the defaut is quite
long.

julia
