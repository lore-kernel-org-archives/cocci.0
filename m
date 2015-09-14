From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 14 Sep 2015 21:46:31 +0200 (CEST)
Subject: [Cocci] Find expressions of given type
In-Reply-To: <20150914082905.GA11348@kaficko.joja.cz>
References: <20150914082905.GA11348@kaficko.joja.cz>
Message-ID: <alpine.DEB.2.02.1509142146270.2048@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I think Peter gave some good suggestions, so I will just add a few hints.

> I would like to write something like:
> 
> @@
> expression struct A* E;
> @@
> 
> ...
> +E
> ...

If you want to match an expression E, don't put ... ... around it.  Just 
put the expression E itself.  The way you have the ...s it means since the 
beginning of the function (for the first one) and up to the end of the 
fnuction (for the second one).  ... also has a semantics of "shortest 
path", meaning that there is an implicit constraint that the ... doesn't 
match E.  So you would only get functions that have only one occurrence of 
E.  One way to get around this is to put when any on the ...  But in your 
case, and even easier solution is to just drop them completely.

> and match every occurence of not only variables of the given type, but
> also an expression.
> 
> I was first trying to find some hint in the doc, found 
> expression struct *E;

Yeah, this was intended as a special case, because struct * is not a real 
type.

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

Not sure what you mean by config, but you can declare a metavariable as

t E;

for any type t.  No need for "expression" in this case.

The next problem, though, is where it is going to get the type information 
from.  No problem for local variables, but it can be a problem for 
structure fields.  By default, Coccinelle only includes header files that 
have th same name as the .c file, ie processing of foo.c will include 
foo.h.  If you need more, you can use the command line option 
--all-includes, which will include all of the header files mentioned 
explicitly in the .c file, or even --recursive-includes, which does the 
same but proceeds recursively.  The more header files you include, though, 
the more parsing work will have to be done, and the more time it will 
take.  So you are better off avoiding --recursive-includes if possible.

julia
