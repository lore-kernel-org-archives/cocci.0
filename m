From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 11 May 2015 11:38:33 +0200 (CEST)
Subject: [Cocci] Question on dealing with parameters and arguments
In-Reply-To: <BAY181-W56C207434972A5F64436C7B8DB0@phx.gbl>
References: <BAY181-W56C207434972A5F64436C7B8DB0@phx.gbl>
Message-ID: <alpine.DEB.2.10.1505111129290.2393@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> For example, I want to judge whether the parameters and arguments of a
> function have the same type or the same number of elements. But it seems
> hard to obtain them as exactly what they are in C.?
>
> Also, I have noticed that there are two type in meta-variables called
> "parameter list" and "expression list". But I did not find the definition of
> them.

Maybe you want something like the following:

@def@
identifier f,i;
parameter list[n] ps;
type T;
@@

f(ps,T i,...) { ... }

@bad@
identifier def.f;
expression list[def.n] es;
type def.T;
T e;
expression e1;
position p;
@@

f(es,\(e\|e1 at p\),...)

@script:python@
p << bad.p;
f << def.f;
n << def.n;
@@

print "argument %s of %s on line %s has wrong type" % (n,f,p[0].line)

-----------------------------------------------

For checking the number of arguments, you could do:

@def@
parameter list[n] ps;
@@

f(ps) { ... }

@bad@
expression list[def.n] es;
expression list[m] es2;
@@

(
f(es)
|
f@p(es2)
)

// add appropriate python code here

-----------------------------------------------

Note that this wil only find problems where the definition and the use of
the function are in the same file.  To consider different files, you need
to use iteration, which is more complicated.  There is an example in
demos/iteration.cocci.  Iteration is also discussed in the talk here

http://coccinelle.lip6.fr/papers/cocciwk4_talk2.pdf

starting on slide 14.

julia
