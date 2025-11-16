Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4FBCD4F3E
	for <cocci@archiver.kernel.org>; Sun, 16 Nov 2025 16:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=L0H26lgKOX1ufWLExwMLEl0IphGXedNrW8RhDoUSEcM=;
  b=ZOzj3jksroJ9t0gJDH9dCTkFbB7NP6CivckXETi2SmbBfByTRVT1SQJU
   TbCOOmFKSguIyh0Ceqg79RXPaWRsk3UtyW/Sdf5KmxZtixUZAkOd8DZDg
   vaXRezAFFgrbfSHEN3Hao3uwLy5YiqVWjC6R1WwQlI48kn88DsOTtGSic
   U=;
X-CSE-ConnectionGUID: 1MJDjXAcTHCVcTfpKvOdtA==
X-CSE-MsgGUID: Sjfip8FBToyQPSb2bWOmqA==
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
X-IronPort-AV: E=Sophos;i="6.19,310,1754949600"; 
   d="scan'208";a="249399851"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2025 17:48:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 63E25E0B0D; Sun, 16 Nov 2025 17:48:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0A354E0171
	for <cocci@sympa.inria.fr>; Sun, 16 Nov 2025 17:48:51 +0100 (CET)
X-CSE-ConnectionGUID: QeuepWFaSPK9JdVBfiUkSA==
X-CSE-MsgGUID: QlTjJBDLTwia7LDJgeESSQ==
IronPort-SDR: 691a0072_l++boJmgxgwxFbyZlcBGRPn7Fpl8SROLupGPzXD6h39oyp7
 ro8bkBrFrX+vL4iN8wLH0/+7diwoV6nG3d7S0zw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H5CwAg/xlpeA4P49RagQmEEGUdXjMEC0kIhE2PU4Zfj?=
 =?us-ascii?q?xGIeYNSAg8BAwENSgQBAgQBAQMDAYIMj1ECHgcBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABQw4KMYZPDYJbgSyBJgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdtHQEBESc0AiYCc?=
 =?us-ascii?q?wEBgn4BgiIBBhABAzYHDQatH4EygQGCDAEBBoFGBQ1BUNd2HywiWYFkAwaBH?=
 =?us-ascii?q?C6FboJKGwEFbooaD4FVRIE8glKDUAEDgiuDDoJpgiaBDoYnkyyBShwDWSwBV?=
 =?us-ascii?q?RMXCwcFgWMDgQtuMh2BJEEYcz1Xg0kiaA8GgRKDUYkcD4pIAgELbT03CQsbB?=
 =?us-ascii?q?j2VDVGDDhoTLIEglFmzATQHgjiBZwWBXwyJCIEmlT4GEy+XUg4GkwWZBo4Il?=
 =?us-ascii?q?WCFWYF/I4FcMxokgzZPAxkPklSBC8JGQjUCCTECBwEKAQEDCYVGAQGMVoFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 pYDGOczaQ==
IronPort-Data: A9a23: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
 PzwgLMeNBjA
IronPort-HdrOrdr: A9a23:jQmNDKztZ6hO2qWLH1w1KrPwDr1zdoMgy1knxilNoG9uA6+lfq
 eV7ZMmPH7P+VIssRQb8uxoV5PufZqxz+8W3WBzB9mftWvd1FdARbsKhebfKlbbakjDH4BmtZ
 tIT4g7LsHsBl5nisvA7BC/CMtI+qj+zEnlv4bjJ2wGd3ANV0iM1XYBNu4Rf3cdeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3AeFzhxmudsoxTMJuxuRHys3mG6Iscf2DQ1Ej+KnS?=
 =?us-ascii?q?AKjdLRIO/R16t+5hNxp8=3D?=
X-Talos-MUID: 9a23:OptSkAS/s1dcWMUqRXTVgA1gFu1Ex5ixCUlStbkktMSpDhdJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,310,1754949600"; 
   d="scan'208";a="249399849"
X-MGA-submission: =?us-ascii?q?MDEvRGA96WJnd1nZzIW/OZbwY2ca65jlX/AA2p?=
 =?us-ascii?q?Z1Upw8z+FXJI9pvmCtuo+iPIBjYxFX0sQextIGY59y9nTRoZfrNZcARW?=
 =?us-ascii?q?MEC8q6gQY4dXCyhhx2pFyDeulT2cgZy3ZeoZt1+5GwkpSZ+5jFVpw7+p?=
 =?us-ascii?q?9e9Kx7fWweKt/twH16PxGP/w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 17:48:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763311729; x=1763916529; i=markus.elfring@web.de;
	bh=L0H26lgKOX1ufWLExwMLEl0IphGXedNrW8RhDoUSEcM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iZ5R0wlbJdyZqt1XQZSODcAY5YlBZMMKmE6u0URtAbuL5tgr3UaYuMs1hitCkvii
	 UC079yDRfYDd88AiJbgfMvEZT9V6vhb1fLLoZMh10WxQ2Aokkpqv0wpBgs89jtT2m
	 4dK0MxNgU2zhrMtMyTLImz9xoTaA6rKnsENcCB4KjkF9ZkORYj25K3tdz7ziwSe2k
	 qYpv2hlLRSClyxnH7KzCzXA53iwFCZW9DRyHz7RC2ufRm/1Tslh6rz1QDB2z3kTVX
	 AHH7+ic9bhVs9wM7CD+4okwknAWU9waulqRrkEI0YPjnjLi1IHPIkbQwgywolKMt4
	 qDybwmQy/sHkRLKzJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.193]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1ZT-1vseVS2rz5-00avBE for
 <cocci@inria.fr>; Sun, 16 Nov 2025 17:48:49 +0100
Message-ID: <f326b32d-7bfd-4b53-960a-d32ce50d11b5@web.de>
Date: Sun, 16 Nov 2025 17:48:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JgBag78Xga1atwYgXHvtXDzUhfUKKoXG/og1/GU6MXTO4nWPZ92
 YThPKUFU7cf5Yss/jxtkeBRXX8fteO39zSTWxulAfpxGCusIYjECGxrb3cPQ6pkxknXaWD6
 ad5lqLWRGVY1HdiOb9pcSklAE1xifQGUac1UAllzobt5mdUoDpOcj8NhQXoy43Xu35P7zz9
 jj+MnXWGYRzr1RX/ELPhw==
UI-OutboundReport: notjunk:1;M01:P0:siNxOVd/dwY=;DFpsy4nU+4d5/WtFBWkua+EVfKG
 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
 TxuT2IMuFA1otzzoU=
Subject: [cocci] Checking parse errors for command-line semantic matches
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3185
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/f326b32d-7bfd-4b53-960a-d32ce50d11b5%40web.de>

Hello,

I would like to pass some expressions for the functionality =E2=80=9CComma=
nd-Line Semantic Match=E2=80=9D.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731=
a9d546dc4f0b181526e/docs/manual/cocci_syntax.tex#L1920-1957

Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-cocci --sp '- EINVAL'
=E2=80=A6
minus: parse error:=20
  File "/tmp/sp-31268-2224d9.cocci", line 4, column 4, charpos =3D 31
  around =3D 'EINVAL',
  whole content =3D * - EINVAL


Under which circumstances will such data processing become better supporte=
d?

Regards,
Markus
