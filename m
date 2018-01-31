From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 31 Jan 2018 18:38:55 +0100 (CET)
Subject: [Cocci]
	=?utf-8?q?=5Bv2=5D_Coccinelle=3A_zalloc-simple=3A_Delete_?=
	=?utf-8?b?ZnVuY3Rpb24g4oCca21lbV9jYWNoZV9hbGxvY+KAnSBmcm9tIFNtUEwg?=
	=?utf-8?q?rules?=
In-Reply-To: <243e83a2-ae0c-2dd2-7f8f-83ac0978cc0e@users.sourceforge.net>
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
 <243e83a2-ae0c-2dd2-7f8f-83ac0978cc0e@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801311836320.3707@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 31 Jan 2018, SF Markus Elfring wrote:

> > I removed the blank line at EOF,
> > then applied to linux-kbuild/misc.
>
> I have taken another look at this script for the semantic patch language.
> I imagined that I could refactor the shown SmPL disjunctions a bit.
> But I noticed then that these SmPL rules contain a development mistake.
>
> The deletion for a call of the function ?memset? depends on the specification
> that a size determination is passed by the expression ?E1?.
> The function ?kmem_cache_alloc? was specified despite of the technical detail
> that this function does not get a parameter passed which would correspond
> to such a size information.
> https://elixir.free-electrons.com/linux/v4.15/source/tools/testing/radix-tree/linux/slab.h#L14
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/tools/testing/radix-tree/linux/slab.h?id=537659c08a7da298aa748854f65f2aa1f31b1378#n14
>
> Thus I suggest to remove it from the first two SmPL rules and omit the rule ?r4?.
> Will the rule set be more consistent then?

If E1 is not bound by the kem_cache_alloc rule, then it will match
anything.  The user can check if it is appropriate.

Another option would be to use the type of the variable storing the result
of the call to compute the expected size.  Feel free to send a patch.

julia
