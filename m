From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Mon, 3 Jul 2017 15:36:02 +0200
Subject: [Cocci] [PATCH] coccinelle: api: detect unnecessary le16_to_cpu
In-Reply-To: <1498937290-12285-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1498937290-12285-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20170703133602.ejcdu35ku3i63cj2@earth>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On Sat, Jul 01, 2017 at 09:28:10PM +0200, Julia Lawall wrote:
> As reported by Sebastian Reichel, i2c_smbus_read_word_data() returns native
> endianness for little-endian bus (it basically has builtin
> le16_to_cpu). Calling le16_to_cpu on the result breaks support on big
> endian machines by converting it back.

Thanks, you are fast :)

> This semantic patch give no reports on kernel code currently, but the
> issue is somewhat obscure and has occurred in a sumitted patch, so it could
> be good to have a check for it.

Ok, so problem is not as bad as I feared. I found a few issues with
simple git grep, though:

git grep -C100 i2c_smbus_read_word_data | grep le16_to_cpu
git grep -C100 i2c_smbus_write_word_data | grep cpu_to_le16

It returned just a few files on v4.12 and all of them look buggy
after manual inspection:

 * drivers/macintosh/windfarm_lm75_sensor.c (line 71)
 * drivers/macintosh/windfarm_smu_sat.c (line 80-91)
 * drivers/gpio/gpio-pca953x.c (line 190-192)
 * drivers/power/supply/bq24735-charger.c
   - fixed in linux-next by 48f680c0a9ca
 * drivers/power/supply/sbs-battery.c
   - fixed in linux-next by a1bbec72f9fe

> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
> 
> The rule could easily be extended with more such functions.  Let me know if
> anything else should be taken into account.

I guess the write function should also be covered.

-- Sebastian

>  scripts/coccinelle/api/smbus_word.cocci |   45 ++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/scripts/coccinelle/api/smbus_word.cocci b/scripts/coccinelle/api/smbus_word.cocci
> new file mode 100644
> index 0000000..b167cf0
> --- /dev/null
> +++ b/scripts/coccinelle/api/smbus_word.cocci
> @@ -0,0 +1,45 @@
> +/// i2c_smbus_read_word_data() returns native endianness for little-endian
> +/// bus (it basically has builtin le16_to_cpu). Calling le16_to_cpu on the
> +/// result breaks support on big endian machines by converting it back.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2017 Julia Lawall, Inria. GPLv2.
> +// URL: http://coccinelle.lip6.fr/
> +// Options: --no-includes --include-headers
> +// Keywords: i2c_smbus_read_word_data, le16_to_cpu
> +
> +virtual context
> +virtual org
> +virtual report
> +
> +// ----------------------------------------------------------------------------
> +
> + at r depends on context || org || report exists@
> +expression e, x;
> +position j0, j1;
> +@@
> +
> +* x at j0 = i2c_smbus_read_word_data(...)
> +... when != x = e
> +* le16_to_cpu at j1(x)
> +
> +// ----------------------------------------------------------------------------
> +
> + at script:python r_org depends on org@
> +j0 << r.j0;
> +j1 << r.j1;
> +@@
> +
> +msg = "le16_to_cpu not needed on i2c_smbus_read_word_data result."
> +coccilib.org.print_todo(j0[0], msg)
> +coccilib.org.print_link(j1[0], "")
> +
> +// ----------------------------------------------------------------------------
> +
> + at script:python r_report depends on report@
> +j0 << r.j0;
> +j1 << r.j1;
> +@@
> +
> +msg = "le16_to_cpu not needed on i2c_smbus_read_word_data result around line %s." % (j1[0].line)
> +coccilib.report.print_report(j0[0], msg)
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170703/eb6ac49e/attachment-0001.asc>
