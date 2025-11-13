Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78783CD4F34
	for <cocci@archiver.kernel.org>; Thu, 13 Nov 2025 07:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=u5GkDFkXMReoDjckE9qEjjCbVzaiE8WTnpwNZ4n/bTg=;
  b=IrzhH9gKjfK3G9LJpfmmHQTafkLPSCpGMSedi3NwcOKrEflbiGcoW9PQ
   kpu0WnlhCsTXl6epbQPou5QJZvkcBeCO8m3rtTAhaetM/Tc196SUnONIl
   J5i5is4n7cwZjLzxKyH+WzvmHpufEWeIR1KBF+3knd71teT1356eY8ZVe
   Q=;
X-CSE-ConnectionGUID: NfWeqfS0Tju5zWLgFQzSog==
X-CSE-MsgGUID: xk67tYxaQ6S0orqnVsXinA==
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
X-IronPort-AV: E=Sophos;i="6.19,301,1754949600"; 
   d="scan'208";a="248886071"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2025 08:44:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A7EDFE0172; Thu, 13 Nov 2025 08:44:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0381AE0171
	for <cocci@sympa.inria.fr>; Thu, 13 Nov 2025 08:44:49 +0100 (CET)
X-CSE-ConnectionGUID: k7FpqTsWTTO5956LpOt9rw==
X-CSE-MsgGUID: Kudm5NR3RxuHtKcFc7wsBQ==
IronPort-SDR: 69158c6c_pyF+jyDa4XborSc/P0Q1Q+GDEHalozmaPFY0rQ4ooFkKXte
 pF3nLqLSiQRvj/Y9lKG9QxHixUC+5V33sIs1u2Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FFCQAWjBVpeA4P49RagQmBUIJAgQIGWDMEC0kIhE2PU?=
 =?us-ascii?q?4ZfjxGIeYFVgX0CDwEDAQ1KBAECBAEBAwMBkV0CHgcBBDEIDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAUMOCjGGTw2CW4EsgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOm0dAQERJ?=
 =?us-ascii?q?xgcAiYCcwEBgn4BgiIBBhABAzYHDQaVCJxGgTKBAYIMAQEGgUYCEEFQ13YfL?=
 =?us-ascii?q?CJZgWQDBoEcLoVugkobAQVuihoPgVVEgTyGIgEBAoIrgw6CaYImgQ6GJ4pTB?=
 =?us-ascii?q?ohggUocA1krAQEKSxMXCwcFgWMDgQtuMh2BJEEYcT1Xg0kiaA8GgRKDUYkhD?=
 =?us-ascii?q?4pVAgELbT03CQsbBj2VEoNdWYI9kzyxd4EKNAeCOIFngWQMiQiBJpU+BhMvl?=
 =?us-ascii?q?1IOBpMFh3ORE44IlWCFWYFqATeBXDMaJIM2TwMZD5IhM4ELwgdCNQIJMQIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 twCR+0DPLTUPvYdF1gjA9EIZpt6DGtMrA==
IronPort-Data: A9a23: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
 d0NgKYf5f3BYAl5
IronPort-HdrOrdr: A9a23:qUp9HKvyUCJH6KFm51gHITqK7skDVNV00zEX/kB9WHVpm7+j5q
 OTdZMgpHjJYVcqKRUdcLW7U5VoLkmyyXcY2/hyAV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4tgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHRuQ6T9RZQpRoBUdAH0+6VMHfjLqX8KTMtOaYE
X-Talos-CUID: 9a23:xQ/k42FBljtTIROPqmJkq2AMA/w+TUHh6yqBfhGcEUF1GaeKHAo=
X-Talos-MUID: 9a23:h970YAitJQsUv7w7K5AKuMMpF9pk5vmIMhs3gYgmp+qPGycvJCy3tWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,301,1754949600"; 
   d="scan'208";a="130674888"
X-MGA-submission: =?us-ascii?q?MDEmIMn8dZwF5bdJ4G4VhdfRtZOCtckIQAb4kn?=
 =?us-ascii?q?p+qpuyQOsz/r1uq/ZfpLpei35OCWIZMDtXqoaOeHukYooRvWKb8ghmeA?=
 =?us-ascii?q?c+8eFi6QCRcJHIMPZzzLkmcbz/IwU6bOEkl12hKL6oyZg0vWTEEWVUN+?=
 =?us-ascii?q?O+YcoTk5RgVALx7r5dNTphIQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:44:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763019883; x=1763624683; i=markus.elfring@web.de;
	bh=u5GkDFkXMReoDjckE9qEjjCbVzaiE8WTnpwNZ4n/bTg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uHsxNFjFTtiNtuVVQnxYMfY8aWtHAjhy0ySFw6472HSlxMZbYfMWbhae9oYr0ipf
	 /po0FpRfLwQxZQ3kPxJXCHZJaUNqg2JgVKX8p9roHmroRo4VsOYXeOLz/uyB2VSXQ
	 6qVU5xtzxCVPom2NLGacaor2dlyMT6emgcibM1kgtH47bEdHBVN3q977epPvH1Z+d
	 8SNbo3oXIcXWYtCjmDPyos5g+1ST5YJslSuS80xdxIx0l1+cyIlzo32pDBXQAs1K+
	 /itjnppvblEnsIi8mkm4N61R7islfFp3ibwM42AEQIkjU23ZA2ByGWZuSvd6IOXvl
	 RE3p3IygjvgPI/By8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.0]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mgzeb-1vowTf41BF-00en1f for
 <cocci@inria.fr>; Thu, 13 Nov 2025 08:44:42 +0100
Message-ID: <11be2970-5a88-4f1c-89a9-36b9cd635d3b@web.de>
Date: Thu, 13 Nov 2025 08:44:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ymv71KEo/vXnRvvhDaoa5CZG4dUOAdLH+Ju4TyJGTkDryMHs8h
 b0J2+uU0pIyqFZlP0eYu2ykkaqHjCilek0LrXBoC0+knEDCgsQkqo5SVYsQIcnICjyHH3XB
 N1E5vFLwWccDRPOnlplIZZGe9R58WZju+ySr2vtGetWCgGXRDsRNaaKDoQnCg4j+8GrRcEW
 I7veXrgVx818KP742Pqpw==
UI-OutboundReport: notjunk:1;M01:P0:AYSZ6rTUj08=;qQbGRbR2/zlkksKD1cB3/POb3H2
 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
Subject: [cocci] Using @ characters in string literals
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3172
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/11be2970-5a88-4f1c-89a9-36b9cd635d3b%40web.de>

Hello,

Special information is provided in the manual of the semantic patch langua=
ge
for the usage of @ characters.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731=
a9d546dc4f0b181526e/docs/manual/cocci_syntax.tex#L50-55
https://github.com/coccinelle/coccinelle/blob/9e8fb87bd681a6f5ee9ae43df632=
2d2c5ee7887b/docs/manual/cocci_syntax.tex#L50-L55

Thus I hoped to achieve corresponding adjustments also by the clarificatio=
n
approach =E2=80=9CConfiguration or escaping of @ characters for embedded p=
rogramming
language scripts=E2=80=9D (from 2014-12-26).

I observed that the character =E2=80=9C@=E2=80=9D can be used several time=
s within string literals
(in Python scripts for example).
How will the data processing support evolve further for such a technical d=
etail?

Regards,
Markus
