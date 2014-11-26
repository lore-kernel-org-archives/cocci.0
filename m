From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 26 Nov 2014 16:19:22 +0100 (CET)
Subject: [Cocci] strange behaviour,
 failing to insert expression in valid C source file
In-Reply-To: <20141126150728.GH2361@bivouac.eciton.net>
References: <20141126150728.GH2361@bivouac.eciton.net>
Message-ID: <alpine.DEB.2.10.1411261616560.2493@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 26 Nov 2014, Leif Lindholm wrote:

> Hi there,
>
> I was asked to change an API in the Linux kernel by adding an optional
> parameter in form of a pointer. So I reached for coccinelle to add
> ", NULL" to all existing callers. To do so, I used the following sp-file:
> ---
> @@
> expression E1;
> @@
>
> - of_find_node_by_path(E1)
> + of_find_node_by_path(E1, NULL)
> ---
>
> This worked splendidly on all call sites in the kernel, except for two
> in the of_resolve_phandles() function in drivers/of/resolver.c.
> It looks like spatch becomes upset on encountering a variable with the
> same name as an autodetected typedef. This can be confirmed with
> --parse-c.
>
> I've reduced my test case to the following:
> ---
> phandle of_get_tree_max_phandle(void)
> {
>     return NULL;
> }
>
> void bar(void)
> {
>     struct device_node *node;
>     phandle phandle;
>
>     node = of_find_node_by_path("/__symbols__");
> }

Yes, it is known behavior.  Thanks for the test program.  I will make a
note of it and maybe it can be improved.

Indeed the parser doesn't complain about parse errors unless you use the
--verbose-parsing flag.  Otherwise, it would likely complain about all
sorts of things that are not relevant to the transformation that you want
to do.  However, indeed when it does not do something you expect, then it
is not ideal.

julia

> ---
>
> Running the command:
> spatch --in-place --sp-file ../of.cocci foo.c
> fails silently to update the file, and returns 0.
>
> Tested on 1.0.0-rc22 and -rc12.
>
> Thanks,
>
> Leif
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
