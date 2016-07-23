From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 23 Jul 2016 23:03:46 +0200 (CEST)
Subject: [Cocci] [PATCH] Coccinelle: Script to replace allocate and
 memcpy with zalloc functions
In-Reply-To: <20160723210034.GA19346@amitoj-Inspiron-3542>
References: <20160723210034.GA19346@amitoj-Inspiron-3542>
Message-ID: <alpine.DEB.2.10.1607232302400.3027@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 24 Jul 2016, Amitoj Kaur Chawla wrote:

> This script finds instances of allocate and memcpy which can be
> replaced with a direct call to zalloc equivalent of a function.
>
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  scripts/coccinelle/api/zalloc.cocci | 556 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 556 insertions(+)
>  create mode 100644 scripts/coccinelle/api/zalloc.cocci
>
> diff --git a/scripts/coccinelle/api/zalloc.cocci b/scripts/coccinelle/api/zalloc.cocci
> new file mode 100644
> index 0000000..4f94e43
> --- /dev/null
> +++ b/scripts/coccinelle/api/zalloc.cocci
> @@ -0,0 +1,556 @@
> +/// Prefer zalloc functions instead of using allocate and memcpy.
> +///
> +// Confidence: High
> +// Copyright: (C) 2016 Amitoj Kaur Chawla
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> + at dma1 depends on patch && !context && !org && !report@
> +type T;
> +T *d;
> +statement S;
> +@@
> +
> +        d =
> +-            dma_pool_alloc
> ++            dma_pool_zalloc
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(T));
> +
> + at dma2 depends on patch && !context && !org && !report@
> +expression d;
> +statement S;
> +@@
> +
> +        d =
> +-            dma_pool_alloc
> ++            dma_pool_zalloc
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(*d));
> + at vz1 depends on patch && !context && !org && !report@
> +type T;
> +T *d;
> +statement S;
> +@@
> +
> +        d =
> +-            vmalloc
> ++            vzalloc
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(T));
> +
> + at vz2 depends on patch && !context && !org && !report@
> +expression d;
> +statement S;
> +@@
> +
> +        d =
> +-            vmalloc
> ++            vzalloc
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(*d));
> + at vzn1 depends on patch && !context && !org && !report@
> +type T;
> +T *d;
> +statement S;
> +@@
> +
> +        d =
> +-            vmalloc_node
> ++            vzalloc_node
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(T));
> +
> + at vzn2 depends on patch && !context && !org && !report@
> +expression d;
> +statement S;
> +@@
> +
> +        d =
> +-            vmalloc_node
> ++            vzalloc_node
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(*d));
> + at pci1 depends on patch && !context && !org && !report@
> +type T;
> +T *d;
> +statement S;
> +@@
> +
> +        d =
> +-            pci_alloc_consistent
> ++            pci_zalloc_consistent
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(T));
> +
> + at pci2 depends on patch && !context && !org && !report@
> +expression d;
> +statement S;
> +@@
> +
> +        d =
> +-            pci_alloc_consistent
> ++            pci_zalloc_consistent
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(*d));
> + at kmem1 depends on patch && !context && !org && !report@
> +type T;
> +T *d;
> +statement S;
> +@@
> +
> +        d =
> +-            kmem_cache_alloc
> ++            kmem_cache_zalloc
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(T));
> +
> + at kmem2 depends on patch && !context && !org && !report@
> +expression d;
> +statement S;
> +@@
> +
> +        d =
> +-            kmem_cache_alloc
> ++            kmem_cache_zalloc
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(*d));
> + at dma3 depends on patch && !context && !org && !report@
> +type T;
> +T *d;
> +statement S;
> +@@
> +
> +        d =
> +-            dma_alloc_coherent
> ++            dma_zalloc_coherent
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(T));
> +
> + at dma4 depends on patch && !context && !org && !report@
> +expression d;
> +statement S;
> +@@
> +
> +        d =
> +-            dma_alloc_coherent
> ++            dma_zalloc_coherent
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(*d));
> + at acpi1 depends on patch && !context && !org && !report@
> +type T;
> +T *d;
> +statement S;
> +@@
> +
> +        d =
> +-            acpi_os_allocate
> ++            acpi_os_allocate_zeroed
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(T));
> +
> + at acpi2 depends on patch && !context && !org && !report@
> +expression d;
> +statement S;
> +@@
> +
> +        d =
> +-            acpi_os_allocate
> ++            acpi_os_allocate_zeroed
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(*d));
> +
> +// ----------------------------------------------------------------------------
> +
> + at dma1_context depends on !patch && (context || org || report)@
> +type T;
> +statement S;
> +T *d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             dma_pool_alloc
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(T));
> +
> + at dma2_context depends on !patch && (context || org || report)@
> +statement S;
> +expression d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             dma_pool_alloc
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(*d));
> +
> + at vz1_context depends on !patch && (context || org || report)@
> +type T;
> +statement S;
> +T *d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             vmalloc
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(T));
> +
> + at vz2_context depends on !patch && (context || org || report)@
> +statement S;
> +expression d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             vmalloc
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(*d));
> +
> + at vzn1_context depends on !patch && (context || org || report)@
> +type T;
> +statement S;
> +T *d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             vmalloc_node
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(T));
> +
> + at vzn2_context depends on !patch && (context || org || report)@
> +statement S;
> +expression d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             vmalloc_node
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(*d));
> +
> + at pci1_context depends on !patch && (context || org || report)@
> +type T;
> +statement S;
> +T *d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             pci_alloc_consistent
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(T));
> +
> + at pci2_context depends on !patch && (context || org || report)@
> +statement S;
> +expression d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             pci_alloc_consistent
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(*d));
> +
> + at kmem1_context depends on !patch && (context || org || report)@
> +type T;
> +statement S;
> +T *d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             kmem_cache_alloc
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(T));
> +
> + at kmem2_context depends on !patch && (context || org || report)@
> +statement S;
> +expression d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             kmem_cache_alloc
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(*d));
> +
> + at dma3_context depends on !patch && (context || org || report)@
> +type T;
> +statement S;
> +T *d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             dma_alloc_coherent
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(T));
> +
> + at dma4_context depends on !patch && (context || org || report)@
> +statement S;
> +expression d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             dma_alloc_coherent
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(*d));
> +
> + at acpi1_context depends on !patch && (context || org || report)@
> +type T;
> +statement S;
> +T *d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             acpi_os_allocate
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(T));
> +
> + at acpi2_context depends on !patch && (context || org || report)@
> +statement S;
> +expression d;
> +position j0;
> +@@
> +
> +        d at j0 =
> +*             acpi_os_allocate
> +             (...);
> +        if (!d) S
> +*        memset(d, 0, sizeof(*d));
> +
> +// ----------------------------------------------------------------------------
> +
> + at script:python dma1_org depends on org@
> +j0 << dma1_context.j0;
> +@@
> +
> +msg = "Replace with dma_pool_zalloc."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python dma2_org depends on org@
> +j0 << dma2_context.j0;
> +@@
> +
> +msg = "Replace with dma_pool_zalloc."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python vz1_org depends on org@
> +j0 << vz1_context.j0;
> +@@
> +
> +msg = "Replace with vzalloc."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python vz2_org depends on org@
> +j0 << vz2_context.j0;
> +@@
> +
> +msg = "Replace with vzalloc."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python vzn1_org depends on org@
> +j0 << vzn1_context.j0;
> +@@
> +
> +msg = "Replace with vzalloc_node."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python vzn2_org depends on org@
> +j0 << vzn2_context.j0;
> +@@
> +
> +msg = "Replace with vzalloc_node."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python pci1_org depends on org@
> +j0 << pci1_context.j0;
> +@@
> +
> +msg = "Replace with pci_zalloc_consistent."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python pci2_org depends on org@
> +j0 << pci2_context.j0;
> +@@
> +
> +msg = "Replace with pci_zalloc_consistent."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python kmem1_org depends on org@
> +j0 << kmem1_context.j0;
> +@@
> +
> +msg = "Replace with kmem_cache_zalloc."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python kmem2_org depends on org@
> +j0 << kmem2_context.j0;
> +@@
> +
> +msg = "Replace with kmem_cache_zalloc."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python dma3_org depends on org@
> +j0 << dma3_context.j0;
> +@@
> +
> +msg = "Replace with dma_zalloc_coherent."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python dma4_org depends on org@
> +j0 << dma4_context.j0;
> +@@
> +
> +msg = "Replace with dma_zalloc_coherent."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python acpi1_org depends on org@
> +j0 << acpi1_context.j0;
> +@@
> +
> +msg = "Replace with acpi_os_allocate_zeroed."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python acpi2_org depends on org@
> +j0 << acpi2_context.j0;
> +@@
> +
> +msg = "Replace with acpi_os_allocate_zeroed."
> +coccilib.org.print_todo(j0[0], msg)
> +
> +// ----------------------------------------------------------------------------
> +
> + at script:python dma1_report depends on report@
> +j0 << dma1_context.j0;
> +@@
> +
> +msg = "Replace with dma_pool_zalloc."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python dma2_report depends on report@
> +j0 << dma2_context.j0;
> +@@
> +
> +msg = "Replace with dma_pool_zalloc."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python vz1_report depends on report@
> +j0 << vz1_context.j0;
> +@@
> +
> +msg = "Replace with vzalloc."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python vz2_report depends on report@
> +j0 << vz2_context.j0;
> +@@
> +
> +msg = "Replace with vzalloc."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python vzn1_report depends on report@
> +j0 << vzn1_context.j0;
> +@@
> +
> +msg = "Replace with vzalloc_node."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python vzn2_report depends on report@
> +j0 << vzn2_context.j0;
> +@@
> +
> +msg = "Replace with vzalloc_node."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python pci1_report depends on report@
> +j0 << pci1_context.j0;
> +@@
> +
> +msg = "Replace with pci_zalloc_consistent."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python pci2_report depends on report@
> +j0 << pci2_context.j0;
> +@@
> +
> +msg = "Replace with pci_zalloc_consistent."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python kmem1_report depends on report@
> +j0 << kmem1_context.j0;
> +@@
> +
> +msg = "Replace with kmem_cache_zalloc."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python kmem2_report depends on report@
> +j0 << kmem2_context.j0;
> +@@
> +
> +msg = "Replace with kmem_cache_zalloc."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python dma3_report depends on report@
> +j0 << dma3_context.j0;
> +@@
> +
> +msg = "Replace with dma_zalloc_coherent."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python dma4_report depends on report@
> +j0 << dma4_context.j0;
> +@@
> +
> +msg = "Replace with dma_zalloc_coherent."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python acpi1_report depends on report@
> +j0 << acpi1_context.j0;
> +@@
> +
> +msg = "Replace with acpi_os_allocate_zeroed."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python acpi2_report depends on report@
> +j0 << acpi2_context.j0;
> +@@
> +
> +msg = "Replace with acpi_os_allocate_zeroed."
> +coccilib.report.print_report(j0[0], msg)
> +
> --
> 1.9.1
>
>
