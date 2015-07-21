From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 21 Jul 2015 07:47:47 +0200
Subject: [Cocci] Finding designated initialisers with SmPL
In-Reply-To: <alpine.DEB.2.02.1507202238110.2082@localhost6.localdomain6>
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
Message-ID: <55ADDD03.6020401@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>  <+...
>> *struct structure_type structure_var = { ..., .element = allocation(...), ... };
>>  ...+>
> 
> Element should be an identifier.

I find it not so obvious that the metavariable type "field"
was inappropriate there. Would more explanations in the manual help, too?
https://github.com/coccinelle/coccinelle/blob/af8131522ee9aff575e4345f5068f4f138264cd6/docs/manual/cocci_syntax.tex#L153


I have tried the following small SmPL script

@show_designated_initialisers@
identifier allocation, element, structure_type, structure_var;
@@
 <+...
*struct structure_type structure_var = { ..., .element = allocation(...), ... };
 ...+>


on this


char* get_default_message(short selection)
{
 static char xyz[123];
 
 switch (selection)
 {
 case 1:
  strcpy(xyz, "Test");
 default:
  strcpy(xyz, "working");
 }
 return xyz;
}

static unsigned long my_counter = 0;

static struct my_string
{
 unsigned int length;
 char* text;
} message = { .text = get_default_message(1), .length = 123 };


source code example.


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt -sp-file show_designated_initialisers1.cocci designated_initialiser1.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
HANDLING: designated_initialiser1.c


Unfortunately, I do not see a generated patch there.
How should I improve my approach for the expected analysis result?

Regards,
Markus
