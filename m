Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3596CA0EED
	for <cocci@archiver.kernel.org>; Fri, 22 Aug 2025 06:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=IJPYeOMBQ22NcZZi2OKiI7lscCEVmrQ1tMvhax2CM5o=;
  b=tE293ZjicIzucwzBo8WD1QuNUKTJmjpiNyzrOn1ZRKnybDXdxO7PLtPJ
   rS+ijvGwT3xgw9qSu5YzsofD6hD9kfK4/+vUWQR1fiXD6mXR0DkvJjueM
   9hs/twdz4ELutqqUox/JiKsJHUuieGHDkXkbcb20i/clCXu0qh2Hus3IY
   w=;
X-CSE-ConnectionGUID: OeZXbJ4gTAKHdrWUiR2kNQ==
X-CSE-MsgGUID: 0V6TPsh4SlmpQ+9uAka7Hg==
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
X-IronPort-AV: E=Sophos;i="6.17,309,1747692000"; 
   d="scan'208";a="235732633"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Aug 2025 08:31:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 585CBE0BE9; Fri, 22 Aug 2025 08:31:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CF46FE0172
	for <cocci@sympa.inria.fr>; Fri, 22 Aug 2025 08:30:58 +0200 (CEST)
X-CSE-ConnectionGUID: OnkBBMr1R4maGe1fTDlFEQ==
X-CSE-MsgGUID: 1nwQDweNTsS4GuxTrKPrrA==
IronPort-SDR: 68a80ea0_1mA0e4jgSUmiJX52vzAZRFsop0n9PhNDMU+6eAkm0BQflQ9
 g5Znz8JIJCIJWafFgTEbL3xwloTPmqrqd35gT3A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E/CQBEDqhog07ASNlaHgE8DAILFYFTgkCBAQZUMwQLS?=
 =?us-ascii?q?YRVj1CGX48RiHmBVYF9Ag8BAwENRAoBAgQBAQMEggyPGwIeBwEEMQgOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw47hk8NgluBL?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBAQEBAQEBFwINOm0EGQEBESc0AiYCcwEBgn4BgiIBB?=
 =?us-ascii?q?hABAzUHDQa0EH8zgQGCDAEBBoJp13UfLCJZgWQDBoEbLoVsgkoaAQVuihcPg?=
 =?us-ascii?q?VVEgTwLgkcxgx8EgiuDDoJpgiaBFoNhhBKIbIl9gUocA1ksAVUTFwsHBYFjA?=
 =?us-ascii?q?4EPMjwyHYEnhAiBDoQnK0+FDkFYg1Mkaw8GgRWDZYIeQAIBC209NwkLGwY9l?=
 =?us-ascii?q?E6EZyCCEZNIsXeBCjQHgjiBZwWBXwyJCIEmlT4GEy+XUg4GkwWZBo4IlWCFW?=
 =?us-ascii?q?YFpATiBXDMaJIM2TwMZD446g2czt35BNQIBOQIHAQoBAQMJhUYBAYxWgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 9KJmK+hcF+qEvrR+tYAQdfZIoSLPSh5WSc=
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:JcBmnqhQ7yTwSJ7ifQuxZ4ZmLnBQXvgji2hC6mlwRA09TyXqrb
 HMoB19726StN9xYgBFpTnkAsK9qBznmqKdjbNhX4tKPzOJhILLFu1fBOLZqlWMJ8SUzJ856U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ds2g00NcelwAZsQiTuR5zzra3Gfz2R9b6YEKA
 ==
X-Talos-CUID: 9a23:xGA2/GMXMasBme5Dfy9k3mQxAJkfLnjU43qJLXOUDUhEcejA
X-Talos-MUID: 9a23:tnSTqQTGxo3aTJDrRXS1gi5bGNhlxZi1MxwijIU6oeq8LzZZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,309,1747692000"; 
   d="scan'208";a="123679106"
X-MGA-submission: =?us-ascii?q?MDEF0lDZvnhP9GueCtBo99yKf/HlivnJFG6Ncd?=
 =?us-ascii?q?5A1zyYSyXGSVaUOOdXHe1nPH5T2WaHDR9y2FzgdHMWEQFUCKgFNtkOEf?=
 =?us-ascii?q?7Nj4ihtpj6JJxM3EBqQ8XTbO+9nR2pmHzVhAwu1j/CrLM1ptm2kmy9Ru?=
 =?us-ascii?q?dhgBMHyVbyBOgPA6PBeBQH0w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:30:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755844255; x=1756449055; i=markus.elfring@web.de;
	bh=IJPYeOMBQ22NcZZi2OKiI7lscCEVmrQ1tMvhax2CM5o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YGs0u+w3D37jBJQK0ohlKDHFjSY80FIb9g+8rhqQ3RpsGQf+3djb3qpmPIhEqlmm
	 V4Oz7JfU78MpocSJzbeJvQ4Kh0zbYv/nRUD8arjV8fru6+cgSP6UY26Ey2Oe7+gx6
	 wKp+61c7MKZc4kO4JhlZnCMqpmD924mIAI7UY2PPt2DEhc35jTWCPi0fB9iKKFNT0
	 Odlz3K9bHaMsE8P2hnTWUOgKKJj9YStwSn9FI4qRlQw3jwSyWY95LLpZJ+XymwdSg
	 VnP8DPY+u6/WGDiai/3RiKANdYvuar7a6yZyOHWg9RFeJYMCGEWogPoxj8QtktsP6
	 VG8NuGHvXRtjC+j2fw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MECCd-1uhwuw2Q7R-00AwHf for
 <cocci@inria.fr>; Fri, 22 Aug 2025 08:30:55 +0200
Message-ID: <ae674fb5-8cc6-4807-97f7-92e2c4208149@web.de>
Date: Fri, 22 Aug 2025 08:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+n9GG8O42q9L5RLez1d7WlsyZmgw2pttlMddUiRDSq9Hb7AiGhL
 NnX2BA4ttjHc3Xbt9x0T/JOt3R/v9tae9WXoLaN4i6xQwYi6TlK5HRXEKzB1aMShlVccMfW
 46mqVFSS6aNfwJq7DI57PXSe0AZSpZgAKGEv60l/KFvgEgmZqHgmIx0RtF50uLGM68sCc5G
 wH7YJkMU1GA1tTpUbkZ3w==
UI-OutboundReport: notjunk:1;M01:P0:xE6N7R6oPQY=;CL+eAgMYT1AvtXqUn0LmGwhcOr5
 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
 ncO4Qt0nsEyUoIAV5apezDeam8j3RZb1Wn8Be
Subject: [cocci] Reducing the scope for a selected variable with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2974
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/ae674fb5-8cc6-4807-97f7-92e2c4208149%40web.de>

Hello,

I took another look also at the implementation of the function =E2=80=9Cpc=
i_bridge_release_resources=E2=80=9D.
https://elixir.bootlin.com/linux/v6.17-rc2/source/drivers/pci/setup-bus.c#=
L1711-L1767

I got the impression then that it would become helpful to reduce the scope
for a variable there.

Another SmPL script example:
@adjustment@
identifier xflags, type;
@@
-unsigned int xflags;
 ... when !=3D xflags
-type =3D
+unsigned int
 xflags =3D r->flags & PCI_RES_TYPE_MASK;
+type =3D xflags;


Questionable test result (by the software combination =E2=80=9CCoccinelle =
1.3.0=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> /usr/bin/spat=
ch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/reduce_scope_for_old_f=
lags2.cocci drivers/pci/setup-bus.c
=E2=80=A6
[no diff output]


How will clarification interests evolve further for this issue?

Regards,
Markus
