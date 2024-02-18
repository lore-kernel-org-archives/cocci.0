Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2816AC4829E
	for <cocci@archiver.kernel.org>; Sun, 18 Feb 2024 07:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mbo4ywyEMgnBxQRSSEZ+uFXqpMJtXu4stvJ8J4gFHnw=;
  b=OnynINuzmLF9uHl+Cy9DAd6f1sKPeMYHK/4hiNkQ5bj0vH+XD33z8F5D
   dAhUj+Wz6dqK1FlMbaYy7pKDrI2kOqa5rRd19fJE9sDEHZ1MNS4LJt/yc
   IxL85aiKy7NP/3jN2vfJ+SFLz4l2jhMnCt/Nnt6QNhAuHf8xxiqe7/eqK
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="152479470"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Feb 2024 08:05:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E4953E00B7; Sun, 18 Feb 2024 08:05:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4E41DE008A
	for <cocci@sympa.inria.fr>; Sun, 18 Feb 2024 08:05:07 +0100 (CET)
IronPort-SDR: 65d1ac23_Zz6MZZZBR8M7Off+0R+Js1RGhPgWca/PnCx4ja3t1bClUXV
 kDXUwG2/zZOdAK0Y5bo6YCg8VfYSDQmyxr4AwCA==
X-IPAS-Result: =?us-ascii?q?A0GWAwBGq9Flhw4P49RaHgEBCxIMQIFEC4I5YhoDUzIEC?=
 =?us-ascii?q?0iEU5E5MIQ7jwWMBj4PAQMBDTsGAQIEAQEDAwGEOUYCh2QCHgcBBDMGDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhWwNglwBE?=
 =?us-ascii?q?IEOgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QINOkEBAgIBIx0BAREmAQQLCxoCJgICVgYVAQGCfAGCKgEDDiMHDbJHgTKBA?=
 =?us-ascii?q?YIKAQEGgmesdB8sIlaBYQMGgRouiCYBiisnD4FVRIE8glIxPoJhAoFgg1uCa?=
 =?us-ascii?q?IVRmghUgQIdA4EFBFoNGxEeNxEQEw0DCG4dAjE6AwUDBDIKEgwLHwVUA0MGS?=
 =?us-ascii?q?QsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEwVUEMUANkHzIJP?=
 =?us-ascii?q?AsEDBoCGxsNJCMCLEADERACFgMdFgQwEQkLJgMqBjYCEgwGBgZdIwcPCQQlA?=
 =?us-ascii?q?wgEAyspAyF0EQMECgMTBwsHeIIJgT0EE0QDEIE0hTiEbAyBUgMZKx1AAgELb?=
 =?us-ascii?q?T01CQsbBiIBHQKfEQGCZYEkIoIbxSo0B4I0gWCBYQyKG5UdBhMvg3KTPg4Gk?=
 =?us-ascii?q?l+YWI1vmwiBeiSBXDMaJIM2TwMZD44gGYNhM4ELjjxCNQswAgcBCgEBAwmFR?=
 =?us-ascii?q?gEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 PLmpZdEWVZzGv5IUyxY
