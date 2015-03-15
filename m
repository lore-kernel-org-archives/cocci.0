From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 15 Mar 2015 16:08:32 +0100 (CET)
Subject: [Cocci] Questions about the functions provided for Python by
 Coccinelle in stuart thesis
In-Reply-To: <BAY181-W53BDBF4BD06EA826963C29B8050@phx.gbl>
References: <BAY181-W53BDBF4BD06EA826963C29B8050@phx.gbl>
Message-ID: <alpine.DEB.2.02.1503151602190.2254@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 15 Mar 2015, ZhouYuan wrote:

> Hi,?
> I am an undergraduate student and learning Coccinelle at present. I have
> been stuck by the problems I met when I tried to do the experiments of the
> article Hunting bugs with coccinelle (Henrik
> Stuart,?http://coccinelle.lip6.fr/papers/stuart_thesis.pdf). The functions
> provided for Python showed in Chapter 3.4 on page 43 such
> as?get_subexpressions(expr_repr),?set_expr_cfg() and?gcp(expr_repr,
> pos_repr) are not found in the source code of coccinelle (version
> 1.0.0-rc10) and the call to those functions would lead to errors.?
> 
> So I am confused about how to use those functions. It would be a great
> hornor for me if someone would give any suggestions. ?It is really improtant
> to my project.?

I'm sorry, but it seems that those functions were just implemented for the 
thesis, and are not part of Coccinelle.  If you have an expression, it 
should be possible to collect its subexpressions as follows:

@parent@
expression e;
@@

fn(...)@e // assuming you are interested in subexpressions of calls to fn

@child@
expression e1 <= e;
@@

e1

@script:python@
e << parent.e;
e1 << child.e1;
@@

python code to do whatever you want with the expression and subexpression

-----------

The above may not be very efficient because it will take a call to fn, and 
then match its subexpressions wherever they occur.

Alternatively, if you are good@ocaml, then you can do:

@parent@
expression e;
@@

fn(...)@e

@script:ocaml@
(e,e_ast) << parent.e;
@@

do what you want with e_ast

----------------------

e_ast is the abstract syntax tree of e.  The relevant types are found in 
parsing_c/ast_c.ml.

julia
