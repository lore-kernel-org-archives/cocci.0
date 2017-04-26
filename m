From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 26 Apr 2017 07:26:37 +0200 (CEST)
Subject: [Cocci] [PATCH] Coccinelle: api: Add offset_in_page.cocci
In-Reply-To: <1493175288-5279-1-git-send-email-vaishali.thakkar@oracle.com>
References: <1493175288-5279-1-git-send-email-vaishali.thakkar@oracle.com>
Message-ID: <alpine.DEB.2.20.1704260723380.5347@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 26 Apr 2017, Vaishali Thakkar wrote:

> Use of offset_in_page is preferable instead of open coding.
> This patch adds coccinelle script for suggesting the use of
> macro offset_in_page.

There are a lot of cases like the following where there were parentheses
around the original code and they are preserved in the result:

diff -u -p a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -340,7 +340,7 @@ static pte_t *get_from_cache(struct mm_s
 		/*
 		 * If we have taken up all the fragments mark PTE page NULL
 		 */
-		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
+		if ((offset_in_page(pte_frag)) == 0)
 			pte_frag = NULL;
 		mm->context.pte_frag = pte_frag;
 	}

I assume that offset_in_page is written properly so that outer parentheses
are not needed.  It should be sufficient to add () around the - lines in
the rule r1_patch.  Check that you don't lose any results.

julia


> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
> ---
>  scripts/coccinelle/api/offset_in_page.cocci | 77 +++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 scripts/coccinelle/api/offset_in_page.cocci
>
> diff --git a/scripts/coccinelle/api/offset_in_page.cocci b/scripts/coccinelle/api/offset_in_page.cocci
> new file mode 100644
> index 0000000..d083109
> --- /dev/null
> +++ b/scripts/coccinelle/api/offset_in_page.cocci
> @@ -0,0 +1,77 @@
> +/// Use offset_in_page instead of duplicating its implementation
> +///
> +// Confidence: High
> +// Copyright: (C) 2017 Vaishali Thakkar, Oracle. GPLv2.
> +// Options: --no-includes --include-headers
> +// Keywords: offset_in_page
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> + at r_patch depends on patch@
> +expression e;
> +identifier i;
> +@@
> +- unsigned long i = (unsigned long)e & ~PAGE_MASK;
> +...
> +- i
> ++ offset_in_page(e)
> +
> + at r1_patch depends on patch@
> +expression e1;
> +@@
> +
> +(
> +- (unsigned long)e1 & ~PAGE_MASK
> ++ offset_in_page(e1)
> +|
> +- (unsigned long)e1 % PAGE_SIZE
> ++ offset_in_page(e1)
> +)
> +
> + at r_context depends on !patch@
> +expression e;
> +identifier i;
> +position p;
> +@@
> +
> +* unsigned long i = (unsigned long)e at p & ~PAGE_MASK;
> +...
> +* i
> +
> + at r1_context depends on !patch@
> +expression e1;
> +position p1;
> +@@
> +
> +(
> +* (unsigned long)e1 at p1 & ~PAGE_MASK
> +|
> +* (unsigned long)e1 at p1 % PAGE_SIZE
> +)
> +
> + at script:python depends on org@
> +p << r_context.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for offset_in_page")
> +
> + at script:python depends on org@
> +p << r1_context.p1;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for offset_in_page")
> +
> + at script:python depends on report@
> +p << r_context.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for offset_in_page")
> +
> + at script:python depends on report@
> +p << r1_context.p1;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for offset_in_page")
> --
> 2.7.4
>
>
