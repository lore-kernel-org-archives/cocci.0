Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173DCC30653
	for <cocci@archiver.kernel.org>; Sun,  7 Jul 2024 12:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=igi917NboB7r59NURGnteiu8BGkQtwJuozqVHEinjrw=;
  b=tnCzTgqWAHDX9Ub/ottrygxkflBC+HhR2p5Nv9a4uC0xLGuSrvwzHAou
   sEnmoKYcW3+6/A90XPJST4YmLtYVJzz/42Pt3+SMeawY+TYbr4kxKK8LE
   iQylY8aBbFf3t+NpAFnrwJ5+Me3KtTk+NvzljwpfCYrw3x4YStchZ0Gk4
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.09,190,1716242400"; 
   d="scan'208";a="174318635"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jul 2024 14:14:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DAD37E004E; Sun,  7 Jul 2024 14:14:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 873C7E004E
	for <cocci@sympa.inria.fr>; Sun,  7 Jul 2024 14:14:24 +0200 (CEST)
IronPort-SDR: 668a8698_EE1C8Irmq5TdS9Qzcz4ii21tqJhf64bp2ScfAAqJCgAPngE
 XHpBwoB6kjPSXXl7Y2EitfZzezwwTva54+6RaHg==
X-IPAS-Result: =?us-ascii?q?A0H4FgDUhYpmh07ASNlagQmBT4JEYhpaMwQLSAglhCmPS?=
 =?us-ascii?q?IF1hGuPCohzgVaBQD4PAQMBDTsGAQIEAQEDAQOBSUKCdG2IJwIeBwEEMQgOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFdA2CY?=
 =?us-ascii?q?Bh3G3QwAgEBAQEBAQEBAQEBAQEBAQEBARcCDTpGJx0BAREmATQCJgJxAgEBg?=
 =?us-ascii?q?nwBgi8BAzEHDQatN4EygQGCDAEBBoJn13IfLCJXgWMDBoEaLogXGgEFZ4l3D?=
 =?us-ascii?q?4FVRIE8hgsXBIElgQaDDoJpiAoBhjVpiiyCFoNVhhwmC4x7gU8cA1khEwFVE?=
 =?us-ascii?q?xcLPh0CFgMbFAQwDwkLJikGOQISDAYGBlk0CQQjAwgEA0IDIHERAwQaBAsHd?=
 =?us-ascii?q?4MlBBNEA4E3iW+DOSmBcoQaCEOBAYNrgWsMYYlygT6BYoNLSoRTHUACAQttP?=
 =?us-ascii?q?TUJCxsGPal/hD8xEyyCE5NSsiQ0B4I2gWEFgV0MiH2BJJUnBhMvlzoOBpJsm?=
 =?us-ascii?q?GmLf4F3lUKFU4FpAjaBXDMaJIM2HzADGQ+OOoNhM4Rhxl9BNQIBOAIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYMmNIFKAQE?=
IronPort-PHdr: A9a23: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
 MM3hsFjqReqn7vXogc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QgSW36nGGN4ZJBs97PLexvI2RTnpDfL03DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ/+xoWZPwJk80kKQf3WB/B9iftWXdyQmVxeJZg7cKoQeNJ8SWzIc0uJ
 uIGJIObeEYY2Ibse/HwE2fD8sqxsWB/ZulnOHE0h5WPHpXgu1bjjuQEWygYzRLreR9dOIE/B
 Hw3KB6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3AK9CL2mrRo/8IaA7llWd0vhDmUeEEd3ni1kiJH2W?=
 =?us-ascii?q?DBXRSZaanZVOLqKwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AwiL6Nw82YztsrdeAaq+spbaQf9s3+4KeB2sqrcQ?=
 =?us-ascii?q?X5ZOHFwtaKWqA1g3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,190,1716242400"; 
   d="scan'208";a="174318625"
X-MGA-submission: =?us-ascii?q?MDEq5GMOekgJMFsqXH/g9BxrgtYmivjhock/Vc?=
 =?us-ascii?q?GKfLChUw9Zgp/TfIUBt6lvCQkIBXTT0xzXo8WBBuB68vYzLXJgUqZHOD?=
 =?us-ascii?q?O7WNWxKGYJyjCAd+L7VZOzB6PZbiB3kLcSxsUfDjMwgLW1CVQBJSczD8?=
 =?us-ascii?q?nGrMvHfHVfBwlrM3LWmEs1EA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 14:14:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720354455; x=1720959255; i=markus.elfring@web.de;
	bh=igi917NboB7r59NURGnteiu8BGkQtwJuozqVHEinjrw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b1+4jDojKHgf3G9JjFybmC3IBaajmqnjcZTyXgaD83MdP0M1Ze/xi08HBGnD+ecq
	 xVPj8pxcKaVR8YKBPnVJrkRyL3YHRElB+vhZmtrDVIEo0nCkNV+0geVtjsxrshiqX
	 IB7HFV+n7rGBXE21lal5JSZY75eNnMdatupa86dsxOHd8icdsi6X+2nyYSuFcTNcS
	 XapAJtvjDBaFgg7XGn3lIBOfE+Flya564Dpo55gRPB8QpOnpEui2m/C/JcqvE9xLl
	 L2WqpNEUbB8XcKcK4kWfqsJH5E4TxJ1GPvbQ+BrKCTgiIlhuUG59UIXSmD+tAz0KC
	 Z4QwYxSJKI3qaYgJTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MALeD-1sWnVs0YuJ-000gdy; Sun, 07
 Jul 2024 14:14:15 +0200
