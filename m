Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8D6CCA468
	for <cocci@archiver.kernel.org>; Tue, 30 Sep 2025 12:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=AdSR6WEFS0AAw89ab+wWMeX/nyNMv9CG8mNEPY0OgiY=;
  b=U3pSbtv/37sK/DYOuY6wuh0BZrrpyWm4ZLS/hpNfTmdmxhEWP7A6vkjl
   /ZiR9g8qJ0hh4R9VIR/CGbGvJWngfKuWF8em3YLlqjuaVsYKn6OsmWM+8
   Cg5lDHeZQR4BUN3H+kfyW45s+c5V+NSZYhOSoMeiCZ1ODaKMqQL4jvESr
   I=;
X-CSE-ConnectionGUID: otnWshqdTei2OQ8ftzHFqQ==
X-CSE-MsgGUID: fFx9IYJQQDyGzj6Uqp18Ww==
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
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="241771489"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2025 14:10:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5456CE0264; Tue, 30 Sep 2025 14:10:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 02C83E0171
	for <cocci@sympa.inria.fr>; Tue, 30 Sep 2025 14:10:46 +0200 (CEST)
X-CSE-ConnectionGUID: nEuNmWvDRVa/Ck/kAL6lLw==
X-CSE-MsgGUID: yskWvmFlQeK12eEvF1ltlg==
IronPort-SDR: 68dbc8c6_OlcpR6t7/J0+tRC1n1pqES4Tq3G2CWMNUoWvkn3TYx1TJBb
 EVuZ5BpkIA8QbjcadLUlvViOo2cu9RmJT3jBsaA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F3BABUx9togAMP49RagQmBU4JAgQhUMwQLSYRVj1CGX?=
 =?us-ascii?q?4c8h1WIeYFVgX0CDwEDAQ1OAQIEAQEDBIIMjzwCHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYYgLw2CW4EsgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEdAkdtHQEBESc0AiYCcwEBgn6CIwEGEAEDNQe2dYEygQGCD?=
 =?us-ascii?q?AEBBoJp13YfLCJZgWQJgRsuhW2CShoBBW6EaYUuD4FVRIE8C4M2hRCDDoJpg?=
 =?us-ascii?q?iaBFoNYhACIWY8FgUocA1ksAVUTFwsHBYFjA4EPbjIdgSeDfoENhB4rT4UCP?=
 =?us-ascii?q?lqDUyRrDwaBFYNbiXEPegIBC209NwkLGwY9mG+EQBOWJbMBNAeCOIFnBYFfD?=
 =?us-ascii?q?IkIlmQGEy+XUg4GkwWZBqNohVk2gTI6gVwzGiSDNk8DGQ+NeAGEW8glQTU8A?=
 =?us-ascii?q?gcBCgEBAwkBgVWDcAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 IGnfEfbNzpItd7Zr5N0Og==
IronPort-Data: A9a23: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
 aXZi4yJrIFXhHMdyfpdRkM=
IronPort-HdrOrdr: A9a23:dC+02K+k5ODKTawXdLVuk+Gkdr1zdoMgy1knxilNoERuA76lvu
 i0lvUayhP4zB4NMUtQzexoWJPqIU819fZOkPIs1MSZLXzbUQqTXcBfBOTZskPd8kfFmdK165
 0QK5SWZOeAdGSSrPyKnDVQVuxQs+VuHsiT9LLjJ1kEd3A1V0hL1XYnNu4CeXcGFjWvPPICZc
 mhDiAunUvwRZ1vVLXqOpBnZZmCmzSoruOWXfdcPW99mVOzZFqTgdaRfnb4r3RuMUIrsNNSlh
 mir+W63NTSjxjc8G6a64b91eUKpDKL8KoGOCX4sLlpFtyasHfTWG0OYcz7gNgKytvfrmrC2+
 O81yvId/4DnE85E1vYnfKX4Xie7B8er0b4z1mWmH3iptG8ag4bJqN69MFkWyqc0lEnut5k1q
 JNwia+jLp4ST39vAmV3amLazha0nOup3wsiOgSiGEaa5IXbPt9oZEW/EZOVLsGFkvBmcUaOd
 grN9vE7PJaNXuRcnDeuQBUsYuRd0V2JQ2eSkwO/vSI3yRb2FB1pnFo7fA3rzM67os0T5QB3e
 jeLahy/Ys+GPP/ZshGdb48qNGMe0fwaCOJCnubJVmiL60cJ3fRwqSHyIkd1aWsftgB15EymI
 vMOWko6VLaVXief/FnhvBwg1nwqEbRZ0Wk9ikfiqIJ8IEVCtfQQGC+oB5Fqbrvnx2sb/erEM
 qbKdZKB/f4IS/0FZxU2hCWYegfFVAOFNAQssw2H02DudjKLIqCjJ2VTMru
