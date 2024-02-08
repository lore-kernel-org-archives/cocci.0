Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F2BC48260
	for <cocci@archiver.kernel.org>; Thu,  8 Feb 2024 13:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CMzdV6BLfX74xkZiH7NOR5MGjTux9nKy8u31fQi1Nbk=;
  b=U3OXmNbunJIh9UeDqwU0gzQAdfwCK/Amt0j5SpLbB9PpEGZPgP/5in4R
   5s9KhoFhH/SPYw27CpEQ7AJPsE30MoACemnFIG/uYSK5pc+pZzsk3ztHh
   w8eN9UNG3R8guJdMuQErLjMdvN5mct9MaIPxlqFTO3lqfPkU7CpSReZ8/
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.05,253,1701126000"; 
   d="scan'208";a="150960540"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2024 14:16:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 738F2E00B7; Thu,  8 Feb 2024 14:16:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EA24EE008A
	for <cocci@sympa.inria.fr>; Thu,  8 Feb 2024 14:16:11 +0100 (CET)
IronPort-SDR: 65c4d41b_gl0ij/dMcuOBDs5rjsuu3AdbWJ3uRwIDYxqnrLZAfQOaNdh
 EFL8ShXh6SDsiLRlAlc6CLlKxfi/LIu5d6hx5ow==
X-IPAS-Result: =?us-ascii?q?A0GECgDw0sRlhwsR49RaHgEBCxIMQIFEC4I5f1MyBAtIh?=
 =?us-ascii?q?FOROoEPg1yHN4dOiHCBVhSBLD4PAQMBDUEBAgQBAQMEhH8Ch1cCHgcBBDEID?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhWwNg?=
 =?us-ascii?q?lwBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdCAwMjHQEBEScPCQIaAhEVA?=
 =?us-ascii?q?gJWBgEUAQGCfIIrAQMxB5pynDSBMoEBggoBAQavWh8sIlaBYQmBGi6IJgGFb?=
 =?us-ascii?q?oQ7Jw+BVUSBPAuCRzE+g3xHP4McgmiCGIM8lzhUfx0DgQUEWg0bEB43ERATD?=
 =?us-ascii?q?QMIbh0CMToDBQMEMgoSDAsfBVUDQwZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDE?=
 =?us-ascii?q?kkCEBQDOAMDBgMKMTBVQQxQA2QfGBoJPAsEDBoCGxsNJyMCLEADERACFgMdF?=
 =?us-ascii?q?gQyEQkLJgMqBjYCEgwGBgZdIwcPCQQlAwgEAyspAyF0EQMECgMUBwsHeIIJg?=
 =?us-ascii?q?T4EE0QDEIE0hT6DEQMZKx1AAgELbT01CQsbBj0Cn08HexOCacUnNAeCNIFgg?=
 =?us-ascii?q?WEMnzcGEy+XLg4Gkl6YVyCoV4FlATeBXDMaJIM2TwMZD44gGR+DdY9HQjU7A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 cXT0r3+InFO/oCMlSPzL9fZIoSLPSh4WSc=
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:3LNBzaC+3HP+5yrlHely55DYdb4zR+YMi2TDpHoBKiC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3Ab/wc0GkFpg/FLNKrJmxeeOy/8bDXOWPR8WnoHla?=
 =?us-ascii?q?cM294TIyMFn6JqPwnruM7zg=3D=3D?=
X-Talos-MUID: 9a23:9q6uOwbZLW+WyOBTtiXiuBtSHcRSwbW0K3A2iMkPkdPZDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,253,1701126000"; 
   d="scan'208";a="79106210"
X-MGA-submission: =?us-ascii?q?MDHGaKjlfY5EfR4lSOjIsl3nItIrSYdGJbUXUH?=
 =?us-ascii?q?gdX6+rfCBhLUGnEoKOq0wsof7Uue9RlZlKOmDaZS79Zb1w+ce4CIGu9t?=
 =?us-ascii?q?fTG7IJbDN0i9lbj8z3L/N0idE3jxAudQ1lQ/tBK+FNyUNMf/EdQqaPKe?=
 =?us-ascii?q?p410Uoe+jfnyfh9Td3xsIPNQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 14:16:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707398170; x=1708002970; i=markus.elfring@web.de;
	bh=8VWfhqEp7JGVJ9KLK9ST2b4nWm+ATPmVE/3vjX6E5O4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=K3Vj8CPIvogqLBhjoxosDg3jO8sgIQi2M78GOosfI36iyVOU24mqYAdj1lLUjLca
	 iBNCdFlBTchOfcr8ZMJ318ZFhIK3KQEcVHfCPxq+v/jIiGp4yENVvLAq9D30XVc1g
	 FxQTFJ8y6iHCAnfH6Np5m3u+MnlkOsicwpuyVVKvM3eKlZSk9/vhJIkjD9PjmAYdC
	 Q/4wigmHagO5sJfLUhkKXeUaxCWgvWvqf9CV7aat2mED8uJTEpLJPdl1FGxaB0sBQ
	 /YBTA5PilKU51AAbcoqFbaW6xZ/ubeQB29iCxDhd/NLOvpUP8EiLIxqsAS1wxlxM0
	 1aMblVft+cEm8mdoRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6bCu-1qvwF221bK-017vhA; Thu, 08
 Feb 2024 14:16:10 +0100
