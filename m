From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 13 Jan 2018 17:24:22 +0100 (CET)
Subject: [Cocci] [PATCH] Coccinelle: alloc_cast: Add more memory
 allocating functions to the list
In-Reply-To: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <alpine.DEB.2.20.1801131724090.3470@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 13 Jan 2018, Himanshu Jha wrote:

> Add more memory allocating functions that are frequently used in the kernel
> code to the existing list and remove the useless casts where it is
> unnecessary.
>
> But preserve those casts having __attribute__ such as __force, __iomem,
> etc which are used by Sparse in the static analysis of the code.
>
> Also remove two blank lines at EOF.
>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  scripts/coccinelle/api/alloc/alloc_cast.cocci | 92 +++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 21 deletions(-)
>
> diff --git a/scripts/coccinelle/api/alloc/alloc_cast.cocci b/scripts/coccinelle/api/alloc/alloc_cast.cocci
> index 6c308ee..408ee38 100644
> --- a/scripts/coccinelle/api/alloc/alloc_cast.cocci
> +++ b/scripts/coccinelle/api/alloc/alloc_cast.cocci
> @@ -5,10 +5,11 @@
>  //# kmalloc, kzalloc, kcalloc, kmem_cache_alloc, kmem_cache_zalloc,
>  //# kmem_cache_alloc_node, kmalloc_node and kzalloc_node and removes
>  //# the casting as it is not required. The result in the patch case may
> -//#need some reformatting.
> +//# need some reformatting.
>  //
>  // Confidence: High
> -// Copyright: 2014, Himangi Saraogi  GPLv2.
> +// Copyright: (C) 2014 Himangi Saraogi GPLv2.
> +// Copyright: (C) 2017 Himanshu Jha GPLv2.
>  // Comments:
>  // Options: --no-includes --include-headers
>  //
> @@ -18,55 +19,104 @@ virtual patch
>  virtual org
>  virtual report
>
> + at initialize:python@
> +@@
> +import re
> +pattern = '__'
> +m = re.compile(pattern)
> +
> + at r1 depends on context || patch@
> +type T;
> +@@
> +
> +  (T *)
> +  \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
> +   kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
> +   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> +   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
> +   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
> +   kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> +
>  //----------------------------------------------------------
>  //  For context mode
>  //----------------------------------------------------------
>
> - at depends on context@
> -type T;
> + at script:python depends on context@
> +t << r1.T;
> +@@
> +
> +if m.search(t) != None:
> +        cocci.include_match(False)
> +
> + at depends on context && r1@
> +type r1.T;
>  @@
>
>  * (T *)
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
> -   kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\)(...)
> +   kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
> +   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> +   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
> +   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
> +   kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
>
>  //----------------------------------------------------------
>  //  For patch mode
>  //----------------------------------------------------------
>
> - at depends on patch@
> -type T;
> + at script:python depends on patch@
> +t << r1.T;
> +@@
> +
> +if m.search(t) != None:
> +        cocci.include_match(False)
> +
> + at depends on patch && r1@
> +type r1.T;
>  @@
>
>  - (T *)
> -  (\(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
> -   kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\)(...))
> +  \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
> +   kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
> +   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> +   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
> +   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
> +   kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
>
>  //----------------------------------------------------------
>  //  For org and report mode
>  //----------------------------------------------------------
>
> - at r depends on org || report@
> + at r2 depends on org || report@
>  type T;
>  position p;
>  @@
>
> - (T at p *)\(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
> -   kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\)(...)
> + (T at p *)
> +  \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
> +   kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
> +   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> +   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
> +   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
> +   kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
>
>  @script:python depends on org@
> -p << r.p;
> -t << r.T;
> +p << r2.p;
> +t << r2.T;
>  @@
>
> -coccilib.org.print_safe_todo(p[0], t)
> +if m.search(t) != None:
> +	cocci.include_match(False)
> +else:
> +	coccilib.org.print_safe_todo(p[0], t)
>
>  @script:python depends on report@
> -p << r.p;
> -t << r.T;
> +p << r2.p;
> +t << r2.T;
>  @@
>
> -msg="WARNING: casting value returned by memory allocation function to (%s *) is useless." % (t)
> -coccilib.report.print_report(p[0], msg)
> -
> -
> +if m.search(t) != None:
> +	cocci.include_match(False)
> +else:
> +	msg="WARNING: casting value returned by memory allocation function to (%s *) is useless." % (t)
> +	coccilib.report.print_report(p[0], msg)
> --
> 2.7.4
>
>
