Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D43BC47422
	for <cocci@archiver.kernel.org>; Thu, 25 Jan 2024 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RQA/vASqFBBQBfRrQDMXXcrTpcwPhO53hw0DgoXS25k=;
  b=ffjgPnEPK/CSdfxzHBl2G3fDRVzVszp45vJaz1X12hkpnDszujaxVuXM
   DKzZPRK7LnORfYWF03VGaId3EBeWembM0zUGMo90A7ra3NVgAYQIGr9Rb
   4sYQTgf+wFFu/5A915SWr07mK5bGH+O3wsa4mxc0ZsE2QsPLlu0Ht/Rat
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148676101"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jan 2024 18:47:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 689D0E0CD5; Thu, 25 Jan 2024 18:47:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4170CE0035
	for <cocci@sympa.inria.fr>; Thu, 25 Jan 2024 18:47:04 +0100 (CET)
IronPort-SDR: 65b29e95_Ek6UJ2NnYlxVKTtyjVOMHEvit3pFfdLdMHCJlLV98N6Zw5k
 Mga09OA2+IY8HbVxoYxwpP5Z9mFufA9Zj6JlrqA==
X-IPAS-Result: =?us-ascii?q?A0FCAwA8nbJlhw4P49RaHgEBCxIMQIFEC4I5f1MyBAtIh?=
 =?us-ascii?q?FORNjCEO4c2h06IcIFWgUA+DwEDAQ1BAQIEAQEDBIILgnQCh0oCHgcBBDIHD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhWwNg?=
 =?us-ascii?q?lwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQICASMdAQERJwQLCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgnyCKwEDDiMHtneBMoEBggoBAQavWh8sIlaBYQmBGi6IIgGFZ?=
 =?us-ascii?q?4Q7Jw+BVUSBPIJSMT6EQ4NbgmiYT1R/HQOBBQRcDxsQHjcREBMNAwhuHQIxP?=
 =?us-ascii?q?AMFAwQyChIMCyEFVQNABkkLAwIaBQMDBIEwBQ0aAhAaBgwmAwMSSQIQFAM4A?=
 =?us-ascii?q?wMGAwoxBylVQQxQA2UfMgk8CwQMGgIbGw0nIwIsQAMREgIWAyQWBDYRCQsmA?=
 =?us-ascii?q?yoGNwISDAYGBl0JHQcPCQQlAwgEAyspAyEzQREDBAoDFAcLB3iCDIE+BBNEA?=
 =?us-ascii?q?xCBQiwDGSsdQAIBC209NQkLGwY9AppOg08RonKiSTQHgjSBYIFhDJ8xBhMvg?=
 =?us-ascii?q?3KTOw4GklmYVCCoToFqBS6BXDMaJIM2TwMZD44gGYQUj0dANTsCBwEKAQEDC?=
 =?us-ascii?q?YVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:zLKJtqEKLsZlIEJWpLqENseALOsnbusQ8zAXPjNKOH9om6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4tgPM
 xbE5SWZueAb2RSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:wC5cXmOZNOhR9+5DYSp6xVYUK+EfMXTc1CqPJAigUXoyV+jA
X-Talos-MUID: 9a23:UM8wmAYyVCJPy+BTly2whSx+KM1SwKGuB0Qhi8Vcm+yiDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="77845240"
X-MGA-submission: =?us-ascii?q?MDFNMsszaGF2a11a9GSFQxBw3QyWpHVF1fYxkP?=
 =?us-ascii?q?psDXGjL9qq6Z+co7glfZcfOnZIpjIr60n8/fWqXEkBVfu3cyORyHG4+H?=
 =?us-ascii?q?JNi2JyGHExIXViCa+JHHktxKUQXQRnq5V+calfpErjy+SDvVhGK6m7gK?=
 =?us-ascii?q?sBL6UV2utU8GHuevPXy8TrYA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 18:47:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706204823; x=1706809623; i=markus.elfring@web.de;
	bh=RQA/vASqFBBQBfRrQDMXXcrTpcwPhO53hw0DgoXS25k=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=P9m7L5TufOPx9zk0rrh4+auF1H556r6puNqG9emLMpLm6tSaq01+fIDLmpj3kYs7
	 jqf2KAN1lx8isSkUXhKrp2jkZ/LReXyzXMwOOELXYtRePC81FpPrs9Iprfjlk6uoX
	 6ej++qqsP8F+EmzLo3+wTFNTIMQAB68hi1+MgEJFiPC2eF+C1UNPn9jYX8fWnshps
	 tZQnpIALv4h1IouyJFhyOp7BtK3vfCMOzk2zdRf+faEPg+J8+CE5AkEnYEdFSt02K
	 OE8eS195yvtcWBKVeTKgGo+IL45NjLVm/dStZW1ShbzruY4OiY4zo/gzjac+NpQki
	 2t2UxCAXSCM9LG3o1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxHYK-1r9APm47vE-00xf1j; Thu, 25
 Jan 2024 18:47:03 +0100