X-Talos-CUID: 9a23:rq6gzGDw9Ddetp36Ey9K6WgRJd4JSEPUi1zTZEyRLThtbKLAHA==
X-Talos-MUID: 9a23:HXfoKgaSgW5P1eBTpiTvuy9nGsNR7of3Uk0gj7tfv9WAOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="126932555"
X-MGA-submission: =?us-ascii?q?MDFiN39HDyhQB27N06B8+b9hbPKFgYBZn1zh2E?=
 =?us-ascii?q?8KFLJo5inB6rsdRZcRCGBVc0y7qOJyIMJMLV5OqaQzomrII4Dyu25tUD?=
 =?us-ascii?q?zuCRAawnzpLiCWq2u1Ilbk7LIcsWlaEKQH0GD66nGVuvQ0Vgg4mc83Yz?=
 =?us-ascii?q?90Sae9CMv2ERv5NWWANFR29A=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 14:10:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759234245; x=1759839045; i=markus.elfring@web.de;
	bh=AdSR6WEFS0AAw89ab+wWMeX/nyNMv9CG8mNEPY0OgiY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bLrQFIi+f9eDAkTDWYcp565fENeDCmzYQEJgKx5Rqm9izAuUVcSxYFrdrVumIzUm
	 eQDWygtu+zVDlpHYkk2kX+z+sEAnGUhe3T+7ok2U0He++IA272AvmJez+4mEW7/Ve
	 bgw9CvW8j9ntJGG1OgP1Rfbhp3Rq7mczB+O9fuh8ffYPTDvr8TipllgVqwfI8S77c
	 DJfcQMwlzwA6Cqny8inb8vU1LmtnsEId7idnWIMn5xQH0ROjx3W8fQQ6hxpZII4sG
	 cTMy8D7vCNdP+MBFZKK1GKX1O6vuVuzszOZEAMp1efroHBCG0YB0trzF3cNf+7xuM
	 tiulxHnmUFfrN9/JAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3Ez3-1v2BkO0lDh-000YU7 for
 <cocci@inria.fr>; Tue, 30 Sep 2025 14:10:45 +0200
Message-ID: <af6b39c4-c4dd-4d0d-8978-bc68ad533729@web.de>
Date: Tue, 30 Sep 2025 14:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z9h1Mdy41b1gkGmAiU7Y6ClNUl5coSwxFs06QBY+0I5IHvJ0s7e
 M4LSjuwgjBOOBc/gIoisiZRoBjpKwOt6FZW0+91+u4hLs+nvlY1aFkm5a8Ww18iEBpEqog9
 zGGA/5w8Enbb+PH2w9s4NL2g+ekngonu92CC1leFzNeZyhPnTHrSSIJed8bNvQC9lQhqmJO
 qXlwcPujEB5jKFsOXYPLg==
UI-OutboundReport: notjunk:1;M01:P0:wsij2TRhfIQ=;MRYsKrzkZGjD7s0Mn6ODhtA59bR
 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
 CplCwRUYER62Bq2pvlb0x7Q==
Subject: [cocci] Adjusting source code behind =?UTF-8?Q?=E2=80=9Cdefault?=
 =?UTF-8?Q?=3A=E2=80=9D?= with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3055
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/af6b39c4-c4dd-4d0d-8978-bc68ad533729%40web.de>

Hello,

I would appreciate if another source code transformation can be achieved
also by the means of the semantic patch language.
Thus I tried the following SmPL script variant out.

@addition@
@@
 default:
+special_action:
 my_action("Hello!");


Unfortunately, I was disturbed by the following information.

Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-cocci add_label_behind_default.cocci
=E2=80=A6
minus: parse error:=20
  File "add_label_behind_default.cocci", line 3, column 1, charpos =3D 15
  around =3D 'default',
  whole content =3D  default:


Under which circumstances will such data processing become better supporte=
d?

Regards,
Markus
