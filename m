From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 26 Nov 2014 15:07:28 +0000
Subject: [Cocci] strange behaviour,
 failing to insert expression in valid C source file
Message-ID: <20141126150728.GH2361@bivouac.eciton.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi there,

I was asked to change an API in the Linux kernel by adding an optional
parameter in form of a pointer. So I reached for coccinelle to add
", NULL" to all existing callers. To do so, I used the following sp-file:
---
@@
expression E1;
@@

- of_find_node_by_path(E1)
+ of_find_node_by_path(E1, NULL)
---

This worked splendidly on all call sites in the kernel, except for two
in the of_resolve_phandles() function in drivers/of/resolver.c.
It looks like spatch becomes upset on encountering a variable with the
same name as an autodetected typedef. This can be confirmed with
--parse-c.

I've reduced my test case to the following:
---
phandle of_get_tree_max_phandle(void)
{
    return NULL;
}

void bar(void)
{
    struct device_node *node;
    phandle phandle;

    node = of_find_node_by_path("/__symbols__");
}
---

Running the command:
spatch --in-place --sp-file ../of.cocci foo.c
fails silently to update the file, and returns 0.

Tested on 1.0.0-rc22 and -rc12.

Thanks,

Leif
