Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B611AC87FC9
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jEleOMbao1+3Xve3SZsIb6X9RrUMZcLi58f4E1M404k=;
  b=fbUIrSrSwgHgFjVAG4iajsFGjW2T6el+apaTO3UwgOePb4EBcYQdoKiA
   mcm+HLQtAuc1pF++fMgyTq6K2yUP3uwDKXuxNGJcKJjR7dB3zkEgLsMww
   3Wt/A9TV915pt5eoQkxAUoCK1Amxx2KLhXkJijSNcqnZbsFC7xUaLC3tz
   A=;
X-CSE-ConnectionGUID: kRLkWLa7RRuhWWaa6d7IUw==
X-CSE-MsgGUID: nj+0qAYdTA2DPbE63nKrQw==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233947601"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 12:13:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 85D8EE0172; Sat,  2 Aug 2025 12:13:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2994AE0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 12:13:42 +0200 (CEST)
X-CSE-ConnectionGUID: t1+J6sAmTQyGyHN3s6TMpg==
X-CSE-MsgGUID: RKjOJGLIRz+kthwhwqlzXw==
IronPort-SDR: 688de4d5_2cTxsF1O4shKMWjqK8Vp2WGqL7WoLJR4Qsmp3rz+zcQR2fg
 nyTBlFtwLAaGIWGGPv9PKS2p/zqF9lZPaUiYi7A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FbAACt441ogA4P49RaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDgQAGVDMEC0mEVYgchzSCIQOEO48RiHmBVYF9Ag8BAwENPREBAgQBAQMEg?=
 =?us-ascii?q?gyCLkYCjBoCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg06R?=
 =?us-ascii?q?AEBAQIBIx0BAREmAQQLCxoCJgICVgYBFAEBgn4BgiEBBhABAw4kBw2wNoEyg?=
 =?us-ascii?q?QGCDAEBBtpeHywiWYFkAwaBGy4BhWyCZAGGJ4NCeicPgVVEgTyCUjE+gmECg?=
 =?us-ascii?q?WCDW4JpgiaBFoNjjQSIcFJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ32DD?=
 =?us-ascii?q?YEOhCcrT4IidYF5QRk/g1MeBm0PBoEVGh4tAgICBQJDRYFgGQYaQAIBC209N?=
 =?us-ascii?q?wkLGwY9k1SDIQh6EywiMieBTZZGrmKBCjQHgjiBZ4FkDIoulT4GEy+XUg4Gk?=
 =?us-ascii?q?wWZBiKNZpNGh3OBaDqBXDMaJIM2TwMZD44hhAAzvWxBNTwCBwEKAQEDCYVGA?=
 =?us-ascii?q?QGLW4FLAQE?=
IronPort-PHdr: A9a23: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
 TYphwE4bel/rV/R
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:E4dKvKmTvTjeCDU4n7YnqSkkvNjpDfIB3DAbv31ZSRFFG/Fw9v
 re5cjzsCWftN9/YgBDpTntAtjifZq+z/5ICOsqTNOftWDd0QPCEGgI1/qE/9SPIVyZysdtkY
 llN4dzAMDtFlRh5PyKhTWQIpIPxJ2o/smT6ts2DE0AceipUcxdBstCZDpz23cWeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3AcFTFQGrro1c3JamgxfjjX5bmUdx8MV+D117VH3a?=
 =?us-ascii?q?pJndJbuaOF2O14Kwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AtF/aAA1ZBW9Cj14JVZGKjlYoKjUj2YesL2IitbQ?=
 =?us-ascii?q?8qYqHKSxvOyiEiCaHXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="122653608"
X-MGA-submission: =?us-ascii?q?MDEMpw1kYZ4t+A5frMTIo171W3Kz/jnm3eqs+o?=
 =?us-ascii?q?1bWI+zGT/tNdOPhJczPTsM9dS1LTLByqJnZO+9awCf5QhM4x64q5i9W6?=
 =?us-ascii?q?yOV1+pUmyVBEHfqledQIZ1YwMA5aOc6RalcXEPUwzcI/2EtL7iZX9645?=
 =?us-ascii?q?i7BiqwpQY6Mb/PzUY4vPFijg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 12:13:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754129619; x=1754734419; i=markus.elfring@web.de;
	bh=jEleOMbao1+3Xve3SZsIb6X9RrUMZcLi58f4E1M404k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DG5qPH4IGHDVcrpAc4e/pwMKoq88b2gcaI22yo9kjDHgtj0Hk9J6KBmt36tKsPi0
	 kj+4g10WD2bDBxCsOOtJKgb3kFcZQsGRmndge++oyI7jTqTbYqk4LqduSAuSVZow4
	 Rucwxamr3ykzXnmiNsXl/ea44z3jShGyoKP091WG6+c8TUOOVPivXzlMRqBwZOxVM
	 q22fdIaj5hWM/DWuel+Z2zYkH9dyFlnUdB5eZpWqf1jK/99TWA9W7a0TXMJ1ynBQT
	 K0lRNGdbp29XZhw8eFKmceheVK7O3qmmBmeuQlclijaYOgCdbdnGABhMcMV5ozj+u
	 JhCrwBVO07+4mcklJg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZnl-1u5F7u1tRl-00oKJh; Sat, 02
 Aug 2025 12:13:39 +0200
Message-ID: <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
Date: Sat, 2 Aug 2025 12:13:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t31gBgFNZPH0Iw53fv0H2oTBKBoolctZghwB825VY+U3TSWePdw
 ktU9y+unJc8HuHwUJbNQoK7ozPDe4WfC2xAF1hKT5bB0AeYmJRBuYNukaiFkk5K3O79y1v6
 tLEQ/8yUgeHp6HTWyhKbjekzqs6gtNfBxPg0kRwdxNyuTU8zSXHSskiztpWUYEKHxygA+W6
 ozxA4Lo0tOGSlbkjeo9ZQ==
UI-OutboundReport: notjunk:1;M01:P0:FKWNt1wVT+g=;7vi5c1NrtdvgYYloR2FPUJcL5lO
 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
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2925
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/70a43c52-f898-4fa3-a4b3-16c54bd4f9cb%40web.de>

> What is the goal of using <+... ...+> ?  The only way you should have
> multiple releases is if there is a double lock error.  If you want to
> search for double lock errors why do it only in the case where there are
> two locks involved?
>=20
> If you want to check for lock(a) lock(b) unlock(a) unlock(b), there is n=
o
> need for <+... ...+>.  Furthermore, you need to check that there is no
> unlock of a between the lock(a) and lock(b), likewise no unlock(b) betwe=
en
> lock(b) and unlock (a).

Would you get into the mood to clarify data processing challenges better
for another source code search pattern (like the following)?


@display@
expression x, y;
@@
 action_lock(x);
 ... when !=3D action_unlock(x);
*action_lock(y);
 <+... when !=3D action_unlock(y);
*action_lock(y);
 ...+>


See also a corresponding source file example:
https://github.com/coccinelle/coccinelle/issues/404


Questionable test result (by the software combination =E2=80=9CCoccinelle =
1.3.0=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time /usr/bin/sp=
atch ../janitor/show_lock_calls_without_unlock2.cocci test-action_locks-20=
250725.c
[no diff output]

real    0m0,060s
user    0m0,051s
sys     0m0,009s


Regards,
Markus
