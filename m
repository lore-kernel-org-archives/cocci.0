From: Frederic.LEROY@b-com.com (=?iso-8859-1?Q?Fr=E9d=E9ric_LEROY_=28ext=29?=)
Date: Thu, 7 Jul 2016 11:54:53 +0000
Subject: [Cocci] Adding parameter to function if missing
In-Reply-To: <4a1dcd24-efeb-902c-f239-d620850b4dbe@users.sourceforge.net>
References: <bda6f254dbe94ad28468d5de4b6c3a17@vprd-opci0018.b-com.local>
 <4a1dcd24-efeb-902c-f239-d620850b4dbe@users.sourceforge.net>
Message-ID: <a2cccefd6c0f4986a03a61edf21be6cd@vprd-opci0018.b-com.local>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Markus,

> -----Message d'origine-----
> De?: SF Markus Elfring [mailto:elfring at users.sourceforge.net]
> Envoy??: mercredi 6 juillet 2016 18:51
> ??: Fr?d?ric LEROY (ext)
> Cc?: Coccinelle
> Objet?: Re: [Cocci] Adding parameter to function if missing
> 
> > I am new to coccinelle and I have trouble to use it.
> 
> Which software versions do you try out here?

Either 1.0.0 from Ubuntu 15.10 or 1.0.4 from Ubuntu 16.04

> I imagine that there are further software development challenges to
> consider for such a source code transformation in header files.

You are right, I learn spatch to make work on a bigger software.
I narrowed my problem with a simple example.

> > I tried several ways to do it without success. If I add a negative depends on
> rule, it won't work.
> 
> Do you get an error message?

Not much :
    init_defs_builtins: /usr/share/coccinelle/standard.h
    warning: line 32: foo, previously declared as a metavariable, is used as an identifier
    HANDLING: test.c
    diff = 
    --- test.c
    +++ /tmp/cocci-output-7971-016dcc-test.c
    @@ -1,9 +1,9 @@
     void f1(void *args) {
    -    bar(anything);
    +    bar(foo, anything);
     }
    [...]
All call are replaced and no header are modified.

> > @fn_with_user@
> > identifier fn, foo;
> > typedef my_type;
> 
> How do you think about the SmPL specification "type my_type;" here?
 
I used typedef to not redeclare it on following rules.
I just did a quick test, but I have the same output.
 
> > parameter list pl;
> > expression E;
> > @@
> >
> > fn(my_type *foo, pl) {
> > <+...
> > bar(foo, E);
> > ...+>
> > }
> >
> > @ test depends on !fn_with_user@
> > identifier fn_with_user.fn;
> 
> Will it make sense to add the SmPL specification "type
> fn_with_user.my_type;" here?

Removing typedef and using type gave me the same result.

> > parameter list pl;
> > expression E;
> > @@
> >
> > fn(
> > + my_type *foo,
> > pl) {
> > <+...
> > bar(foo, E);
> 
> Would you like to merge this place with your first SmPL rule?

Thanks, I make a version which works:

@ rule2 @
identifier fn;
expression E;
typedef my_type;
parameter list pl;
@@

 fn(my_type foo, pl) {
   <+...
- bar(E);
+ bar(foo, E);
  ...+>
}

@ rule4 @
identifier fn;
expression E;
identifier p;
@@

- fn(void) {
+ fn(my_type foo) {
   <+...
- bar(E);
+ bar(foo, E);
  ...+>
}

@ rule3 @
identifier fn;
expression E;
parameter list pl;
@@

- fn(pl) {
+ fn(my_type foo, pl) {
   <+...
- bar(E);
+ bar(foo, E);
  ...+>
}

> > Could you help me ?
> I hope so.

Thank you Markus :)

Regards,

Fr?d?ric Leroy
