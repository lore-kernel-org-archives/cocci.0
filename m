From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 8 Jun 2015 23:13:47 +0200 (CEST)
Subject: [Cocci] Using or for structural #ifdefs
In-Reply-To: <20150608203717.GS23057@wotan.suse.de>
References: <20150608203717.GS23057@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1506082306420.2041@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 8 Jun 2015, Luis R. Rodriguez wrote:

> 
> An examle or SmPL patch (from upstream Coccinelle tests/orexp.cocci):
> 
> @@                                                                              
> expression E, F;                                                                
> @@                                                                              
>                                                                                 
> (                                                                               
> -  foo(E)                                                                       
> + 4                                                                             
> |                                                                               
> -  bar(F)                                                                       
> + 4                                                                             
> )  
> 
> This works nicely for code within functions, for backporting we at times
> need to use or clauses for code outside of functions. We can avoid the
> or statements when backporting but if we could use them it would provide
> the ability to produce unified diffs which are much more readible and
> would resemble more what humans would try to write. I'll explain with
> an example.

I don't think that or is the problem.  If you have:

+ foo();
(
- x();
+ y();
|
- m();
+ n();
)
+ foo2();

the disjunction will still only match one statement.  Of course, you could 
put between the calls to foo and foo2 something that would match two 
statements, and then that would match two statements.  Or something that 
would match one or two statements.

The problem for structure field initializations would seem to be that they 
are unordered.  That is, if you put an initialization for x and then an 
initialization for y, the C code might have x initialized before y or vice 
versa, and with arbitrary things between them.  So the #ifdef/#endif would 
very likely come out in undesirable places.

The problem for functions is that Coccinelle only sees one at a time.  It 
has no idea whether one function is before or after another, and whether 
they are contiguous or there is something between them.

Maybe this would be better done with some tool that is separate from 
Coccinelle.  There could be a danger of modifying #ifdefs that were in the 
original code.  If that would be a bad thing, then the tool could take the 
old and new code as inputs, and only eliminate ifdefs that are unique to 
the new code.

julia



> 
> So this works, one can for example apply this to the file on linux-next:
> 
> drivers/media/v4l2-core/videobuf2-dma-contig.c:
> 
> @ vb2_mem_ops @
> identifier s, get_dma, map_dma, unmap_dma, attach_dma, detach_dma;
> @@
> 
> struct vb2_mem_ops s = {
> 	.attach_dmabuf = attach_dma,
> 	.detach_dmabuf = detach_dma,
> 	.map_dmabuf = map_dma,
> 	.unmap_dmabuf = unmap_dma,
> 	.get_dmabuf = get_dma,
> };
> 
> @ mod_get_dma depends on vb2_mem_ops @
> identifier vb2_mem_ops.get_dma, vb2_mem_ops.attach_dma;
> @@
> 
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
>  get_dma(...)
>  {
>  	...
>  }
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
> 
> @ mod_op_get_dma depends on vb2_mem_ops @
> identifier s, vb2_mem_ops.get_dma;
> @@
> 
>  struct vb2_mem_ops s = {
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
>  	.get_dmabuf = get_dma,
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
> };
> 
> 
> This SmPL patch uses the needle-in-the-haystack strategy to first localize the
> backport we want to apply, but also uses this to the subsequent rules to #ifdef
> them out. The needle-in-the-haystack solution works for me if and only if all
> structural definitions are delcared, grammatically fortunately the order does
> not matter here though.
> 
> Can we use or clauses to make some of these optional? I tried but failed.
> 
> The same would apply to the other rules, right now I'd have to define a rule
> in order to be able for example to #idef out all routines as with rule mod_get_dma.
> It'd be for example convenient to just use or clauses in one rule. There's two
> things that could be done to help here, one is for Coccinelle to see the additional
> contigious #idefs and if they match assume it can skip an #ifdef and just join
> the two statements. That is to make something like this:
> 
> #ifdef FOO
> static int foo(void)
> {
> 	return 1;
> }
> #endif /* FOO */
> 
> #ifdef FOO
> static int bar(void)
> {
> 	return 2;
> }
> #endif /* FOO */
> 
> just be:
> 
> 
> #ifdef FOO
> static int foo(void)
> {
> 	return 1;
> }
> 
> static int bar(void)
> {
> 
> 	return 2;
> }
> #endif /* FOO */
> 
> This can be accomplished by 3 methods I think:
> 
> a) Having Coccinelle infer when it can do this based on code it is generating / modifying.
>    This might be rather complex to support I think.
> 
> b) Having Coccinelle allow SmPL rules to let you write structural or's on on both struct
>    declarations or function delcarations. This seems generally useful however I am not sure
>    of its feasability.
> 
> c) Having Coccinelle let you declare variables that Coccinelle can use to let you group
>    metavariables so that you can shorten the number of rules you have two write to #idef
>    out if the #idef is generic across the metavariables, and perhaps only if this feature
>    is used allow you to do the or'ing on the group variables. For example:
> 
> @ mod_all_dma_ops depends on vb2_mem_ops @
> identifier vb2_mem_ops.get_dma, vb2_mem_ops.map_dma, vb2_mem_ops.unmap_dma, vb2_mem_ops.attach_dma, vb2_mem_ops.detach_dma;
> group identifier any_vb2_mem_ops = { get_dma | map_dma | unmap_dma | attach_dma | detach_dma };
> @@
> 
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
>  any_vb2_mem_ops(...)
>  {
>  	...
>  }
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
> 
> c) might be more complex than I believe, but it sure would be nice to have (TM).
> 
>  Luis
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
