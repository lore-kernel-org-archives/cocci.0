Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299E8C282EC
	for <cocci@archiver.kernel.org>; Mon, 17 Mar 2025 17:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9YqARS9Mhfz9e/3sdgSej9f/2Xc15VhRX/FNOBPnUkw=;
  b=XjCjucjs1Ec4fqKKjg5kpEpiLSZk2S5oY7Tud0VKGrH+Ns8KqE1+/+NX
   Muc8YwlCsKTW6ldKoLlYOzDs/TU0ocQ1wSzVG5U5o9sXlzHWK//yFhRqh
   fUptfcA1lfzycsvf1WwrWvtEYqn08v4Ovf+wG3dLnLVlUrHkc3wUVXVBv
   c=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,254,1736809200"; 
   d="scan'208";a="213334907"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2025 18:26:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 25AF1E0D89; Mon, 17 Mar 2025 18:26:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4413AE0D3B
	for <cocci@sympa.inria.fr>; Mon, 17 Mar 2025 18:26:35 +0100 (CET)
IronPort-SDR: 67d85b4c_ZmV+2mncjMnrd/sOUDaDL6Pq1MXiUaZ/fQpZ/d3/O7Ovoaz
 CuvQZ/xJ0Y4QD9y+loiRBvbm86D/dw1R00Qfr9A==
X-IPAS-Result: =?us-ascii?q?A0H/CwAlWthngA4P49RaHgEBCxIMQIFIC4JEYhtaMwQLS?=
 =?us-ascii?q?IRWg0+MAYF0LQOEO48OiHWDLCgPAQMBDTkIAQIEAQEDAQOCDIIuRgKLHwIeB?=
 =?us-ascii?q?wEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxh?=
 =?us-ascii?q?XsNgmIBM3GBJQEBAQEBAQEBAQEBAQEBAQEBAQEXAg03A0QBAQECASMdAQERJ?=
 =?us-ascii?q?wQLCxoCJgICVgYBFAEBgn4Bgi8BAw4jBw2tL4EygQGCDAEBBoEI2VQfLCJXg?=
 =?us-ascii?q?WUJgRouhW2CYwGFawE7hDwnD4FVRIE8C4J4PoJhAoFgg1uCaYIzhEBnmXaQC?=
 =?us-ascii?q?FJ7HANZLAFVExcLBwWBKUMDKjQxI4EiBTQKNziCC2lJOgINAjWCGyRYgihqB?=
 =?us-ascii?q?AWBJII2hDyEP4VQghGBXQMDIgGDH3Ucg0h2PYRhLVCBLR1AAgELbT03CQsbB?=
 =?us-ascii?q?j2ieTuEQoEQKyINgS8fa8V3NAeCOIFmgWMMiimVNQYTL4VakWwOBpJ9mH4ij?=
 =?us-ascii?q?WObLoF9JIFcMxokgzYJRgMZD44hgWuCDzO9EEI1PAIHAQoBAQMJhUYBAYpUg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 SGUotM8+zlOfcGQxzAhXBcc8152
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:o1i/d6+9J7A3Hzw7uwZuk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3AlCkydWruNeRE8UdczigzzCDmUeZ7WGee93iBGka?=
 =?us-ascii?q?bGXxIc422VA6+27wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A8gLISQ7nCe8VtlwXMsce2DsJxoxrz4TzVEQHwaw?=
 =?us-ascii?q?bnOWaKgFrHBeQrw+oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,254,1736809200"; 
   d="scan'208";a="213334445"
X-MGA-submission: =?us-ascii?q?MDFPb/F5RSSYJyvjxlmkTxOtP5uOmBRQ7Mkh9t?=
 =?us-ascii?q?d5yCx2DFlD1DbgjysIbrULqSobY4tHQOCqi8WL4oz+RbqeG4vFLBhGTr?=
 =?us-ascii?q?jS7t30LOSkuwf/uqSBYqUz0HRDriUES0PVXwUWwF8iYcEyDKcD3DEa4h?=
 =?us-ascii?q?dVD1JIPQjMqboQ3/kg4yDykQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 18:26:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742232393; x=1742837193; i=markus.elfring@web.de;
	bh=9YqARS9Mhfz9e/3sdgSej9f/2Xc15VhRX/FNOBPnUkw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cFDQ3bi4bFXVUFvjO5PdWHcfoLaK1ighfW3AqJeDJaKiJ/2Q1boxSWnDDnxsszjz
	 2o4GYeNQhwUQKHfpXy5+nNPTps0/oKqmRF7TqxyvslMYaI68oT5tK/tzCll1p/5Jc
	 ZPDCSo/WTa7CGhyV10Nn4GNf08e3PVVEq1HRGtPXSkI6n8XvydzQt9Wdazu39lQ7I
	 bZdYiz45R3RVikEsUfwA3zDXGRsMz3wxiUDKJy/gvJNDxL9F6/SDnThdcLRRZP7QU
	 nZsenRGDI0Wed9LP72qDj1a3LgWVDiFNzP6LhkEGpI++NUi8KEfVxfKSXuZFkqgCJ
	 /M1PFKokJK8zc5xdmA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.74]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V6E-1tumCJ0pwg-002IBb; Mon, 17
 Mar 2025 18:26:33 +0100
