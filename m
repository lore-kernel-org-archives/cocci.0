From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 7 Jul 2016 19:09:20 +0200 (CEST)
Subject: [Cocci] Adding missing parameter to function if missing
In-Reply-To: <924f7230d5074b14b8658f65e00de85a@vprd-opci0018.b-com.local>
References: <bda6f254dbe94ad28468d5de4b6c3a17@vprd-opci0018.b-com.local>
 <alpine.DEB.2.10.1607061819400.3168@hadrien>
 <924f7230d5074b14b8658f65e00de85a@vprd-opci0018.b-com.local>
Message-ID: <alpine.DEB.2.10.1607071908130.3620@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 7 Jul 2016, Fr?d?ric LEROY (ext) wrote:

> Hello Julia,
>
> > > @ test depends on !fn_with_user@
> > > identifier fn_with_user.fn;
> > > parameter list pl;
> > [...]
> >
> > This rule is contradictory.  You say that the rule fn_with_user should not have
> > matched, but you want to match the identifier fn_with_user.fn.
> > Instead, you should match fn first, then have one rule that matches the case
> > you don't want, and then finally the case that you do want:
>
> I was desesperate to the point to try everything ;-)
>
> > When you match barfn, you create an environment for each possible value
> > of fn.  This is then passed through the next two rules, where it records
> > whether the rule fn_with_user matches.  There is a separate environment for
> > each match of barfn.
>
> Understood.
>
> I have narrowed the issue with the help of --debug to this part :
>
> @fn_with_user@
> identifier barfn.fn, foo;
> typedef my_type;

Te typedef here is fine, if you want the type to be called my_type.

> parameter list pl;
> expression E;
> @@
>
> fn(my_type *foo, pl) {
> <+...
> bar(foo, E);
> ...+>
> }
>
> I was confusing between the type name 'my_type' and type value 'my_type'.
>
> What I would to do is something like that :
>
> @fn_with_user@
> identifier fn, foo;
> typedef T = "my_type"; // '= ...' is not correct

I'm not sure to understand what is the point of this.

> parameter list pl;
> @@
>
> fn(T *foo, pl) {
> <+...
> bar(...);
> ...+>
> }
>
> But I don't know how to link 'my_type' value to type T ...
> I am sure that I am missing something obvious there :(

Was it not working with the code I suggested?

julia

> Sincerely,
>
> Fr?d?ric Leroy
>
>
>
