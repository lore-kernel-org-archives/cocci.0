From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 27 Jan 2017 22:52:28 +0100 (CET)
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <1485553437.14579.4.camel@sipsolutions.net>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
 <1485437521.14760.5.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261518560.3109@hadrien>
 <1485440882.14760.8.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261644140.3109@hadrien>
 <1485445951.14760.16.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261655450.3109@hadrien>
 <1485553437.14579.4.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1701272250210.2830@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 27 Jan 2017, Johannes Berg wrote:

>
> > > To get rid of all the initializers, but (as I'm still on the phone)
> > > I haven't tried it yet :)
> > >
> >
> > Put a when any above the T x = line.
> >
> > On the other hand, ++ makes no guarantee about the order in which
> > things are generated.
> >
> > To ensure the order, put the when any above the T x line, and drop
> > the one below and run multiple times.??Then each run will work on the
> > last one and put it first, so they will come out in order.
>
> Finally got a chance to try this.
>
> I can't seem to get the ordering right. I'm trying this:
>
> @@
> type T;
> expression E;
> statement S1, S2;
> identifier x;
> identifier f;
> @@
> ?{
> ... when != { ... }
> ????when any
> ?T x = {
> -??.f = E,
> ?};
> ... when != S1
> + x.f = E;
> ?S2
> ?...
> ?}
>
> on a very simple file:
>
> int main()
> {
> 	struct foo bar = {
> 		.y = 8,
> 		.x = 7,
> 	};
>
> 	printf("%d\n", bar.x);
> 	printf("%d\n", bar.y);
> }
>
> but it doesn't end well:
>
> $ spatch??--sp-file /tmp/init.spatch /tmp/test.c
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> HANDLING: /tmp/test.c
> ?????
> previous modification:
>
> ? <<< x.f = E;
> CONTEXT
> According to environment 3:
> ???rule starting on line 1.E -> 8
> ???rule starting on line 1.f -> id y
> ???rule starting on line 1.x -> id bar
>
> current modification:
>
> ? <<< x.f = E;
> CONTEXT
> According to environment 3:
> ???rule starting on line 1.E -> 7
> ???rule starting on line 1.f -> id x
> ???rule starting on line 1.x -> id bar
>
> Fatal error: exception Failure("rule starting on line 1: already tagged
> token:\nC code context\nFile \"/tmp/test.c\", line 8, column
> 1,??charpos = 59\n????around = 'printf', whole content =
> \tprintf(\"%d\\n\", bar.x);")

Yeah, it doesn't work.  There is no way to get the fields out of the
structure one at a time.  So ++ seems like the only option.  The suggested
organization would work for when there is more than one structure
definition in the function, but doesn't help for multiple fields within a
structure.

julia


>
>
> If I use ++ instead of +, it still replaces all of them, so I can't run
> multiple times (usefully anyway)
>
> OTOH, I haven't found any place where the order actually matters (in
> the code base I'm interested in), and although it seems that it
> theoretically could matter, I'm not sure I really need to solve that
> problem - although I'm thinking I might want to run this not just once
> but before each compile, to keep the code neater.
>
> (Note that I also haven't upgraded to the git version yet, TBD)
>
> johannes
>
