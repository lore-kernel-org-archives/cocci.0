From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 20 Jul 2018 07:33:42 +0200 (CEST)
Subject: [Cocci] [PATCH v3] coccinelle: suggest replacing
 strncpy+truncation by strscpy
In-Reply-To: <1532047018-23754-1-git-send-email-asmadeus@codewreck.org>
References: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
 <1532047018-23754-1-git-send-email-asmadeus@codewreck.org>
Message-ID: <alpine.DEB.2.20.1807200731240.2349@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 20 Jul 2018, Dominique Martinet wrote:

> Using strscpy instead of strncpy+truncation is simpler and fixes part
> of the following class of new gcc warnings:
>
>     drivers/gpu/drm/i915/intel_tv.c: In function ?intel_tv_get_modes?:
>     drivers/gpu/drm/i915/intel_tv.c:1358:3: error: ?strncpy? specified bound 32 equals
>     destination size [-Werror=stringop-truncation]
>        strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: all warnings being treated as errors
>
> Note that this is not a proper fix for this warning. The warning was
> intended to have developers check the return code of strncpy and
> act in case of truncation (print a warning, abort the function or
> something similar if the original string was not nul terminated);
> the change to strscpy only works because gcc does not handle the
> function the same way.
>
> A previous version of this patch suggested to use strlcpy instead,
> but strscpy is preferred because it does not read more than the given
> length of the source string unlike strlcpy, which could read after the
> end of the buffer in case of unterminated string.
>
> strscpy does however not clear the end of the destination buffer, so
> there is a risk of information leak if the full buffer is copied as is
> out of the kernel - this needs manual checking.

As fasr as I can tell from lkml, only one of these patches has been
accepted?  There was also a concern about an information leak that there
was no response to.  Actually, I would prefer that more of the generated
patches are accepted before accepting the semantic patch, for something
that is not quite so obviously correct.

julia



>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> v2:
>  - Use strscpy instead of strlcpy, as strlcpy can read after the number
> of requested bytes in the source string, and none of the replaced users
> want to know the source string size length
>  - Add longer semantic patch information, warning in particular for
> information leak
>  - Lowered Confidence level to medium because of the possibility of
> information leak, that needs manual checking
>  - Fix spacing of the diff section and removed unused virtual context
>
> v3:
>  - Add license/copyright
>  - Rewording of commit message
>
> I didn't see many other remarks, but kept SUGGESTION as discussed.
> I didn't move all virtuals in a single line because none of the other
> kernel patch do it, and still do not see any advantage of moving the
> string to not use a variable so kept that as well.
>
> This should hopefully be the last version :)
>
>  .../coccinelle/misc/strncpy_truncation.cocci  | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/strncpy_truncation.cocci
>
> diff --git a/scripts/coccinelle/misc/strncpy_truncation.cocci b/scripts/coccinelle/misc/strncpy_truncation.cocci
> new file mode 100644
> index 000000000000..7732cde23a85
> --- /dev/null
> +++ b/scripts/coccinelle/misc/strncpy_truncation.cocci
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/// Use strscpy rather than strncpy(dest,..,sz) + dest[sz-1] = '\0'
> +///
> +//# This makes an effort to find occurences of strncpy followed by forced
> +//# truncation, which can generate gcc stringop-truncation warnings when
> +//# source and destination buffers are the same size.
> +//# Using strscpy will always do that nul-termination for us and not read
> +//# more than the maximum bytes requested in src, use that instead.
> +//#
> +//# The result needs checking that the destination buffer does not need
> +//# its tail zeroed (either cleared beforehand or will never leave the
> +//# kernel) so as not to leak information
> +//
> +// Confidence: Medium
> +// Copyright: (C) 2018  Dominique Martinet
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual report
> +virtual org
> +
> + at r@
> +expression dest, src, sz;
> +position p;
> +@@
> +
> +strncpy at p(dest, src, sz);
> +dest[sz - 1] = '\0';
> +
> + at script:python depends on org@
> +p << r.p;
> +@@
> +
> +msg = "strncpy followed by truncation can be strscpy, if the destination buffer does not need to be fully overwritten"
> +cocci.print_main(msg, p)
> +
> + at script:python depends on report@
> +p << r.p;
> +@@
> +
> +msg = "SUGGESTION: strncpy followed by truncation can be strscpy, if the destination buffer does not need to be fully overwritten"
> +coccilib.report.print_report(p[0], msg)
> +
> + at ok depends on patch@
> +expression r.dest, r.src, r.sz;
> +@@
> +
> +- strncpy
> ++ strscpy
> +   (dest, src, sz);
> +- dest[sz - 1] = '\0';
> --
> 2.17.1
>
>
