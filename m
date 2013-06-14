From: mmarek@suse.cz (Michal Marek)
Date: Fri, 14 Jun 2013 15:25:22 +0200
Subject: [Cocci] [PATCH] scripts: Coccinelle script for
	pci_free_consistent()
In-Reply-To: <20130508230308.Horde.hkDwg5wWGGBzmzKnqIjUhg1@wimap.feld.cvut.cz>
References: <20130508230308.Horde.hkDwg5wWGGBzmzKnqIjUhg1@wimap.feld.cvut.cz>
Message-ID: <51BB19C2.4030208@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 8.5.2013 23:03, strnape1 at fel.cvut.cz wrote:
> Created coccinelle script for reporting missing pci_free_consistent() calls.
> 
> Signed-off-by: Petr Strnad <strnape1@fel.cvut.cz>

Julia, Nicolas, any comments about this patch?

Thanks,
Michal

> ---
> diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci  
> b/scripts/coccinelle/free/pci_free_consistent.cocci
> new file mode 100644
> index 0000000..43600cc
> --- /dev/null
> +++ b/scripts/coccinelle/free/pci_free_consistent.cocci
> @@ -0,0 +1,52 @@
> +/// Find missing pci_free_consistent for every pci_alloc_consistent.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2013 Petr Strnad.  GPLv2.
> +// URL: http://coccinelle.lip6.fr/
> +// Keywords: pci_free_consistent, pci_alloc_consistent
> +// Options: --no-includes --include-headers
> +
> +virtual report
> +virtual org
> +
> + at search@
> +local idexpression id;
> +expression x,y,z,e;
> +position p1,p2;
> +type T;
> +@@
> +
> +id = pci_alloc_consistent at p1(x,y,&z)
> +... when != e = id
> +if (id == NULL || ...) { ... return ...; }
> +... when != pci_free_consistent(x,y,id,z)
> +    when != if (id) { ... pci_free_consistent(x,y,id,z) ... }
> +    when != if (y) { ... pci_free_consistent(x,y,id,z) ... }
> +    when != e = (T)id
> +    when exists
> +(
> +return 0;
> +|
> +return 1;
> +|
> +return id;
> +|
> +return at p2 ...;
> +)
> +
> + at script:python depends on report@
> +p1 << search.p1;
> +p2 << search.p2;
> +@@
> +
> +msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on  
> line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
> +coccilib.report.print_report(p2[0],msg)
> +
> + at script:python depends on org@
> +p1 << search.p1;
> +p2 << search.p2;
> +@@
> +
> +msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on  
> line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
> +cocci.print_main(msg,p1)
> +cocci.print_secs("",p2)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