Message-ID: <2e62e29e-b1da-4493-81a1-61ffc2489c56@web.de>
Date: Mon, 17 Mar 2025 18:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
References: <20250317150941.32415-1-olaf@aepfle.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250317150941.32415-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IZHqdmHfwQyLmmnbThYCP+z7mxSjNzE+C+yk6C873oZOXsE1diu
 Qo9QyqfQL9ockRk0y8MKyQ5VPya2g9GoFdNfx/q/Fq14VbFE6sM/hMuicKhESj6cgH8BxNT
 l7wqx+f2p7xxjsFx9X3aSZLPaqL7qFmT86T4amVSMGJXYvNpXPyLTZr3H/52gYvYwG7ixu3
 mmDx34i3OP2EXnhOCEQYg==
UI-OutboundReport: notjunk:1;M01:P0:x9ewIf4ItZQ=;OYUPX30CcjIUe70wZdc1IhGnsIr
 hOrQ2I8mnCE2lv9OL7lYlqNK4M9SyAJu8VSykUf01vjXZrHLwK3x0YqfX5ei2RNIkPbZ+ERTg
 QQjB506VL3NvXmPlyfDPO78exuBqoF4zMYOfMBApZ3ONw3Ebto75hWpqPFC2W8zRRYL6J6zPg
 BAXM9AP5+7Yq5gEcxxKEMfCYcSrj3UIQ4q9Okbi0MdtkgjWDQG18R47WKRCzFLFgUEJZWzCXF
 UcIIDsAwR4aCC7VNqSbLKgqi2AcsslUycpw4QLHvPYx4VHklnFfn50fYCRB9AqjncrTKPIzf6
 5nc8ALz+qUfR2r3r8qCh5c7qCmpsVoi2XSitlwdHPXZvwevXOvOgS99oRtHHFnZGy9xSofQl7
 dZ2GciaXQEIaZhTrNhXeOTGO0KJ08Q/q0OdjplEijHnFjpX9qvwiS3FTo5c24/0o/BdHebuNm
 mV5LwnRnF6Nl+BhKJMn9vR95M3qJl7NWA58z2J6WZ+Z14up8kKZYniQTAW0MVtubdKTK164ed
 6suoGdZ8r2S8BRqudOxiea3XXwenzAIadkch7V4Cowp5uKaQtIhjP49F7NnmsNtw8KnNUy+d1
 sdKGLsoI4RebdSsGvYffWqIsHQPjXa/yFa0WS/+n6aKMqErnsXIDz65EZtfBkEWG4Q51zfaFf
 mox5yCtisztyCY7fNG+hOL5peKPy1oLFqcJZ1IyGb5uHKyLVYwwL8qUQgqsSz32tHKVHmLeyT
 A47aAkP8vjGRkPCEBOceFswb7LSiOUYCbAjtvHK20gb5n/LCg1QGhw65NJw5xspVmXW+bjAgW
 PmNiq/IDwvaOTfnYbh9MUSOAYdtCU11XN/8tG5D+EbG6N/dvqRvfiEtd5s8LBCcol/Iu41icB
 +tqvD/VSN8S0OBUe7/iO+GO476DJxTThNK2guW59G3bSuqhEkryaGF/CP6F+INGrudGHy0wh+
 DVB4kP1ChbUAOUymR/mCdlHny1nSblm/V54Gz54ZCOf10YvaZBB+8zsJ8T2s7VlUtRMUdH5HO
 69ILPw6RzIV7Ft0km71VtDRwgYQEDxr1xHhwLhDjUsTByDHTOLoDlvP5/DQfimUGixPGQuFD3
 +5AS7nd3Xub4jareugioMbteIBH1x0Gjh3iRNnQ+WBunoXi8q3JfyBvOElJ4u4XS74EZfdVRa
 Qk48NbyYkwbKZ6QzR7swqrBW+xDD3A4qgEDHez/4WnyHCieArdDZRjOYA/8OKhT5nXyJcJTPn
 oDqJrnDmD/rmtb9QKPzhHRpGZXj+zuKlJwznaHF95SdMABuRf62YcC5rCA4af1k+uZYVodKZz
 J+7G/JMRa1PIupo7RQCvAY9HBuP6NRGiFHfLRlQku0+5ok3ZNmKR56L5FNM+S9MgLuJki6q28
 bT+vA4s48iyfaG6dqcJJt1RWqaj/0UVjSjDbZBKTJA5eeNMAiiEH4lL1FeKkUqHviyBWyQ27S
 PoQ5sbsEBQ1aRZ3ZuSL9qsW0StCHzpoL9F/CcFjJF52ZhEinYoKmIO2lpOMTMy8FIlHl3IWuA
 HlGt3pG0/LJ/LOJoeFM=
Subject: Re: [cocci] [PATCH] replace pcre with pcre2
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2589
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/2e62e29e-b1da-4493-81a1-61ffc2489c56%40web.de>

> Since pcre is unmaintained, I was asked to remove usage of ocaml-pcre.
>
> This is the minimal change to use ocaml-pcre2.

I suggest to reconsider this view a bit more.


>                                                The question is what kind
> of change the maintainers want to see here.

I became also curious on corresponding collateral evolution.

Configuration possibilities for evaluation of regular expressions in SmPL =
constraints
2018-11-20
https://github.com/coccinelle/coccinelle/issues/149


=E2=80=A6
>  configure.ac           | 14 +++++++-------
=E2=80=A6
> +++ b/Makefile

I doubt that the adjustment of a make script is appropriate
because such files should be regenerated by the software build system.

Regards,
Markus
