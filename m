Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE71CCFA18
	for <cocci@archiver.kernel.org>; Sat,  8 Nov 2025 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=8XIrMNb+5mV4C08ENuezg3l8avgSx8wxn2zjM1PBIp8=;
  b=A4J65NuHpFveSkMWHsha+p4u4N2CpPx+nozFM0EDrxRyOdk/+Bpo8zIP
   dtp8RJ2GdGUnJd1y19lPo/mRNpScNt4GCNgh/nr+g3hRz2DbX8D5H8Wkn
   ieGzNSLA3RuXZdL3HtXdRFwpFS2h2apn/2xdPNW3a+DC8jk8tgPt0AWlh
   o=;
X-CSE-ConnectionGUID: a2NxnIIGR8KiRVdmzKs/zg==
X-CSE-MsgGUID: S3rb9PBiTEKsHNLsUzJNPg==
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
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="248293478"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2025 10:50:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B0BF5E0172; Sat,  8 Nov 2025 10:50:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7552AE0171
	for <cocci@sympa.inria.fr>; Sat,  8 Nov 2025 10:50:49 +0100 (CET)
X-CSE-ConnectionGUID: vC+BZ8GRRCihEHwgYTkkjQ==
X-CSE-MsgGUID: q0b8wiahQeWNSFjcHEI5rg==
IronPort-SDR: 690f1278_6LkTUbB9KKBG1TVA1jsSx5BrCXQRwt+TIDS9pVB2Vp0iNT2
 vzVViEwlXzp9hcCuJrVVqVLEOjPBeDgZnDYKquQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ERCwDDEQ9pgAMP49RagQmEEGUjWDMEC0mEVY9Thl+HP?=
 =?us-ascii?q?IdViHmDUgIPAQMBDU4BAgQBAQMEggyPUAIeBwEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGIC8NgluBLIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQJHbR0BAREnNAImAnMBAYJ+giMBBhABAzYHrzSBMoEBggwBAQaCa?=
 =?us-ascii?q?dd2HywiWYFkCYEcLoVugkobAQVuihoPgVVEgTyCUoV/gw6CaYImgQ6GJ4Juk?=
 =?us-ascii?q?E+BShwDWSwBVRMXCwcFgWMDgQtuMh2BJEEYcT1Xg0kiaA8GgRKDUYkkD4pgA?=
 =?us-ascii?q?gELbT03CQsbBj2VFZlzPLMBNAeCOIFnBYFfDIkIlmQGEy+DcZNhDgaTBZkGo?=
 =?us-ascii?q?2iFWYF/I4FcMxokgzZPAxkPjXgBhFu7dEI1PAIHAQoBAQMJhUYBAYxWgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 tWdzcobzR9d/tiS8cZOX6Dp
IronPort-Data: A9a23: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
 A3wUVY=
IronPort-HdrOrdr: A9a23:U9Joxa+IfWON3mEgWF1uk+D6I+orL9Y04lQ7vn2ZOiYlEfBw8P
 re+8jztCWE7Ar5PUtKpTnuAsa9qB/nhPxICOoqU4tKPjOLhILAFugLgLcKqAeQfhEWmNQ86Y
 5dU+xZFMD6C0R8gP33+Q+iDr8bsaG6GeyT5Ns31B1WPGdXgkxbnn5E4o33KCdLeDU=
X-Talos-CUID: 9a23:0/KXBWwwbi1mchvdJMGBBgUKMYMPQC3y9k37Ik+VKXlmeYGWSl2prfY=
X-Talos-MUID: 9a23:dPNX8gjrBm4tonHw5Fuc9MMpLZ9is7uvAUA0nKoggOeGPgxdGmqHg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="130331575"
X-MGA-submission: =?us-ascii?q?MDHPdoUQWXMb3zPXmXCOYqNKGyMI5/7o98/MFB?=
 =?us-ascii?q?YyzD+JpWGObNRjbO96YEZrNPYm79cxhzthtebuVx7jEnZkRQesrG/3SG?=
 =?us-ascii?q?tCgWYb5eVXf0bZ+m6Jl6KHzzUMAN5T6g0y0tTcjNZkZ7p1HXFqfS520n?=
 =?us-ascii?q?mfQch3IYtVLF5L6OfoOls+IQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 10:50:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762595447; x=1763200247; i=markus.elfring@web.de;
	bh=8XIrMNb+5mV4C08ENuezg3l8avgSx8wxn2zjM1PBIp8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IzqHWHcOYACt9dVp8KkJtIWpdGG71n5ey0auusZZnT8y4UM+X2XsESFRKm9wTzww
	 n5cMmb3jk/lLjHxBc2dYVMlG43yUQqLgH+hOgcXukbP4YV58mZJ/zVqCEmMeGBD9L
	 L6qD32r88wTUzAFk33gQkEkDuxsKUhGHoWR/zjCx3wLv49P1RupdNl7tWvVtAUiiy
	 jN/Dh8dSybLBjEumICUg68kwZeyuiLbs2m+FRlcGGd+CT9EoB91NMJfb6RzPjLGoN
	 azy0ZNX6d8a0WzkcM5nN2/Xnc3+73ACb14UX2AN8c4JlYaZuCkC2yD7VJ6W6Emm/O
	 CJmJmoXW+Gkwt8ieLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzmv-1vZ3zC2K01-00RwHm for
 <cocci@inria.fr>; Sat, 08 Nov 2025 10:50:47 +0100
Message-ID: <228c50a2-bb15-4abe-bef9-b0f9b95f6992@web.de>
Date: Sat, 8 Nov 2025 10:50:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KqrwbY4kS4gSlIbYICZ3Sxqc6yXG/RyZy6Z4uwUeplu5YkivYSZ
 KihUU8yctYZsvtjzAJ+wtZSIGwj88mwFrmCTSHk8dT8B7KAtate+qGqDXirtZuI6Y2bIl/B
 fFJyuv/4bEPOYqZjrc1Cp4cQDe/EIp9TuBIhGs/Q7n6sbeSnPNLSi8MiFhWeQhC6okTCKu0
 1t/upSYtYyn81O+ZFJdXQ==
UI-OutboundReport: notjunk:1;M01:P0:OeqSgWJkMgs=;G/UQWYSVgzoTLm/19sS6skbhhJe
 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
Subject: [cocci] Avoiding duplicate elements in SmPL disjunctions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3140
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/228c50a2-bb15-4abe-bef9-b0f9b95f6992%40web.de>

Hello,

I tried the following script variant out for the semantic patch language.

@display@
statement s;
@@
*while (1)
    s


Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci show_unlimited_while_loops.cocci
=E2=80=A6
(
*while *(*1*)=20
|
*while *(*1 *!=3D *0*)=20
|
*while *(*1*)=20
|
*while *(*0 *!=3D *1*)=20
)s
=E2=80=A6


An element of the generated SmPL disjunction got repeated somehow.
How do you think about to avoid such duplicate code?

Regards,
Markus