IronPort-Data: A9a23:Fenudq656TkDeWL7TsFoJQxRtADDchMFZxGqfqrLsTDasY5as4F+v
 mpKUW3Tbq6DNGWme9pxOo3g/UwBsJDXm4I3G1BkrClnZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXgsbAr414rZ8Ekz5K6r6GtB1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj68l2EUUHF9NGw+dUPkpf+
 dcCcHczUznW0opawJrjIgVtrsEkMdWtI44V/H1tpd3bJax/G9aZGfqMvIIehWtYasNmRZ4yY
 +I8YCBscQ+GThlBIFYRB7ohke3uinSXnzhw8Q/P+fVmvzaIpOB3+OjrE/H6deelft1Mv3a6n
 Fvlx2SpGR5PYbRzzhLeriL03b+Q9c/hY6oZE7az99ZxkViLzyoSDgcXXB21u5GRjkehUtZbA
 14V/yA0pO4z8laqR5/zRXWFTGWsuxkBR5xPHud85AzlJrfoDxixOnAZSg9rNoIftewJbi0m/
 UXR2O3ULGk62FGKck61+rCRpDK0HCEaK24eeCMJJTfpBfG9/+nfaTqREL5e/L6JszHjJd3n6
 xynxBXSap0WitMXkbq29xbLjlpAR6QlrCZkvm07vUr8sGuVgbJJgaT1tDA3Ct4dc+6koqGp5
 iRspiRnxLlm4WuxvCKMWv4RO7qi+uyINjbR6XY2QMFxrmXxpSH7Jd0IiN2bGKuPGplYEdMOS
 BCO0T69GLcJZCHwBUOKS9nqVZ96kcAM6/y0C62OBjaxXnSBXFTbrHk1NRH4M5HFkU8qlrp3I
 przTCpfJSZyNEiT9xLvH711+eZzmEgWnDqPLbillUjP+eTFPha9F+xaWGZim8hisctoVi2Or
 40AXyZLoj0DONDDjt7/qNNCfQxXfSJhXfgbaaV/L4a+H+avI0l5Y9e5/F/rU9YNc319x7mWr
 EKuEFRV0kT+jnDhIACHICIrIrD2UJo16TpxMSUwNBz6kzIucKS+3pc5LpEXRLgA8PA87PhWS
 /JeRd6MLM4SQRv6+hMcT6LHkqpcSDqRizmjAQ+ZcRkkXps5RwX26t7uJQTu0y8VDxuIj8g1o
 pz+9waCX5YzfhluVvjXTPeVy3Kwonkvt+ZgVGTYItRoWRvN8ao7DwfTn/MIM8U3BhGb/QSj1
 iGSGgU9idjWhp0cqf3lpPmjgd+yMu1cGkF6ITHq3YyuP3OHwlv5kJ5ybumYWBv8CkX2wfyGT
 sdIxajeNPYnog57g7BkGew28ZNktsrdnJ4E/AFKB36RUk+KDIlnKXy43cVikK1B67tamAmuU
 HK05dhoFuSVCfzhDWIuClIpXsab2dEQvwvi3/A/DUH5xS1wpZ6sc0FZOTuSgy18cppxFq4Yw
 tkahc1H0Dzn1yIWMeuHgBtEqEWKDHgLCJs8ur8gXYTEtwsMy3N5W6L6NBPY2p+0Ru93AhEYG
 QPM3KvmrJZA93XGaEs2RCTs3/ICpJEguyJq7V4lJnbSqOXkm80Y4Rx12hY0RzRz0R9o/b9SO
 G9qFkstPoSI3W5iq/ZiVlCWOTNqJUOm6Gnu7WAWhUvlT0WMfU7cHl0XYOqi0hgQzDNBQ2J94
 rqd9lfAbR/rW8PAhg0JRk9vrq3Yf+xbrwHttpiuIJWYIsMcfzHgv66JYFgIoTvBBecaphXOh
 ctuzdZKRZzLDwwiiIxlNNDCzpUVcg6OG0JaS/I4/K8pI3DVSAvv5RewcXKOauF/DN2U13SnC
 v5eBNNFDDW/8yeskgo1J4AxJ51Mofp4w+ZaJ53KIzYdvqq9vwhZlsva1hLDiV8BR/RslscAK
 b3tSQ+SL1zIu1xqnz7ikcoVHEu5ftgOWyPk1s+X7ugiNswOocNsQ24Iw5q2uHSZajVm2xeuu
 CLCeK7k4Ohwwqt8n4bXM/tiBiflDfjRRei34ASInNAWVuz2MODKrBEwhmT8GgZrYYsqRNV8k
 IqSvO7N3E/quKg8V0bbkcKjE5ZlyNqTXu0NFO7KN1hfwDW/XfHz7ys5+2yXLYJDlPVf7JKFQ
 yq6cM6BSs4HaexCxXF6azlsLDhFMv7ZNpzfnCKaq+iALjM/0gadddOuyiLPXFFhLyQNP8XzN
 x/wt/OQ/etnlYVrBiIfJvRYEpR9cU7CW6wnSoXLjgOmLFKU23GMhrizsiAby2D7OiHRWoKyq
 5fIXQP3exmOqbnFhoMR+ZB7uhoMSm1xm68sd0Ya4MR7kC2+EHVAF+kGLJEaEdtBp0QeDn0ji
 O3lNwPOyBkRXAiotT3558n/GBiSDKoCN78V49DvE1y8M0+L6EGoWdONNRuMJ19pdzGlwOzPx
 RQ25CjrJhboqn12bb972xF46NuLAtvFy3hO9U2VfwkexfoBKe1i6UGN1zahmcAK/w8hWakLy
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:mmXYpKH6HwAK4RwYpLqEPMeALOsnbusQ8zAXPo5KOHtom7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hzAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:l8uN7WwqSzUccS3JNQmXBgUoAt0hQ1eDkk7RAHCTGGpCUuXSd2K5rfY=
X-Talos-MUID: 9a23:l7HpDwurLQ4qoNlM3M2n1DdBH+hn2IuVEFksobc8guq8NXxrNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="152479463"
X-MGA-submission: =?us-ascii?q?MDEK5fsGoEHs+QK4qOlrkdSJDf9uaBGQYmfVy9?=
 =?us-ascii?q?MCL0n4lE8RsrzOLT8GSRGdaW80GPGNIBdRL+sPTDItF3tBl+Lt/X8tde?=
 =?us-ascii?q?5Uqm2NjB4+IAaxQu9b1MDdX1/fE7zBBJjT80AVnX3RhGZSbwbtoXR7Ne?=
 =?us-ascii?q?CV4pwsa95qwM3GIHmn2rJF1w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 08:05:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708239906; x=1708844706; i=markus.elfring@web.de;
	bh=mbo4ywyEMgnBxQRSSEZ+uFXqpMJtXu4stvJ8J4gFHnw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:
	 In-Reply-To;
	b=FB+DTODkAodTvHL4XCDcVHFkgCTVBOfrZnt8SRkd4s7b0me18/DK180Zs2cH1fgc
	 tdixv4ddMssmwf3NlIHhWP8RNlAat4zxIc0uXOs5NV+Bd9VJsez6fq+Vw+qkDQ/vv
	 nNa4lD8F5y7NmnRh8grrDsmhtXSnufvCulQcpkyHXBv0+QunbNhiSHNf2yrYnCFxr
	 3MS+OfdYeqdCRt56r8bHHeQFcFZITkiMPG2vRNLxCn2Dxufcw6L0iW21FaRNFVNEP
	 Sv23spgY7STXu29vCBZVHkavVc0CKdeEVAHoqZdquw46g7DUOeXzff8R5AnUm0mmp
	 LeQbwUXD2Ni7JxlCcw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9IOZ-1rYahR0QVj-006NmZ; Sun, 18
 Feb 2024 08:05:06 +0100
