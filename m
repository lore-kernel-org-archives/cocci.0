Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7102CEFCBD4
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2026 07:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WKGR5raHbHUpKKTFsl7i/XXyOJ/Q7ZGDUNid58baSv8=;
  b=U5Gz0oBaIju42jQR6l3zTaB9wFHc6Fjx6JYW6FRxjGEbhx+jJRxIY//r
   /FkgyX9ILcMl9moLyQ6On/xhXl6tE1toen5UWCpSgxN6ndHjifhfjT1/3
   LjFLX2tfn/vo62F1N69qR255zqfMtY2RQXIQIuzsz+lUiIVs6C9sWlJjf
   Y=;
X-CSE-ConnectionGUID: KSFcbCAZSU+4/6CJgeLc1w==
X-CSE-MsgGUID: INTxd9biT16xHgG+ksGhvg==
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
X-IronPort-AV: E=Sophos;i="6.23,123,1770591600"; 
   d="scan'208";a="267879233"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Mar 2026 08:19:26 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id F264E80EF0; Mon, 16 Mar 2026 08:19:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5DAC180EC5
	for <cocci@sympa.inria.fr>; Mon, 16 Mar 2026 08:19:20 +0100 (CET)
X-CSE-ConnectionGUID: oQweYFZtTn+dy0sX/f34sw==
X-CSE-MsgGUID: ToisEVL2TreEhTjCfW6rjA==
IronPort-SDR: 69b7aef7_bPljw0/+fBEDT1MsP/NyWLj6/7LD6echFDxeZtCfSxXsr59
 xkyHOPxRRfAhwZTbE5lkC93dbNB/vMqCy2AYfNA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HfBAC5rbdpgAQP49RaHgEBCxIMggULgkGBZTQEC0mEW?=
 =?us-ascii?q?I9TgiSEO4c8h1WIeYFVgX0CDwEDAQ1OAQIEAQEDBIUAAo0jAh4HAQQxCA4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIwQZAQERJgEECwsODAIYDgICV?=
 =?us-ascii?q?gYBFAEBgn6CIwEGEAEDDycHtUZ/M4EBggwBAQbaZB8sIlmBZwkVgQouhW+CZ?=
 =?us-ascii?q?QGFdDuDRXonD4FVRIE8gwM+hEODW4JpgiaBDos2hztSeBwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SMQMwMqLy0jSwUtHXAMJxIPHQ8IFB9YGwcFEiEqTniCAQ+GZXkDLl4aDiICO?=
 =?us-ascii?q?VxKPgoBUgWCLAInAgELbT03BgMLGwQ9ji08gi1hyVo0B4I4gWeBZAyfbQYTL?=
 =?us-ascii?q?5dSDpMLLphYIqkfgWoCNoFcMxokgzZPAxkPjiGEM8kFRTI9AgcCBw0DC4VEA?=
 =?us-ascii?q?QGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 jMNxq7ka5sePMv31h46ArGftJvHEQzcUIIVyhA=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:DTCz4KOWHQIHRMBcThOjsMiBIKoaSvp037BN7TESdfU1SL36qy
 nAppkmPHPP5Ar5O0tBpTnjAse9qBrnnPYfi7X5VY3SOTUO01HIEGgN1+TfK2qKIVyYygcL79
 YFT0C1YOeAa2STTq7BkXCF+6xL+qj9zEjy792utUuECWpRGt5dB8IQMHfiLqWzLDM2eKbQ0/
 Knl7Z6mwY=
X-Talos-CUID: 9a23:KvRts238078CxpvZyGlCBbxfHfk6f0zz/mvsJQy0GD5yePqbEgOL5/Yx
X-Talos-MUID: 9a23:8bHA0Aqa4LkYl1oMRcYezw1lNdxF3YD0NFoAvJU6ueKKCnJqOR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,123,1770591600"; 
   d="scan'208";a="141395606"
