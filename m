From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 20 Jul 2015 13:37:04 +0200 (CEST)
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <55ACDC1C.1040005@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55ACDC1C.1040005@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1507201335030.2475@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 20 Jul 2015, SF Markus Elfring wrote:

> > Do you really need to use a regular expression here?
> > Why not use a disjunction in the pattern?
>
> Another source code analysis approach like the following might make
> the involved software design decisions a bit more clear.
>
>
> @show_unstored_return_values@
> identifier allocation =~ "^(?x)
> (?:
>    pthread_mutex_(?:try|un)?lock
> |
>    sigaction
> )$", structure_var, var, work;
> field element;
> struct structure_type;

This (at best) makes an expression-typed metavariable that can only match
a structure.

> type data_type, return_type;
> @@
>  return_type work(...)
>  {
>   <+...
> (
>   data_type var = allocation(...);
> |
>   structure_type structure_var = { ... .element = allocation(...) ... };

This uses that metavariable as a type rather than as an expression.

In any case, what you want is

identifier i;

and then struct i structure_var = { ... .element = allocation(...) ... };

> |
> (
>   var
> |
>   structure_var
> )
>   = allocation(...)
> |
> * (void) allocation(...);

I don't see any need for this case.  If someone has put void, it means
that thay have thought about the code, and decided that the return value
is not important.

julia

> |
> * allocation(...)
> )
>   ...+>
>  }
>
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt -sp-file show_unstored_return_values2.cocci unchecked_return_values1.c
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> 181 182
> Fatal error: exception Failure("meta: parse error: \n = File \"show_unstored_return_values2.cocci\", line 9, column 21,  charpos = 181\n    around = ';', whole content = struct structure_type;\n")
>
>
> How can this "surprise" be fixed?
>
>
>
> > How is it useful to match just thf function call.
>
> Does the following small source code example contain a few update candidates
> for further considerations?
>
> #include <pthread.h>
>
> static pthread_mutex_t my_lock = PTHREAD_MUTEX_INITIALIZER;
> static unsigned long my_counter = 1;
>
> void increment_a_shared_variable(void)
> {
>  pthread_mutex_lock(&my_lock);
>  ++my_counter;
>  pthread_mutex_unlock(&my_lock);
> }
>
>
>
> > This doesn't show anything about whether or not the return value is stored.
>
> Does the following SmPL script draft show another interesting application
> of the semantic patch language?
>
> @show_unstored_return_values@
> identifier allocation =~ "^(?x)
> (?:
>    pthread_mutex_(?:try|un)?lock
> |
>    sigaction
> )$", var, work;
> type data_type, return_type;
> @@
>  return_type work(...)
>  {
>   <+...
> (
>   data_type var = allocation(...);
> |
>   var = allocation(...)
> |
> * (void) allocation(...);
> |
> * allocation(...)
> )
>   ...+>
>  }
>
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt -sp-file show_unstored_return_values3.cocci unchecked_return_values1.c
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> HANDLING: unchecked_return_values1.c
> diff =
> --- unchecked_return_values1.c
> +++ /tmp/cocci-output-7564-385170-unchecked_return_values1.c
> @@ -5,7 +5,5 @@ static unsigned long my_counter = 1;
>
>  void increment_a_shared_variable(void)
>  {
> - pthread_mutex_lock(&my_lock);
>   ++my_counter;
> - pthread_mutex_unlock(&my_lock);
>  }
>
>
> How do you think about my imaginations for corresponding software improvements?
>
> Regards,
> Markus
>