Message-ID: <e4d59a7f-94f2-47b4-8a63-0d0775c4a133@web.de>
Date: Sun, 18 Feb 2024 08:04:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
 <6d5d2b50-2878-4d39-b1f3-ae894f880dc4@web.de>
 <alpine.DEB.2.22.394.2402171623280.3095@hadrien>
 <7a9ea69a-2699-4fb3-9863-2eddadb5670b@web.de>
Content-Language: en-GB
Cc: cocci@inria.fr
In-Reply-To: <7a9ea69a-2699-4fb3-9863-2eddadb5670b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YFDUzbwYIuZQGV3fo+OCOU8BMxATlTtQ5TA/apzPdypCpTI2Vsr
 9NlayHF0hWmB4mKZmZY+ocOk4SYgcHTFuW58lVF7YFtLIpQmYLMAXgV2iR7PnIQljTAQnB0
 Cu9GtyYyldzaIHmY+H08+nlWcDo3QBwA20BRd4K0T432pWw+vzyVs9f3fiTEh3agBtvjKAc
 OHwp3HNwEOorRzkkNaCVA==
UI-OutboundReport: notjunk:1;M01:P0:Vwpos5qI4yc=;53yW0LOtcPJzVrjvkHZAHDtU5di
 2RKsmq+wid+yJjxYmKtcN2Fs2qIvZp4Ma/FZnXqgqfLyVIo0MGTUZvPqvezmOD/RDvVTszCvv
 XN2hVckCwcCj0oytpYqhydmQCtpXWY9OCtYCKnizzbQeYS1NmirJ005RDRpkGdUauGqPg8N55
 g+khYnbRsvQvQG9StCSN/CdyEkMP6i3CfMPSmr5FoYAJ0F63vOKLqH7M6rZmHpXyIik71WJct
 lJLa+8Itaou2T65asvCuEp767TeuSY0P9xGrlq+Ctg5H28pllPVNq8aHFAiqqrKlA/bUgLLmm
 j0CNp8ipt/8oM02Q3AvnsdIi1dogD+3/HAwcXE3UP8t92iWk+OkznbwQafm21xRnJUXeKOg6o
 HgRiZVjH8lOOAiCie6nwT2dZWihV7JjCNWLT66sq/0LH8YbAhkyLqo90AO3zTWCHIVboCDQH+
 Ein0JSlTv/HDYYG+ixuf7R7S9oYPALpV00pY5FaoQyeGXSMhQ+bLpd3IxVe8Y3sDiZDZORsrK
 mj3o9Q/0N83d4dFjwpBBGDlOrwdRND16LQiYPeQ6RVflV8n9gZ081SP1Jlj19CGe8nBnkGKZq
 SIDVp/DRcDu+7tmqb8CfXJcCuaSfiYt7H3lsThIEhOmTcnPrNYQwDPk+n/r56PAz2tEiA97v0
 Ybkieo1WmayxJ2qbf6FyAoG7XF74s3VvxlfIlKdQqblK/T2AdATqbqPQhB+Bmgp3omWtvyAiC
 xG2vtlzgjah2ODCpZ/XSlzrIDNITr43H8lItZQzWEgzxihO4IbSyJ0ZHMpaYGG9UYeOTUYADA
 9+UlMfePOxtClBFsegGs5Ue0I5hTtr+6rICqjAL4P/MCA=
Subject: Re: [cocci] Fixing the SmPL search for a bit of duplicate code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1573
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/e4d59a7f-94f2-47b4-8a63-0d0775c4a133%40web.de>

> binops and assignops need to be stripped before being put into metavaria=
bles
> 2024-02-17
> https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/cf3ea16c48751708a=
b468919c736acb06f7e1ff7

How do you think about to explain the influence of the mentioned =E2=80=9C=
stripping=E2=80=9D
on desired data processing a bit more?

Applications of the metavariable type =E2=80=9Cbinary operator=E2=80=9D we=
re occasionally
discussed before.

Another example topic:
Complete support for data processing with binary operators
2020-09-29
https://github.com/coccinelle/coccinelle/issues/227

Regards,
Markus
