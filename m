From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 29 Nov 2017 12:21:19 +0100 (CET)
Subject: [Cocci] Recursive matches / returning lists from scripting code
 back to coccinelle
In-Reply-To: <80bb156f70ad4db195a386716dadfef6@konrad-technologies.de>
References: <80bb156f70ad4db195a386716dadfef6@konrad-technologies.de>
Message-ID: <alpine.DEB.2.20.1711291217460.3214@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 29 Nov 2017, Pesth Florian wrote:

> Hello everybody,
>
> first of all thanks a lot for your very nice tool, it has already been proven very useful!
>
> Sorry, if this is covered in the grammar documentation and I have overlooked it, I'm a new user to coccinelle.
>
> Is it possible to define rules in a recursive way? I want to match a function where subsequent function calls call a certain function (in this case "malloc"). Using scripting or a different way would also be fine if I can achieve this.

Look at demos/iteration.cocci.  This is discussed in "Advanced SmPL" at
http://coccinelle.lip6.fr/papers.php.


>
> The patch below the mail is programmed for just two levels, but what I'd really would want is going as deep as possible. If applied to the C code below the patch, the output on my system yields:
>
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> HANDLING: src/a.c
> ISR function ISR_func1 line 5 file src/a.c calling function other_func->malloc
> ISR function ISR_func1 line 5 file src/a.c calling function other_func->other_func2->malloc
>
> On another note, is it possible to pass whole lists from python or OCaml
> script code back to coccinelle and generate several dependent rules on
> it? I know I can use the value of one variable from python as a
> metavariable for a following rule (Although the order of matching is not
> entirely clear to me: When the python code depends on one rule and
> another rule depends on the metavariable created by this python code,
> are there multiple passes over the code? Or is it possible to trigger
> this somehow? I'm lacking still some understanding of the internal
> mechanism of coccinelle).

No.  There is no way to create several environments from a single
invocation of a script rule.  All you can do is extend the existing
environment that caused the rule to be executed in the first place.
Probably you just want a global list or hash table containing your
information.  You can also make metavariable constraints that involve
scripting code that could involve your global list or hash table.  For
example:

identifier i : script:ocaml() { Hashtbl.mem some_functions i };

The script code should return true or false.

julia

>
> Best regards and thanks!
> Florian Pesth
>
> Semantic patch:
>
> @findisr@
> expression E;
> identifier isrfunction != NULL;
> @@
> ISR_SetHandler(E, isrfunction)
>
> @mallocfunc@
> identifier malloc_func;
> @@
> malloc_func(...){
> ...
> malloc(...);
> ...
> }
>
> @findmalloc extends findisr@
> position p;
> identifier mallocfunc.malloc_func;
> @@
> isrfunction(...){@p
> ...
> malloc_func(...);
> ...
> }
>
> @script:python@
> isrfunction << findisr.isrfunction;
> p << findmalloc.p;
> malloc_func << mallocfunc.malloc_func;
> @@
> print "ISR function %s line %s file %s calling function %s->malloc" % (isrfunction, p[0].line, p[0].file, malloc_func)
>
> @cmallocfunc@
> identifier mallocfunc.malloc_func;
> identifier cmalloc_func;
> @@
> cmalloc_func(...){
> ...
> malloc_func(...);
> ...
> }
>
> @findcmalloc extends findisr@
> position p;
> identifier cmallocfunc.cmalloc_func;
> @@
> isrfunction(...){@p
> ...
> cmalloc_func(...);
> ...
> }
>
> @script:python@
> isrfunction << findisr.isrfunction;
> p << findcmalloc.p;
> cmalloc_func << cmallocfunc.cmalloc_func;
> malloc_func << mallocfunc.malloc_func;
> @@
> print "ISR function %s line %s file %s calling function %s->%s->malloc" % (isrfunction, p[0].line, p[0].file, cmalloc_func, malloc_func)
>
> Example C File:
> void other_func(int something);
> void other_func2(int something);
>
> void ISR_func1(int something)
> {
>     other_func(something);
> }
>
> void Init_ISR(void)
> {
>     int hello;
>     ISR_SetHandler(hello, ISR_func1);
> }
>
> void other_func(int something)
> {
>     malloc(sizeof(double)*something);
>     other_func2(something);
> }
>
> void other_func2(int something)
> {
>     malloc(sizeof(double)*something);
> }
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
