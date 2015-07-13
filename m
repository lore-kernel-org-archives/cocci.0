From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 13 Jul 2015 07:00:02 -0400 (EDT)
Subject: [Cocci] Error predicate determination with SmPL?
In-Reply-To: <55A39908.6060600@users.sourceforge.net>
References: <55A36680.1020707@users.sourceforge.net>
 <55A39908.6060600@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1507130657040.2561@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 13 Jul 2015, SF Markus Elfring wrote:

> > The semantic patch language can also be used to find
> > specific return statements in the source files.
> > How can this software help to find all of them
> > within a function implementation?
> >
> > How are the chances to improve static source code analysis
> > possibilities for such a purpose?
>
> A simple SmPL filter approach like the following works
> already as expected to some degree.
>
> @returns@
> expression express;
> identifier work;
> type return_type;
> @@
>  return_type work(...)
>  {
>   ... when any
> - return express;

The when any's are not needed.  ... follows the control flow, so there is
nothing after a return.

>   ... when any
>  }
>
>
> elfring at Sonne:~/Projekte/Coccinelle/Probe> spatch.opt -sp-file show_returns1.cocci API-test1.c
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> HANDLING: API-test1.c
> diff =
> --- API-test1.c
> +++ /tmp/cocci-output-6241-92ed9e-API-test1.c
> @@ -2,10 +2,8 @@
>
>  int my_status(void)
>  {
> -  return 1;
>  }
>
>  int main(void)
>  {
> -  return my_status();
>  }
>
>
> I see further software development challenges here.
>
> 1. Do I need to specify a SmPL constraint like "non-void"
>    for such a script?

It seems pointless.  If the code is returning something and the return
type is void, then the problem is elsewhere.

> 2. The expression which is used for a specific return statement
>    can be assigned to a SmPL metavariable in an other script variant.
>    I would appreciate if I could process the extracted data
>    in a more structured way somehow.

I have no idea what you want to do.  You can get the AST if you write a
script using OCaml:

(stringrep,astrep) << r.express;

julia