Message-ID: <cffc1d24-5bb3-4a90-9593-31d3905449e4@web.de>
Date: Thu, 8 Feb 2024 14:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <dcb996ea-f041-406e-b641-0e6b515b9a0a@web.de>
 <7639c70-41e8-9a1-3a5-3a7711fc465@inria.fr>
 <1f8cb65b-715f-404c-84f7-8eee6de02352@web.de>
 <e2189114-2fa3-1045-1ae1-fb308b8c5c1f@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e2189114-2fa3-1045-1ae1-fb308b8c5c1f@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7g2zp41TXn/V1qnadps0ipk17JzczuMb3H6mBt7KjR11IOaPpdO
 32PKwagajK2JDPXnYp52sn7mIGvyp9D/pt292D3QQIY3krgeQ2K6RCsgaXLoOQ25v2MvZ3P
 ZpMZnaY908rdsQUDIu3FrWwyb/sZrDcIzw7gxS4iE3AtP+v6BZmZh2W52a3sRqEln6CX8+z
 aX2lNkPbrubR9/we3gpfg==
UI-OutboundReport: notjunk:1;M01:P0:LYlQNO8tiD4=;/yHgpJG62D4gCu1g8DnbdMhS80d
 UkQ5Q9hqApf2HNnwlIcSs+B2aTUIMFmGx4QpsAzcENYCKk1aHjHu/d1RYvx1jyofAfKLB1Bbl
 gPXu8SHm7Xg1pe6hx4w6uRDvIALvvQJeQ0UVb0VG8dfeUcpquQyWW8uniKFIKCtOKxcO6UzCx
 K+qZOIixpOp3+vC6vh3OO6d5K9jfkdu2lcF3CTvjgn5gHkuIP/MVRUJBCrouV+ARw5UGkhBG0
 d4B0BNE130ur4N4twRCV/03soHfYBPjdzusHBkq2NZQMQwu6pozP6yz737kfa8QDKS174WaBu
 hIY3ElYBAKnxuuFMtDa7zchkxa9hWFDRlfP5Y5e7/3QJyiYTxEoZqNronh4EisYJXm3xxVScv
 jnBUUsQWkLanEEFqms/IhbnZi0Fg4XQj+79Z83tT2od/X9byRqcbCjCRlJdH3xR7iFJ8ZSD5F
 ZTIxmNCYSWsqSKQ3Di1xQyGItHAD+4aoHT3FAqbAqggfsziu6kpGKm40nd3qsWvlONzAQCMJK
 /pEL3kjNJh5g6YYIJa/6nbc/PHyGe1KvrJoCYnsnKfz1r5dspF60jsF/+dXLpqYIZiVbmiFR9
 aLykv7+JvW0nSvmgEfK29EG++Om9OLVA//OxnorFMoYOkcMBgnMzu3kJyYzCdk3peqlAFjL1A
 bH8vN8DTQtrBvsOt1PvbhlStL4iIsg6G5sGWboyWJaCdAvubcw7Gr3ESHMs96EI3kjw+dzzYY
 8aIJlihcBXEAH6JOx92nb9J4fQab3bzeSJU7k0nPD04yVJVuGH3fE7pYYeKgc8ZMUIibWDpqA
 VS8zSznkjzL6YFfea96H2TYoPoNW2okCWepmAhZ5rz6/s=
Subject: Re: [cocci] Improving support for code positions with opposite SmPL
 dependencies
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1516
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/cffc1d24-5bb3-4a90-9593-31d3905449e4%40web.de>

>>>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --pa=
rse-cocci test2-switch_opposite_dependencies-20240208.cocci
>>>> =E2=80=A6
>>>> meta: semantic error: position cannot be inherited over modifications=
: call_pos
>>>>   File "test2-switch_opposite_dependencies-20240208.cocci", line 28, =
column 44, charpos =3D 572
>>>>   around =3D ';',
>>>>   whole content =3D position find.call_pos, find.declaration_pos;
>>>>
>>>>
>>>> Will source code transformations become better supported according to
>>>> opposite SmPL dependencies?
>>
>> I would appreciate more constructive feedback for this test result.
>
> Once you make transformations, the positions of the
> changed code have changed.

I propose to take the specification =E2=80=9Cadjustment2 depends on !test_=
switch=E2=80=9D
better into account .
This case distinction is already working as expected for the
specification =E2=80=9Cvirtual test_switch=E2=80=9D according to another t=
est case variant.

How will the handling of  =E2=80=9Cif =E2=80=A6 else =E2=80=A6=E2=80=9D co=
nstructs evolve further for SmPL code?

Regards,
Markus
