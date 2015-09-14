From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Mon, 14 Sep 2015 16:16:57 +0200
Subject: [Cocci] Find expressions of given type
In-Reply-To: <20150914082905.GA11348@kaficko.joja.cz>
References: <20150914082905.GA11348@kaficko.joja.cz>
Message-ID: <CA+MoWDoTH9H0ap0vHDqH81P1VpE=YHPABOKZrniqH9yp7jNmgA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Jan,

I'm not sure to understand your problem, but here is a nice feature I
use to get expression types. I think this example doesn't do what you
want but I guess it shows how to get types from expressions:

@r1@
expression ep;
identifier f, fld;
type t;
t e;
@@
ep at e.fld = f

@script:python@
ep << r1.ep;
fld << r1.fld;
t << r1.t;
@@
print t, ep, fld

There are two important parts:

@r1@
...
type t;
t e;
@@

which just tells coccinelle that you are interested in e of type t,
but you don't want to match the declaration. Then the '@e' on the
line:

ep at e.fld = f

makes e match the expression that comes before '.fld', and as the type
of that expression is t, you can use t on your rules (to print, import
it in other rules, ...).

Hope it helps...


On Mon, Sep 14, 2015 at 10:29 AM, Jan Moskyto Matejka
<mq+coccinelle@ucw.cz> wrote:
> Hello,
>
> I'm trying to match all expressions of a given type. I want to check
> whether all accesses to any part of some struct are locked.
>
> In the hypothetical case (which doesn't happen), every access to that
> struct would create a local variable of the wanted type and I could then
> match it with something like this:
>
> @@
> identifier         i;
> @@
>
> ...
> my_specific_type  *var;
> ...
> var->i
> ...
>
> Unfortunately, this structure may be also referenced from another
> structure, like this:
>
> struct A { int foo; int bar; };
> struct B { int foo; struct A *bar };
>
> struct B *b;
> ...
> b->bar->foo;
>
> I would like to write something like:
>
> @@
> expression struct A* E;
> @@
>
> ...
> +E
> ...
>
> and match every occurence of not only variables of the given type, but
> also an expression.
>
> I was first trying to find some hint in the doc, found
> expression struct *E;
> which is almost what I want but still too broad.
>
> Does there exist some way to
> A) achieve the behaviour I want by config
> or
> B) implement it?
>
> If A, could you please give me a hint?
> If B, I wanted to implement it but got totally lost in the code. Could
> you please give me a pointer, where to begin? I'd like to contribute the
> result then.
>
> Best regards and thanks
> MQ
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Peter