X-MGA-submission: =?us-ascii?q?MDErqBNBnLnGGXG/A88qwSbYVQu1/gBSGqfE/N?=
 =?us-ascii?q?0yICg+t2UnGfMb1cXY3i7CIZtccfpwvFIF04cRyLcrqodZdfKjiX7XmM?=
 =?us-ascii?q?4JzLuhn5OW4Y5OVeuffJAwbD8naYP2D45QRLhxwsI9g2dFWlB+mmpsJ2?=
 =?us-ascii?q?MfRTLtd++s9BtfpRMA3VwaIw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:19:19 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwNW-1vR2iV33he-00iRE8; Mon, 16
 Mar 2026 08:18:57 +0100
Message-ID: <0c5eded9-f56a-434c-a04f-b229945ae4c5@web.de>
Date: Mon, 16 Mar 2026 08:18:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alejandro Colomar <alx@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 cocci@inria.fr
Cc: Nicolas Palix <nicolas.palix@imag.fr>, Kees Cook <kees@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <cover.1772752564.git.alx@kernel.org>
 <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
 <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de> <aa7XD-rk_KWQvTQX@devuan>
 <abblv3nCut5aRk7q@devuan>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <abblv3nCut5aRk7q@devuan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s8sk/QIMxfjWshwAUv1tDXuyOp59kxbBz0zlGbiEymGRSGOdBxH
 lhCWWjiHOi0kDdjEA3a9F2cCV/n5xYzCeJdlS+D4hluQksY9ueOouXCEq9ZvYu3267pSojx
 FQj/R19kImmIVs2ADVemagQNjyHCGMf0pcs5a8JUdzHwK7/uz6NGLN/p6EM1I8z5zh0kDK/
 zaSYi1MpzkEDx6uRw63sQ==
UI-OutboundReport: notjunk:1;M01:P0:4RocGfUYtWY=;+1PkbcZ9Pj+1P2vy+L25TxkRbSO
 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
Subject: Re: [cocci] [v2] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3432
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/bWrjyC2elLT-txoSmPNHpA>

> Here are more false negatives that I found manually.  The semantic patch
> didn't find them.

Thanks for your clarification approach.


>                    Does anyone know how we could improve it

The corresponding knowledge is evolving.


>                                                             or why it
> didn't find them?

I suggest to refine case distinctions.
Can further test cases help to achieve a better understanding for the affe=
cted data processing?


=E2=80=A6
> 	+++ b/arch/powerpc/kernel/rtas.c
> 	@@ -555,10 +555,8 @@ static struct rtas_function rtas_function_table[] =
__ro_after_init =3D {
> 		},
> 	 };
> 	=20
> 	-#define for_each_rtas_function(funcp)                                 =
      \
> 	-       for (funcp =3D &rtas_function_table[0];                        =
       \
> 	-            funcp < &rtas_function_table[ARRAY_SIZE(rtas_function_tabl=
e)]; \
> 	-            ++funcp)
> 	+#define for_each_rtas_function(f)                                     =
\
> 	+       for (f =3D rtas_function_table; f < ARRAY_END(rtas_function_tab=
le); ++f)

Are there development challenges to reconsider for macro definitions?


=E2=80=A6
> 	+++ b/drivers/net/wireless/intel/iwlwifi/mei/net.c
> 	@@ -43,7 +43,7 @@ static bool iwl_mei_rx_filter_eth(const struct ethhdr=
 *ethhdr,
> 			return false;
> 	=20
> 		for (filt =3D &filters->eth_filters[0];
> 	-            filt < &filters->eth_filters[0] + ARRAY_SIZE(filters->eth_=
filters);
> 	+            filt < ARRAY_END(filters->eth_filters);
> 		     filt++) {
> 			/* Assume there are no enabled filter after a disabled one */
> 			if (!(filt->flags & SAP_ETH_FILTER_ENABLED))

Will any loops become better supported?

Regards,
Markus
