From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 23 Aug 2018 18:45:18 -0400 (EDT)
Subject: [Cocci] [Fwd: Re: [PATCH] rtc: sun6i: Use struct_size() in
	kzalloc()]
In-Reply-To: <CAGXu5jKdbGCLdSQFTdGnhgN+tNKHFV=XEkapgtYmx+hK79NMbw@mail.gmail.com>
References: <CAGXu5jKPOVRk5DbFMKu0BV_K-ES+j+6_aApjyo0X8zXBfTYDnw@mail.gmail.com>
 <700bfdf296aa112799b6a6f091162cc34f6fef10.camel@perches.com>
 <CAGXu5jL3C78vkVL968HtBdLZgRYYQp4_pTKMT=BTJnk5z6CH3w@mail.gmail.com>
 <alpine.DEB.2.21.1808231759050.2376@hadrien>
 <CAGXu5jLjOtG0jTt2ZVyZe7ivBfZhRTyOKai0fHMzPFxUCr3LRg@mail.gmail.com>
 <alpine.DEB.2.21.1808231811110.2376@hadrien>
 <4a992fbb6ae172baf3c76ed979bf6804914b089e.camel@perches.com>
 <CAGXu5jKdbGCLdSQFTdGnhgN+tNKHFV=XEkapgtYmx+hK79NMbw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808231844510.2376@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 23 Aug 2018, Kees Cook wrote:

> On Thu, Aug 23, 2018 at 3:21 PM, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2018-08-23 at 18:13 -0400, Julia Lawall wrote:
> >>
> >> On Thu, 23 Aug 2018, Kees Cook wrote:
> >>
> >> (a + b) * c
> >>
> >> It will consider a pattern with the parentheses removed, but that pattern
> >> won't match anything, because real trees that consist of a + b * c are
> >> parsed in a different way.
> >
> > spatch 1.0.4 doesn't seem to:
> >
> > $ spatch --version
> > spatch version 1.0.4 with Python support and with PCRE support
> > $ cat match_mul.cocci
> > @@
> > expression a, b, c;
> > int d;
> > @@
> >
> > *       d = a * b + c;
>
> But "(a * b) + c" for the rule does:
>
>
> $ cat isomorphisms.c
> #include <stdio.h>
> #include <stdlib.h>
>
> int main(int argc, char *argv[])
> {
>         int a, b, c;
>
>         a = atoi(argv[1]);
>         b = atoi(argv[2]);
>         c = atoi(argv[3]);
>
>         printf("%d\n", a + b * c);
>         printf("%d\n", (a + b) * c);
>         printf("%d\n", a + (b * c));
>         printf("%d\n", b * c + a);
>         printf("%d\n", b * (c + a));
>         printf("%d\n", (b * c) + a);
>
>         return 0;
> }
> $ cat match.cocci
> @@
> identifier A, B, C;
> @@
>
> * (A * B) + C
>
> $ spatch -sp-file match.cocci isomorphisms.c
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> HANDLING: isomorphisms.c
> diff =
> --- isomorphisms.c
> +++ /tmp/cocci-output-8402-870fd6-isomorphisms.c
> @@ -9,12 +9,8 @@ int main(int argc, char *argv[])
>         b = atoi(argv[2]);
>         c = atoi(argv[3]);
>
> -       printf("%d\n", a + b * c);
>         printf("%d\n", (a + b) * c);
> -       printf("%d\n", a + (b * c));
> -       printf("%d\n", b * c + a);
>         printf("%d\n", b * (c + a));
> -       printf("%d\n", (b * c) + a);
>
>         return 0;
>  }
>
>
> So it sounds like I should put parens around all kinds of things in my rules...

If you think someone might reasonably use parentheses somewhere, you
should put them.

julia
