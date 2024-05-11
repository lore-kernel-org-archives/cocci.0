Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1851C25B4F
	for <cocci@archiver.kernel.org>; Sat, 11 May 2024 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eijcJ4iot3nBcgjMJgSxpfer4dsM64e8YC+Oj1uJSJk=;
  b=siXyjS8/YNJT3LYgbvdmKnFp0cIx+jiqK9zcl8MGDeIUTyRRODCsIPIE
   v7y0gkH9p0AirTnzIQ+HrbSs1QOWK2qXnwwCC9C+UJSNutBQVxT0RTHDY
   yt7zuusRbEb0xrqpt03Vjo/oFtbASGevGGP7GjOMghmXWV56JQIPu4gt1
   4=;
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
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="165199256"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2024 17:36:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B99D9E0CCC; Sat, 11 May 2024 17:36:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9B24DE004E
	for <cocci@sympa.inria.fr>; Sat, 11 May 2024 17:36:40 +0200 (CEST)
IronPort-SDR: 663f9088_EgoQgY0d+4Sgy47sfIIRSQiebtXneogaNZ+KH4HjpyKW9zW
 /CObWZdd9jyiCUJV2HCZEwYp2tq9F3f6yaQn84w==
X-IPAS-Result: =?us-ascii?q?A0GTAwDVjz9mhw4P49RagQmBT4JEgVQzBAtIhFaRPYRrh?=
 =?us-ascii?q?zmHT4hxgVYUgSw+DwEDAQ1BAQIEAQEDBIILgmoKAog9Ah4HAQQxCA4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4V0DYJnARCBD?=
 =?us-ascii?q?oEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgIBAyMdAQERJw8LGgImAgJWBgEUA?=
 =?us-ascii?q?QGCfIIwAQMxB7MHgTKBAYIMAQEG2lkfLCJXgWMJgRouiC4BhXyEQCcPgVVEg?=
 =?us-ascii?q?TyCUjE+hAU+g1uCaZokkE9UfRwDWTIBVRMXCz4JFgIWAxsUBDAPCQsmAyoGN?=
 =?us-ascii?q?gISDAYGBlkgFgkEIwMIBAMQNAMgcREDBBoECwd1gXyBNQQTRAOBOIl2DIMxg?=
 =?us-ascii?q?XcphB0IQ2wVg3aBdw5hg1qEUWaBLR1AAgELbT01CQsbBiIBHadLgWLHAjQHg?=
 =?us-ascii?q?jaBYIFhDJ9EBhMvlzgOBpJomGIgqGeBZwM1gVwzGiSDNk8DGQ+OLQ0JhAvKf?=
 =?us-ascii?q?UE1OwIHAQoBAQMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:wvksy6AxZt3MeTPlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3AJ52MJmvP9+lUeBzQxHGiDhM46Is/TE3Gwm6BYHW?=
 =?us-ascii?q?UIm9oUYPMEHGU2517xp8=3D?=
X-Talos-MUID: 9a23:GYgU8gsIl+GJm9uG8c2nng4yOMww3riVJ2MQyYcU4+mqFQtgNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="86774135"
X-MGA-submission: =?us-ascii?q?MDHCFsGAH2cu/gzgRW77itDGFCXl+luw0qees1?=
 =?us-ascii?q?aAkKYHW7g4e/JsTeNq6dA1dBk+3xk8X6Bw2Tan4Gev9TReM9pEIylfYs?=
 =?us-ascii?q?gOc/sZKh49Us478hDqj+Fh183PUAlFUedWt3JrAcailJCIy4snTrVgqi?=
 =?us-ascii?q?Y9EThkRDmn66UEQHFGxksXJA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 17:36:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715441798; x=1716046598; i=markus.elfring@web.de;
	bh=eijcJ4iot3nBcgjMJgSxpfer4dsM64e8YC+Oj1uJSJk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=malts8/AXMFYxd/Eo6/UQJsNIjBW+IebIWcewLqvbr6r+TTwziOK0qsw9sAsXbtg
	 91b+yQTVBGOWGn9ZNf9cLL6tDDVYAHN2PPbcfdPjK/FGE1gH1+uq4ADXZJjvYDRUA
	 UsjQ4/Z04yP+VORQPT3ta4xRXElz60j8U9Q+IqSADeqOD/p236Z769UNaQudh84KE
	 tN5Ob7PH6DgponBXNcO/yOSZXEzzDbagT91rsSiYvrSToCUIwJehyirYL6QIO5o1n
	 5S8lnqHS+ksrL/chnupOLh0xNh7trab8enKEfADDqCsncu1qj+pkCScAP1uQQf6rh
	 1PcVk9s1VWQMFi2wQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1soqFu3JRU-00ya1A; Sat, 11
 May 2024 17:36:38 +0200
