Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC4AC47258
	for <cocci@archiver.kernel.org>; Sat, 20 Jan 2024 21:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=aLyOhQr3iN/L4ULpUgDrbX9u1EDxEeONAWsqwCNe/IY=;
  b=R/uKUFYcb24pyL7u6QkC9CbOtFp8MfJGc/iOLDf+NzicbpZfvn1FJc+L
   QvAlf8v2fpA/j8FJ/rWquaQyBvwWPT+bIKuZQKnTcOf11QfjdbTdIUHx0
   +112Ra6mtc8u+dXxsaDVtfBUayUtRTG0i6TuhZ4A4tFb9nFKo352fmLX1
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.05,208,1701126000"; 
   d="scan'208";a="147744049"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2024 22:20:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F2C5CE0CD6; Sat, 20 Jan 2024 22:20:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 55F04E0035
	for <cocci@sympa.inria.fr>; Sat, 20 Jan 2024 22:20:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aLyOhQr3iN/L4ULpUgDrbX9u1EDxEeONAWsqwCNe/IY=;
  b=glBUkyZGQwPfjO/e2MF/Bb9T7i7TeWW10fRFH98M70+pyvgRzxTRlojP
   wnwOetgYbFRlrH+MAtSIeEB4ShXqBfQQrW1zzifIMF4+uIZv5D+LXoZft
   yM6E94v35xubzr8nF/PHhnCsEalUtMNa4wfdxSQ/xd9tRrrdSCUJTThj5
   o=;
X-IronPort-AV: E=Sophos;i="6.05,208,1701126000"; 
   d="scan'208";a="77364056"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 22:20:27 +0100
Date: Sat, 20 Jan 2024 22:20:26 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Li Zhijian <lizhijian@fujitsu.com>
cc: linux-kernel@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>, 
    cocci@inria.fr
In-Reply-To: <20240119062057.4026888-1-lizhijian@fujitsu.com>
Message-ID: <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] coccinelle: device_attr_show: Adapt to the
 latest Documentation/filesystems/sysfs.rst
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1459
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/alpine.DEB.2.22.394.2401202217550.3267%40hadrien>



On Fri, 19 Jan 2024, Li Zhijian wrote:

> Adapt description, warning message and MODE=patch according to the latest
> Documentation/filesystems/sysfs.rst:
> > show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> > the value to be returned to user space.
>
> After this patch:
> When MODE=report,
>  $ make coccicheck COCCI=scripts/coccinelle/api/device_attr_show.cocci M=drivers/hid/hid-picolcd_core.c MODE=report
>  <...snip...>
>  drivers/hid/hid-picolcd_core.c:304:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
>  drivers/hid/hid-picolcd_core.c:259:9-17: WARNING: please use sysfs_emit or sysfs_emit_at
>
> When MODE=patch,
>  $ make coccicheck COCCI=scripts/coccinelle/api/device_attr_show.cocci M=drivers/hid/hid-picolcd_core.c MODE=patch
>  <...snip...>
>  diff -u -p a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
>  --- a/drivers/hid/hid-picolcd_core.c
>  +++ b/drivers/hid/hid-picolcd_core.c
>  @@ -255,10 +255,12 @@ static ssize_t picolcd_operation_mode_sh
>   {
>          struct picolcd_data *data = dev_get_drvdata(dev);
>
>  -       if (data->status & PICOLCD_BOOTLOADER)
>  -               return snprintf(buf, PAGE_SIZE, "[bootloader] lcd\n");
>  -       else
>  -               return snprintf(buf, PAGE_SIZE, "bootloader [lcd]\n");
>  +       if (data->status & PICOLCD_BOOTLOADER) {
>  +               return sysfs_emit(buf, "[bootloader] lcd\n");
>  +       }
>  +       else {
>  +               return sysfs_emit(buf, "bootloader [lcd]\n");
>  +       }
>   }
>
>   static ssize_t picolcd_operation_mode_store(struct device *dev,
>  @@ -301,7 +303,7 @@ static ssize_t picolcd_operation_mode_de
>   {
>          struct picolcd_data *data = dev_get_drvdata(dev);
>
>  -       return snprintf(buf, PAGE_SIZE, "hello world\n");
>  +       return sysfs_emit(buf, "hello world\n");
>   }
>
>   static ssize_t picolcd_operation_mode_delay_store(struct device *dev,
>
> CC: Julia Lawall <Julia.Lawall@inria.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>
> CC: cocci@inria.fr
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2:
> - changed title from coccinelle: device_attr_show.cocci: update description and warning message
> - Fix MODE=patch
> - Extract patch from the patch set[1] so that maintainer can accept it separately.

Applied.

I subsequently simplified the patch case to contain the following:

-              snprintf(BUF, SZ, FORMAT
+              sysfs_emit(BUF, FORMAT
                               ,...);

This also works for the case where there are only three arguments.
It has the benefit that the change is recognized as a line replacement, so
no extra {} are added when the call is in an if branch.

julia



> [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> ---
>  scripts/coccinelle/api/device_attr_show.cocci | 22 +++++++++++--------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
> index a28dc061653a..634514937e63 100644
> --- a/scripts/coccinelle/api/device_attr_show.cocci
> +++ b/scripts/coccinelle/api/device_attr_show.cocci
> @@ -1,10 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  ///
>  /// From Documentation/filesystems/sysfs.rst:
> -///  show() must not use snprintf() when formatting the value to be
> -///  returned to user space. If you can guarantee that an overflow
> -///  will never happen you can use sprintf() otherwise you must use
> -///  scnprintf().
> +///  show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> +///  the value to be returned to user space.
>  ///
>  // Confidence: High
>  // Copyright: (C) 2020 Denis Efremov ISPRAS
> @@ -30,15 +28,21 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
>
>  @rp depends on patch@
>  identifier show, dev, attr, buf;
> +expression BUF, SZ, FORMAT, STR;
>  @@
>
>  ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	<...
> +(
>  	return
> --		snprintf
> -+		scnprintf
> -			(...);
> +-		snprintf(BUF, SZ, FORMAT, STR);
> ++		sysfs_emit(BUF, FORMAT, STR);
> +|
> +	return
> +-		snprintf(BUF, SZ, STR);
> ++		sysfs_emit(BUF, STR);
> +)
>  	...>
>  }
>
> @@ -46,10 +50,10 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
>  p << r.p;
>  @@
>
> -coccilib.report.print_report(p[0], "WARNING: use scnprintf or sprintf")
> +coccilib.report.print_report(p[0], "WARNING: please use sysfs_emit or sysfs_emit_at")
>
>  @script: python depends on org@
>  p << r.p;
>  @@
>
> -coccilib.org.print_todo(p[0], "WARNING: use scnprintf or sprintf")
> +coccilib.org.print_todo(p[0], "WARNING: please use sysfs_emit or sysfs_emit_at")
> --
> 2.29.2
>
>
