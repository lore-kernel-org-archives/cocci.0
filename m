From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Aug 2015 13:40:00 +0200 (CEST)
Subject: [Cocci] Finding designated initialisers with SmPL
In-Reply-To: <55C5B85A.8060508@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55ACDC1C.1040005@users.sourceforge.net>
 <alpine.DEB.2.10.1507201335030.2475@hadrien>
 <55ACF739.4020802@users.sourceforge.net>
 <alpine.DEB.2.10.1507201828130.2475@hadrien>
 <55AD58A7.6030507@users.sourceforge.net>
 <alpine.DEB.2.02.1507202238110.2082@localhost6.localdomain6>
 <55ADDD03.6020401@users.sourceforge.net>
 <55C5B85A.8060508@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1508081338080.2027@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 8 Aug 2015, SF Markus Elfring wrote:

> > I have tried the following small SmPL script
> > 
> > @show_designated_initialisers@
> > identifier allocation, element, structure_type, structure_var;
> > @@
> >  <+...
> > *struct structure_type structure_var = { ..., .element = allocation(...), ... };
> >  ...+>
> > 
> > 
> > on this
> > 
> > 
> > char* get_default_message(short selection)
> > {
> >  static char xyz[123];
> >  
> >  switch (selection)
> >  {
> >  case 1:
> >   strcpy(xyz, "Test");
> >  default:
> >   strcpy(xyz, "working");
> >  }
> >  return xyz;
> > }
> > 
> > static unsigned long my_counter = 0;
> > 
> > static struct my_string
> > {
> >  unsigned int length;
> >  char* text;
> > } message = { .text = get_default_message(1), .length = 123 };

Actually, I don't see where you expect your rule to match your code.  I 
don't see the point of including the function withe the switch and the 
declaration of my-counter in the example at all.  The only case where 
there is any hope of a match is in the declaration of the my_string 
strcuture, but that declaration doesn't have the same form as your 
semantic patch rule.  Your code specifies the types of the fields at the 
same time, which is not done in the pattern.

julia

> > 
> > 
> > source code example.
> > 
> > 
> > elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt -sp-file show_designated_initialisers1.cocci designated_initialiser1.c
> > init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> > HANDLING: designated_initialiser1.c
> > 
> > 
> > Unfortunately, I do not see a generated patch there.
> > How should I improve my approach for the expected analysis result?
> 
> How is the status for the support of data processing for designated initialisers
> with the semantic patch language?
> 
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
