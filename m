From: keescook@chromium.org (Kees Cook)
Date: Tue, 26 Apr 2016 15:30:20 -0700
Subject: [Cocci] [PATCH] coccicheck: add a test for repeat copy_from_user
In-Reply-To: <20160426222442.GA8104@www.outflux.net>
References: <20160426222442.GA8104@www.outflux.net>
Message-ID: <CAGXu5j+-XPdjsVzr+4rmmv-DJpB0BH+VasTmsH5DuG74_q83gA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Apr 26, 2016 at 3:24 PM, Kees Cook <keescook@chromium.org> wrote:
> This is usually a sign of a resized request. This adds a check for
> potential races or confusions. The check isn't 100% accurate, so it
> needs some manual review.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/coccinelle/tests/reusercopy.cocci | 36 +++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 scripts/coccinelle/tests/reusercopy.cocci
>
> diff --git a/scripts/coccinelle/tests/reusercopy.cocci b/scripts/coccinelle/tests/reusercopy.cocci
> new file mode 100644
> index 000000000000..53645de8ae95
> --- /dev/null
> +++ b/scripts/coccinelle/tests/reusercopy.cocci
> @@ -0,0 +1,36 @@
> +/// Recopying from the same user buffer frequently indicates a pattern of
> +/// Reading a size header, allocating, and then re-reading an entire
> +/// structure. If the structure's size is not re-validated, this can lead
> +/// to structure or data size confusions.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2016 Kees Cook, Google. License: GPLv2.
> +// URL: http://coccinelle.lip6.fr/
> +// Comments:
> +// Options: -no_includes -include_headers
> +
> +virtual report
> +virtual org
> +
> + at cfu_twice@
> +position p;
> +identifier src;
> +expression dest1, dest2, size1, size2, offset;
> +@@
> +
> +*copy_from_user(dest1, src, size1)
> + ... when != src = offset
> +     when != src += offset
> +*copy_from_user at p(dest2, src, size2)
> +
> + at script:python depends on org@
> +p << cfu_twice.p;
> +@@
> +
> +cocci.print_main("potentially dangerous second copy_from_user()",p)
> +
> + at script:python depends on report@
> +p << cfu_twice.p;
> +@@
> +
> +coccilib.report.print_report(p[0],"potentially dangerous second copy_from_user()")
> --
> 2.6.3
>
>
> --
> Kees Cook
> Chrome OS & Brillo Security

And here's the current (noisy) output:

./arch/powerpc/platforms/powernv/opal-prd.c:248:6-20: potentially
dangerous second copy_from_user()
./sound/isa/sb/sb16_csp.c:391:7-21: potentially dangerous second
copy_from_user()
./drivers/gpu/drm/tegra/drm.c:361:6-20: potentially dangerous second
copy_from_user()
./fs/exec.c:537:7-21: potentially dangerous second copy_from_user()
./drivers/char/lp.c:387:7-21: potentially dangerous second copy_from_user()
./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2149:6-20:
potentially dangerous second copy_from_user()
./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2247:6-20:
potentially dangerous second copy_from_user()
./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2292:6-20:
potentially dangerous second copy_from_user()
./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2332:6-20:
potentially dangerous second copy_from_user()
./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2355:6-20:
potentially dangerous second copy_from_user()
./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2396:6-20:
potentially dangerous second copy_from_user()
./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2429:6-20:
potentially dangerous second copy_from_user()
./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2481:6-20:
potentially dangerous second copy_from_user()
./arch/ia64/kernel/perfmon.c:4833:11-25: potentially dangerous second
copy_from_user()
./drivers/staging/i4l/icn/icn.c:1048:7-21: potentially dangerous
second copy_from_user()
./drivers/misc/mic/vop/vop_vringh.c:775:9-23: potentially dangerous
second copy_from_user()
./drivers/misc/mic/vop/vop_vringh.c:944:6-20: potentially dangerous
second copy_from_user()
./fs/coda/psdev.c:128:6-20: potentially dangerous second copy_from_user()
./fs/coda/psdev.c:174:12-26: potentially dangerous second copy_from_user()
./drivers/hid/hid-picolcd_debugfs.c:283:6-20: potentially dangerous
second copy_from_user()
./fs/aio.c:1610:15-29: potentially dangerous second copy_from_user()
./fs/splice.c:1459:6-20: potentially dangerous second copy_from_user()
./kernel/kexec_core.c:815:12-26: potentially dangerous second copy_from_user()
./kernel/kexec_core.c:752:12-26: potentially dangerous second copy_from_user()
./drivers/scsi/3w-9xxx.c:691:5-19: potentially dangerous second copy_from_user()
./drivers/scsi/3w-xxxx.c:921:5-19: potentially dangerous second copy_from_user()
./drivers/platform/chrome/cros_ec_dev.c:145:5-19: potentially
dangerous second copy_from_user()
./sound/drivers/opl3/opl3_synth.c:204:6-20: potentially dangerous
second copy_from_user()
./drivers/scsi/megaraid.c:3465:5-19: potentially dangerous second
copy_from_user()
./drivers/scsi/aacraid/commctrl.c:116:5-19: potentially dangerous
second copy_from_user()
./drivers/staging/lustre/lustre/obdclass/linux/linux-module.c:116:5-19:
potentially dangerous second copy_from_user()
./drivers/scsi/dpt_i2o.c:1847:6-20: potentially dangerous second
copy_from_user()
./drivers/net/tun.c:1947:6-20: potentially dangerous second copy_from_user()
./drivers/net/tun.c:2078:6-20: potentially dangerous second copy_from_user()
./drivers/net/tun.c:2094:6-20: potentially dangerous second copy_from_user()
./drivers/net/tun.c:2137:6-20: potentially dangerous second copy_from_user()
./drivers/acpi/custom_method.c:54:5-19: potentially dangerous second
copy_from_user()
./drivers/hwtracing/stm/core.c:533:5-19: potentially dangerous second
copy_from_user()
./drivers/scsi/3w-sas.c:764:5-19: potentially dangerous second copy_from_user()
./drivers/isdn/hysdn/hysdn_procconf.c:133:6-20: potentially dangerous
second copy_from_user()
./drivers/isdn/hysdn/hysdn_procconf.c:160:7-21: potentially dangerous
second copy_from_user()
./drivers/isdn/i4l/isdn_ppp.c:875:7-21: potentially dangerous second
copy_from_user()
./drivers/isdn/isdnloop/isdnloop.c:980:7-21: potentially dangerous
second copy_from_user()
./drivers/md/md.c:6965:6-20: potentially dangerous second copy_from_user()
./net/ipv4/tcp.c:2267:6-20: potentially dangerous second copy_from_user()
./drivers/md/dm-ioctl.c:1738:5-19: potentially dangerous second copy_from_user()

I think the check logic could be improved (e.g. doesn't notice "++"),
but I haven't had time to dig in much further...

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
