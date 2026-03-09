Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A51F3C268
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZscBoKzOYu/nr99vWYOcH+ci6xWJkBlwCFCtDm31rUM=;
  b=QktdwbChEVzWv6k0/bIf4VbDZiIEVJjkCO6c7FtmrLn/eGcUMvQiSrzb
   XQLtRcQzmb8SIHkmN0NS1qTQw4EgsNgsxB4CYhL0LPgG3X8TKHkj6ypma
   gvdHGw9Zf9jb2PQRuzqj5KvMuxD1IWkGi1CT/Y960O+tr8D+I9mwRkGe4
   c=;
X-CSE-ConnectionGUID: 1ZO6334EQPSN6Xa6zDZYEA==
X-CSE-MsgGUID: jsjGTMX7Tj+LFHuHTijUXQ==
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
   d="scan'208";a="266911074"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 15:05:24 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1E59183133; Mon,  9 Mar 2026 15:05:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 15FF183128
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 15:05:16 +0100 (CET)
X-CSE-ConnectionGUID: fsuDEPGRSEuDwb0h0fAJQw==
X-CSE-MsgGUID: 7uB8zhtMTgyYm/gkS/SN5Q==
IronPort-SDR: 69aed39b_Kh6e8v0CpiN5kqq2ePsIUAKtZymuNC5BHhSzGrJodVpLU4P
 GTlBMCwIb/JQZOMxRvUxIfCCa2+7wbrO/OxjJIA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G7BACb0q5pg07ASNlaHgEBCxIMQIFFCwKCP4EHXjQEC?=
 =?us-ascii?q?0kDhFWPU4MNg1KPEYh5gVWBfQIPAQMBDUoEAQIEAQEDBIIMgi5GAo0hAh4HA?=
 =?us-ascii?q?QQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBASEZB?=
 =?us-ascii?q?w47hk8NSQEQAYIHAYEkgSYBAQEBAQEBAQEBAQEdAg06RAIBAyMdAQERJgEPC?=
 =?us-ascii?q?w4MAhgOAgJWBgEUAQGCfgGCIgEGEAEDNgcNrVCBMoEBggwBAQbaZB8sIlmBZ?=
 =?us-ascii?q?wMGFYEKLoVvgmUBhXQ7g0V6Jw+BVUSBPAuCeD6CQwcXBBiBRoNbgmmCJoEOk?=
 =?us-ascii?q?xtSeBwDWSwBVRMXCwcFgSNDAyovLSNLBS0dgSMhHQ8IFB9YGwcFEiEqgUp4g?=
 =?us-ascii?q?gEPhmp5Ay5eGg4iAjpcSj4KAVoFgiQCAQttPTcJCxsEPY5gPoNugU1So2Cie?=
 =?us-ascii?q?zQHgjiBZ4FkDIoulT8GEy+XUg6TCy6YWCKNZ5YZhR+BaDqBXDMaJIMCAQEBM?=
 =?us-ascii?q?U8DGQ+OIRmEGoRgw3ZFMgIBAQwsAgcBCgEBAwmFRgEBggaKUIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 GmlUVbOwhkRkdiJndsQLTgjssqi6jQyB+rE
IronPort-HdrOrdr: A9a23:qnm2d6MdR87cn8BcTiijsMiBIKoaSvp037BN7TEVdfU1SL37qy
 nKpp8mPHDP5wr5NEtPpTnjAsi9qALnhP1ICOAqVN/JMWXbUQ2TXfpfBODZowEIdReOitJ15O
 NLe7VzBtvqHTFB/L/HyTj9OdAszLC8gceVrNab43BxTRx7L4FMhj0JdTqzIwlTTAlCCYF8MJ
 aA58xLzgDQHUg/X4CDHX8LX+3Ozue77K4OuCR2fSLPPjP+8A9By9XBYn6l4is=
X-Talos-CUID: 9a23:1Fwoi2xPBo6KzekCUVPvBgUaAd0JX0Xy9kz9PmOnAz5pELO8a2aPrfY=
X-Talos-MUID: 9a23:VZgtewSCSu/y0aZxRXSzmRsyJsd0xpihGXEI1poFgI6/E3FJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="140816899"
X-MGA-submission: =?us-ascii?q?MDHNe5TwdEgs3Kursdz65kkr+Ph/9RzE1bTMUP?=
 =?us-ascii?q?wA/52LmUFE2TEhMBDge/tQDmSUX5W4eiz6aFhQ4quEi5KB3WkIzI2C6v?=
 =?us-ascii?q?okuQw8i2ni5wqhdB5Ec7L+WM6Ex6YAqQAlcv/rYRhjx6yAkaY4kfbOZp?=
 =?us-ascii?q?V1SgfSCtGUEOuGYF0a3S6P/w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:05:16 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwA1O-1vghMo092a-00wdgW; Mon, 09
 Mar 2026 15:05:10 +0100
Message-ID: <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de>
Date: Mon, 9 Mar 2026 15:05:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alejandro Colomar <alx@kernel.org>, cocci@inria.fr
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Kees Cook <kees@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <cover.1772752564.git.alx@kernel.org>
 <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cbfBFrP7d4RBd77+HVO6D+0xMPFFda4CYtd58UU3mhx+WHzHlgu
 n/yvkDibE+mVXeVV0s6sryWxQqARzjWy6ryHTQofwxJLiURL1JNHypMKRi8r9/+DfkVxHsj
 iCRGj/m7ImQQ3fZVXq4vR1rcukSiZ/pqlfsbXYaGz17ZXtkJw/Voyx+7AWIlrapRejQhw3i
 5bByUUGTjeBr0efVIhbiQ==
UI-OutboundReport: notjunk:1;M01:P0:M+j2LJ7XOVg=;RZsuozZKD1oU7dFogTt43fjUVmS
 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
 3rVTC8HOpIX5FKK8pqcNM0hfjcP+7
Subject: Re: [cocci] [PATCH v2] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3360
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/GCSkNlp_-EMmO76ulnbc9g>

=E2=80=A6
> ---
>  scripts/coccinelle/misc/array_end.cocci | 74 +++++++++++++++++++++++++
=E2=80=A6

Some contributors would appreciate patch version descriptions.
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.0-rc3#n310


May a subdirectory name be omitted from the subject prefix?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/sc=
ripts/coccinelle/


=E2=80=A6
> +// Comments: No known false positives, but has a few false negatives

Would such information motivate for any further software refinements?


=E2=80=A6
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING should use ARRAY_END")
=E2=80=A6

I suggest to reuse the message also from the SmPL report rule.

Regards,
Markus
