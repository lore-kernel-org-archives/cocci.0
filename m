From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 May 2015 15:39:03 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: api: add vma_pages.cocci
In-Reply-To: <1431821187-21648-1-git-send-email-dmitry.kalinkin@gmail.com>
References: <1431821187-21648-1-git-send-email-dmitry.kalinkin@gmail.com>
Message-ID: <alpine.DEB.2.02.1505171526430.2077@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 17 May 2015, Dmitry Kalinkin wrote:

> This semantic patch replaces explicit computations of vma page count
> with explicit function call.

Thanks!

> Signed-off-by: Dmitry Kalinkin <dmitry.kalinkin@gmail.com>
> ---
>  scripts/coccinelle/api/vma_pages.cocci | 66 ++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 scripts/coccinelle/api/vma_pages.cocci
> 
> diff --git a/scripts/coccinelle/api/vma_pages.cocci b/scripts/coccinelle/api/vma_pages.cocci
> new file mode 100644
> index 0000000..2b7a748
> --- /dev/null
> +++ b/scripts/coccinelle/api/vma_pages.cocci
> @@ -0,0 +1,66 @@
> +/// Use vma_pages function on vma object instead of explicit computation.

Add an extra /// here.

> +//  Confidence: High
> +//  Keywords: vma_pages vma
> +
> +//  Based on resource_size.cocci
> +
> +virtual context
> +virtual patch
> +virtual org
> +virtual report
> +
> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> + at r_context depends on context && !patch && !org@

Add && !report here

> +struct vm_area_struct *vma;
> +@@
> +
> +* (vma->vm_end - vma->vm_start) >> PAGE_SHIFT
> +
> +//----------------------------------------------------------
> +//  For patch mode
> +//----------------------------------------------------------
> +
> + at r_patch1 depends on !context && patch && !org@

Add && !report here

> +struct vm_area_struct *vma;
> +@@
> +
> +- ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT)
> ++ vma_pages(vma)
> +
> + at r_patch2 depends on !context && patch && !org@
> +struct vm_area_struct *vma;
> +@@
> +
> +- (vma->vm_end - vma->vm_start) >> PAGE_SHIFT
> ++ vma_pages(vma)

This rule is not needed.  An isomorphism will allow tha case with () 
around the whole thing to match the case where those parentheses are 
absent.

> +//----------------------------------------------------------
> +//  For org mode
> +//----------------------------------------------------------
> +
> + at r_org depends on !context && !patch && (org || report)@
> +struct vm_area_struct *vma;
> +position p;
> +@@
> +
> +  (vma->vm_end at p - vma->vm_start) >> PAGE_SHIFT
> +
> + at script:python depends on report@
> +p << r_org.p;
> +x << r_org.vma;
> +@@
> +
> +msg="ERROR: Missing vma_pages with %s" % (x)

I think that the message is a bit misleading.  Something like Use 
vma_pages would be better.

> +coccilib.report.print_report(p[0], msg)
> +
> + at script:python depends on org@
> +p << r_org.p;
> +x << r_org.vma;
> +@@
> +
> +msg="ERROR with %s" % (x)
> +msg_safe=msg.replace("[","@(").replace("]",")")
> +coccilib.org.print_todo(p[0], msg_safe)

The message could be the same in this case as in the previous one.

It may be good to put below the keywords:

// Comments:
// Options: --all-includes

This rule relies on type information, ie knowing whether something has 
type struct vm_area_struct *, so having more include files available may 
make that more apparent.  On the other hand, if you think the referenced 
thing will always be a local variable (as opposed to a structure field), 
then just using the current C file should be good enough, and it will be 
faster without the --all-includes option.

I tried the rule replacing struct vm_area_struct *vma; by expression vma 
and got a couple of results on other types.  One could wonder if that code 
could be improved in some way.

julia
