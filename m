Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DDEEFCD99
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+bpqzBndy1gJ+F2JoC2Ew/16XFgs6z5eCQyxldiZgvM=;
  b=HwEHrpJYEUQpxk3lLl4ozgx/8OaMqWHGpuzhx007CqD9mksDeThLtFRF
   WgutJIIU41RvvMfGTZACrNz9tq9Tcnph3zCeYhVryNfOx+CbKSlACOdiT
   3wBQnXCynLWFPvdU5IIFC/GyeuHZT8XTfIScztZK3/LNX7TQ+cPqqEvGF
   0=;
X-CSE-ConnectionGUID: aJpJ3Z+7STGTFaWANjrBUg==
X-CSE-MsgGUID: ieE00SyiSS2nFR76Xi0sbA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266869568"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 12:17:06 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 62E3C83062; Mon,  9 Mar 2026 12:17:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9FC5083057
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 12:17:03 +0100 (CET)
X-CSE-ConnectionGUID: YOXedwhzTdypqQqUsPRxAg==
X-CSE-MsgGUID: qWJ++lFLTNOAQMEyLQytiQ==
IronPort-SDR: 69aeac2f_wPmDt1lTxxVUnIhVBJyuURErPkdATvjyxtPw9KskEa3wjUP
 oa0Fi/+RMqKgo7mvqRX8V66IdrCKNpqqT2tlqdA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HoBACwq65pg07ASNlaHgEBCxIMQIFFC4JBaB9eNAQLS?=
 =?us-ascii?q?QOEVY9Tgw2DUpgKgVWBfQIPAQMBDUoEAQIEAQEDBIQ6RgKNIQIeBwEEMQgOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEhGQcOO4ZPD?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAg06RAIBAyMdAQERJgEPCw4MAhgOAgJWB?=
 =?us-ascii?q?gEUAQGCfgGCIgEGEAEDNgcNrHCBMoEBggwBAQbaZB8sIlmBZwMGFYEKLoVvg?=
 =?us-ascii?q?mUBhi8JglOBYycPgVVEgTyCSzg+gkoXBBiBRoNbgmmCJoEOkxtSeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSMQMwMgCi8tAhQNIg8aBS0dcAwnEg8dDwgUH1gbBwUSISqBSniCA?=
 =?us-ascii?q?Q+GankDLl4aDiICOgNZSj4KAVoFgiQCAQttPTcGAwsbBD2OYD6DboFNNxuTT?=
 =?us-ascii?q?J4slGM0B4I4gWeBZAyKLpU/BhMvhASNE4Y7DpMLLphYIo1nlhmFH4FpATiBX?=
 =?us-ascii?q?DMaJIM2TwMZD44hGYQahGDDeUUyAgEBDCwCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 EYiODqWHtps
IronPort-Data: A9a23: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
 N0AgKXOxMk9sfl5nc3A3ene
IronPort-HdrOrdr: A9a23:VNO7zqkpzXM0YPTcSdDT6AtIYcbpDfL43DAbv31ZSRFFG/FwWf
 re+8jzpiWE7Qr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQ+VxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:qZbxeWPKova0+u5DaQ5X+UILGtIZfmzF1U7JHlSAM3ZAR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AlAgtOw9OaSS1R1be/qtu4gGQf95XweftDG4prbM?=
 =?us-ascii?q?hkvChGD1UAiaBjQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="140791160"
X-MGA-submission: =?us-ascii?q?MDHNI4kgW1SruOW3KwniRpo3iOZFMLr9gdMoES?=
 =?us-ascii?q?NT986qjgSzhpHJXA4cgM/W/Wf9O1HH6FAYlY5wgjQsGGbADHu1MaNFKe?=
 =?us-ascii?q?7dr8xXxXcYuuFRZqmi7TRq0fr2iHOZR82DzNsWk64N4ZgxGigTQSU6/V?=
 =?us-ascii?q?89HoK97+AGh7J1z/aCadsbTw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 12:17:02 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CQh-1vYEDD0Ghx-015CNG; Mon, 09
 Mar 2026 12:17:02 +0100
Message-ID: <cab3d2a8-4c3f-45e6-9e7f-8bdca48a6209@web.de>
Date: Mon, 9 Mar 2026 12:17:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alejandro Colomar <alx@kernel.org>, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
References: <cover.1772752564.git.alx@kernel.org>
 <f1c9dff525752dc5a839760269a1c96d6e0870b4.1772752564.git.alx@kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Kees Cook <kees@kernel.org>
In-Reply-To: <f1c9dff525752dc5a839760269a1c96d6e0870b4.1772752564.git.alx@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ah4CMhuaf2Bep++Tl1PtGMhZ1KivVVnTxAP7I2BanGDC2O2jTYT
 HlV/Z5GWfRLn2usIwM3agaGPk8kp6aBSA0eIp8+yTEC3qyiwSinW7qiUif2KnNS54II9kf6
 eMO6tu2KDXQVLUZpf2dc63VaicDrqZBvWyC8ofXru9T6hBWhO7dg4tkVVEY9Sn8q0m7/hYz
 kvcmeyixUXDIL7iv39c5A==
UI-OutboundReport: notjunk:1;M01:P0:LryntZdtivY=;PeCRsnvfJpnjiPROhLMVDQgI4ZR
 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
 snoh6ehsWJZOaAfZoR/KhS6yh56nb
Subject: Re: [cocci] [PATCH] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3353
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/MmbG9JsfXALnF_4xOhlSQQ>

=E2=80=A6
> This script makes it easy to find more places where that macro should be
> used.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.0-rc3#n94


=E2=80=A6
> +++ b/scripts/coccinelle/misc/array_end.cocci
> @@ -0,0 +1,93 @@
=E2=80=A6


> +// Confidence: ???

I hope that a more reasonable value can be determined for this information=
.


=E2=80=A6
> +// Comments:

Please omit such an empty field.


=E2=80=A6
> +@i@
> +@@
> +
> +#include <linux/kernel.h>

I doubt that such an SmPL rule would be required.


> +
> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +

Please omit such extra comment lines.


> +@depends on i&&context@
> +type T;
> +T[] a;
> +expression b;
> +@@
> +(
> +* (a + ARRAY_SIZE(a))
> +|
> +* (&a[0] + ARRAY_SIZE(a))
> +|
> +* (&a[ARRAY_SIZE(a)])
> +|
> +* (&a[ARRAY_SIZE(a) - b])
> +)

Extra space characters may be omitted directly after SmPL asterisks.


=E2=80=A6
> +@r depends on (org || report)@

You may omit parentheses here.


=E2=80=A6
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +msg=3D"WARNING: Use ARRAY_END"
> +coccilib.report.print_report(p[0], msg)

Would the following command variant be a bit nicer?

coccilib.report.print_report(p[0], "WARNING: opportunity for ARRAY_END()")



By the way:
How do you think about to omit a cover letter for a single patch?

Regards,
Markus
