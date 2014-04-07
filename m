From: volanschi@metaware.fr (Nic Volanschi (R&D))
Date: Mon, 07 Apr 2014 12:37:54 +0200
Subject: [Cocci] spatch issue with C struct initialization
Message-ID: <1396867074.3201.10.camel@zamolxis.metaware.tm.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 2014-04-07 at 12:00 +0200, cocci-request at systeme.lip6.fr wrote:
> Not being an expert on grammar, there is a chance this will work ?
> >
> >  initializer
> >     : assignment_expression
> >        | '{' initializer_list '}'
> >        | '{' initializer_list ',' '}'
> >        | ( type-name ) { initializer-list }
> >        | ( type-name ) { initializer-list , }
> >
> > If you can point me to the code dealing with it, I can try to play
> with
> > it a little bit.
> 
> I think I already tried the same thing.  The problem is that
> ( type-name )
> is already buried deep within assignment_expression, for an ordinary
> cast,
> so the parser doesn't know which rule to choose.
> 
> julia

I agree that the "initializer" nonterminal is not the right place to
extend the grammar, because it would not allow legal statements such as:

  structure = ((struct foo) {x + y, 'a', 0});

the example coming from:
http://gcc.gnu.org/onlinedocs/gcc/Compound-Literals.html

Rather, it seems to me that the right place to extend the grammar is the
"cast_expression" nonterminal:

> cast_expression
> 	: unary_expression
> 	| '(' type_name ')' cast_expression
          | '(' type_name ')' '{' initializer_list '}'
> 	;

This would not only allow the above legal expression, but should also 
avoid to introduce a conflict in the grammar.

Hope this helps.

Nic.