Message-ID: <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
Date: Sat, 11 May 2024 17:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4QDnL1JjEshtiw/hyalw3hNHqrQ8vOcqj5SK+vyk0PGOTAbl0bg
 e3AiD4065ueuqz2UFbh7dx+SqdD+d+kZdjOoWIJXt5y8kCACJQ/91Pct9xKB2gWid0TXjEa
 CIkMrZnrWT2DnXDMhWlIKsJLYprdZfnUxgtZgSORs1MGBhzDQEeiIUBokJxfzt51W4LmyUl
 waH2dd6Ld2BBLK6AasTsA==
UI-OutboundReport: notjunk:1;M01:P0:zugGdjRYYTc=;eJaqZLnqHAt1ZQRxdQLsRGAzCRX
 J/2bX7Xo5OLJLO1y83Nu4sKiyQ4x+FlIRkhp06L27avmZDM0N8OU/43ijVV9dh8sr18U/nzcH
 X/PXJyvWAg9lvCk46OErcL7eWwdVAK7EGW788J3zHedfFpTuyKkky40CSo4Jaj1mxl/Pz0nF1
 jxpznN8lP8wvwf13/keQiK0n4h+xb99DxeGOWinJHggYa4Stlr8QOfEX65tYMHrZsoxqtkOVl
 u6poVjSmFrJzCZ8FiN3dg98tzuyTISnd2qcokfufFMcKzPowEKJakFtaL6Wr90SxAgKHAoTRi
 ZWATH5re1vW4uRKPjh76sgqSFSzwgJPgRjXXMFLOx4AatpZ75LmcHUOHBXWba9VlqwgPq27/s
 LI+ugQ6dQGdVdhMWXnF2TgBFkewYc/GVM8SE3sSRTa0SA20xO1qTa8tg3erTYypEAG8Iqki9r
 7+RdbN68GVgFm/j8Vbx5JQLmWH0d+6maJ6DRWy5W4dGXLzpEIPK88CJdry+tpNbaXbHDWJilv
 +FDanrMSVGdLALnZYyoF3uhVIgO2OzvY0OKYIFvAR0DIMkU+CeLVp8d+fb887R8EUnmNHoKAz
 uZaFA3bB4Z4V1oOhg7wn6okXNVOakj9cx21UaOER5wKxX87WVIRDtF5H1RxuoB84FGasWQuvm
 DDLfI2a/GDSgkNhHa/+92U9G7DeDM6KcUsEkVQGQw3Szvo/EUstumxgCgqSgyS5+piI7pn8Sh
 rvsq92H6OVmWwY51uxmNFisqz93scvLNrYAAPcTgQUWsikjAPblvr/m3d4hh+jW9LYKEFzSNT
 cc9swwOND/LMWZmMbn80GAcTJH4NGwmr6k0wPDT5hdDps=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1713
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/6f5533b1-cbf8-421e-8d7d-8435aa28b360%40web.de>

=E2=80=A6
>> I would appreciate if multiple occurrences of code elements can be bett=
er detected
>> and transformed.
=E2=80=A6
> Be more concrete about what you are not able to do.

I hope that indicated communication (and data processing) difficulties can=
 be adjusted
a bit more.

See also another source code example:

void my_test(void)
{
 my_action(1);
 my_action(2);
 my_action(3);
}


See also a corresponding analysis approach by the means of a tiny script
for the semantic patch language:

@display@
@@
 my_action(...);
 <+...
*my_action(...);
 ...+>


Why is no diff output generated by the software combination =E2=80=9CCocci=
nelle 1.2-00008-g75525032=E2=80=9D
so far?

Regards,
Markus