Message-ID: <8d145e35-33af-4f81-a77a-2bbc5c734045@web.de>
Date: Sun, 7 Jul 2024 14:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GIQ5JvBdyGUUvpqH48j4HBw++R5m/YZOGaSX19ecGXhSWT1lT6B
 amvYQpyQo5yx2w+nFKBrvltwtmChaUM4OXNnOoAqW0zIydUgp+yLdON677wjJC5nxaz/95t
 uJZQbYH2gcSbTKTiMsCIHAP6tllgxedIs8QdZorYaBPMbzuhdTej2PNhxt0USNRZz9I00bN
 YZaR9R24noJvgnZvBAQGw==
UI-OutboundReport: notjunk:1;M01:P0:/2Ru169QsOA=;SDEIFyXjuuvBsUVlqnmD0nONErf
 26kcnKiJAu0R3zCzTqibDhsX5Fb8HPLeP4s+X3QKV4m6tXZAf9DoiH+EO2Rrvh7Kk9Ubwjm1k
 nom3ZnyB/VLjw5dScd+483TjpenUdvzipIQkvppqihdmcTuoiqVXfY56/DEMZWNsyw6xFtaRd
 W+9HCbC/qiyE404/IKhxVWegeaFBlZHLt4XKa5qyqFg053S9BMRThjfmErvSdwnKE/kvSNx8J
 zn/cDjn55U9CSnf9dV2Y3pxQDPL+iDLFPgcckJBA3kJccyuTASQzceQQu2bkEMDXtJkOpePT4
 0rkC1bZ/FE83RsdOV8GzxiXflRA7Gd3vKko7a1gt/ZB7v2rZHqwtxQ/HhmWTiy6/HwakWwcxt
 hxpbOty0cTGix5HwBVRCtg0H1tpl08GIuM39Zs+NlEUtekQ5v4ikga1cORhqNV/zGNGmlyF34
 SxXguP7DaaJcTz4Dj2+3quEor1bvVeRfCV2/N77uDH/5fuEj8h7E+54fscKfZJh0J8sPKQyYV
 4bl9Ax7CDQVi2P4ceYchlVAjuNSC74gnbdGqr9F6tl6nPUyPNek6B2ct6cvpw+AYkDceqBdbJ
 XC87kOys21UNTupACpOz36jSRJ7jWK428EYHbOCGlFVbehyrYF2HI1L+cq6pSNikkcCzLpZYl
 P0f/L1JwBNql6HANfPNumGBOifJSpquDzX3TrehJDvy10tHyojGvTQ11p6h61JOCCRpcfm0RY
 zUiPgojQOmvhHpmc4tFz4gg4jkOmfq5tMPIsdTTzU0sLJGFoxuHa6jiA/ROmuDsKJzQp2xX4n
 xSXqczr4z+h2bcgG93XMWazGUebqHsJbIBVxTpdWhVc2k=
Subject: [cocci] Deleting unwanted semicolons (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1801
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/8d145e35-33af-4f81-a77a-2bbc5c734045%40web.de>

Hello,

A bit of patch review triggered further development ideas.

[PATCH v2 3/3] i2c: rcar: minor changes to adhere to coding style
https://lore.kernel.org/linux-kernel/Zop2vNCrzDmEKKiO@shikoro/
https://lkml.org/lkml/2024/7/7/136

See also:
https://elixir.bootlin.com/linux/v6.10-rc6/source/drivers/i2c/busses/i2c-r=
car.c#L189


Thus I constructed another tiny script variant for the semantic patch lang=
uage.


@deletion@
@@
 return ...;
 }
-;


Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20240703 && spatch drivers/i2c/busses/i2c-rcar.c =E2=80=A6/Projekte/C=
occinelle/janitor/delete_unwanted_semicolon.cocci
=E2=80=A6
minus: parse error:
  File "=E2=80=A6/Projekte/Coccinelle/janitor/delete_unwanted_semicolon.co=
cci", line 4, column 1, charpos =3D 28
  around =3D '}',
  whole content =3D  }


Will the shown source code transformation approach ever become supported
by the Coccinelle software?

Regards,
Markus