Message-ID: <a487afb1-315e-4b90-9bac-591d422136f8@web.de>
Date: Thu, 25 Jan 2024 18:47:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <ec692ed7-01e5-493b-95b6-75ca7a59fb1b@web.de>
 <cd85b5cf-07f-a1f9-ba30-126045bfe15c@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cd85b5cf-07f-a1f9-ba30-126045bfe15c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3DlrlkumuP1o+kZIl4tl018QoCOIpgJ9DuUl2t3d4YqRodyL/67
 /zrVf5GkCF7A9UVhExpCMbQf68kYMKmGNOUt0/0bmQuhHNgUAbhSCKbk32XhzbvMgsCrmOR
 o23CLud+Sr3iSnXfiZI5cA+yY4lmFXX8tBTpF/zkQVpfUG++BAw5R4ZWaxkkFtSXquoUaAt
 yGldEXxylNY66lmGU8Tfg==
UI-OutboundReport: notjunk:1;M01:P0:AfQh8wIv3Tc=;68sK11xbXF5mzcv9UuESNkeiNXh
 8hSHkSrwS3LBtIT9rlTfODOB9J7u/wPM6a4BpgVDiAQHKs/pxJBruTDQrcikplH16bbJd+z1G
 od/CiKrtIFsphdtmwCQ7r/iIBcZVUAAmjFua6Egn6Ozf+rQZ+knIG43k99p7aT+LZOT7Wh3iA
 dZlVTWFWqjJJZYuOVc9kkHEqOjcEzPTYeBbHsxaqKtcIu7YnJtjk/VDc+7sOHzJPLM1skFKhi
 0Xl/AFF1I8Mi8FOoJnu4A+8fFgqmiG3WmyxRirFXcEFyqA2xMv8KuC3HfMt//doZNbKRQAFrn
 qsDgfuzdkhZ4Kwu/+N6Y/ipwVYkWcp1DGTB5B3t0x+WQ8WqRYqw+C6LnJtbX6tdpSCe5+FTEy
 XtPOnST/mUXPzoIDDC97RCV5Qhfnu7FipeXwNIHVTYyr4Uj10oHEpRN9drWfl9Iof93ImxgR3
 xjX6dtXNJtMGtMBIiPKSALPIo81AZatftt/rvIIZQdMItu4FzXu7nOBvACc3PKNqylvSV9S68
 fnEzhRa/Ls/DlH9/S+g3nlZadY/i1GxE12k9xNPUYJiDrg+55k1wGMvNV1JmWGE/SJvgFSicq
 Uv0pT8S7RsscKlmpmyS+pYwyfX8elYmx5gAWav24M8FteG6fIdbbIkpvsIvSQTv2KoRXoN13I
 E9eImgjS8hVsAamzIj8lI5x4xyFcmFWC+cZD6+ofiQDuaPpFIfdqnm2CmwFsGGJRSXvVTzYDm
 bTMvTsgp/3+M8JRad1AZwqI5VtZxI4w8R2cyqLxqG/oaXO0dezun2fM/8D3+O64f8tFoq9Z9r
 jHja4M1VVIpsyo5u05Ql9XreBGG33kCcTjl9jDUad0anaX+SdRzO9rEeuuqHRGGwXcBfI4EUA
 P+rPUDKhIuiPdLxLhSi24lAYB/bDam59RXOyICMmMb+TdlmdgYO2rY6QCljtm0jikznppbOhg
 M7mZ2Q==
Subject: Re: [cocci] Checking name space conflicts for SmPL script rules
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1488
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/a487afb1-315e-4b90-9bac-591d422136f8%40web.de>

>> Will the shown restriction be reconsidered?
>
> name is also a reserved word of Coccinelle, as in iterator name xxx;

I suggest to take another look at corresponding case distinctions.

I got the impression that the metavariable with the identifier =E2=80=9Cna=
me=E2=80=9D gets accepted
by this software for the first SmPL rule.


> Just pick some other name for your metavariable.

Can the avoidance of questionable name space conflicts become safer and mo=
re convenient
also for such a test case?

Regards,
Markus
