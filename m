From: volanschi@metaware.fr (Nic Volanschi (R&D))
Date: Mon, 07 Apr 2014 15:27:49 +0200
Subject: [Cocci] spatch issue with C struct initialization
In-Reply-To: <alpine.DEB.2.10.1404071452020.2187@hadrien>
References: <1396867074.3201.10.camel@zamolxis.metaware.tm.fr>
 <alpine.DEB.2.10.1404071452020.2187@hadrien>
Message-ID: <1396877269.3201.20.camel@zamolxis.metaware.tm.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 2014-04-07 at 14:54 +0200, Julia Lawall wrote:
> On Mon, 7 Apr 2014, Nic Volanschi (R&D) wrote:
> > I agree that the "initializer" nonterminal is not the right place to
> > extend the grammar, because it would not allow legal statements such as:
> >
> >   structure = ((struct foo) {x + y, 'a', 0});
> >
> > the example coming from:
> > http://gcc.gnu.org/onlinedocs/gcc/Compound-Literals.html
> >
> > Rather, it seems to me that the right place to extend the grammar is the
> > "cast_expression" nonterminal:
> >
> > > cast_expression
> > > 	: unary_expression
> > > 	| '(' type_name ')' cast_expression
> >           | '(' type_name ')' '{' initializer_list '}'
> > > 	;
> >
> > This would not only allow the above legal expression, but should also
> > avoid to introduce a conflict in the grammar.
> 
> I can try this.  So the point is that if a type is present, then { ... }
> is a legal expression in any context?  

This is how I understand the above web page about compound literals.
Indeed, I tried the following code in gcc and it works fine:

int main() { 
  struct s { int i; int j; } s1;
  printf("{%d, %d}\n", (struct s){ 44, 55}.i, (struct s){ 66, 77}.j);
  printf("%d\n", (int[]){12,13,14}[1] + 10);
} 

So it seems that a compound literal can be used in any place where an
lvalue of the corresponding type is legal.

> On the other hand, Coccinelle is
> not a syntax checker.  It is fine for it to accept syntax that is invalid,
> as long as the effect in terms of metavariables etc is expectable to the
> user.

Sure. But in the given case, I'm not sure you create illegal uses,
anyways.

Nic.
