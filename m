Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB489CA1015
	for <cocci@archiver.kernel.org>; Fri,  5 Sep 2025 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=XNP/r+TxlRIurgNJHIgXFs3tWQ7nh7YZAwRJr9xKh9g=;
  b=fihtxYPANHahfmLL3Uv2ME++s4ZkreKZF1PbxT0zzISu0OCYylQuni3w
   7ZodJPADHC8oaww4isPr54Sw1fDvuvYTLukG5Ard53y6InNonjnmt+r9S
   qAs6cldBeONVMOKC4wC49Qzk2Krf98eD4/PCIXiYqm07QqORfwApuU7TN
   E=;
X-CSE-ConnectionGUID: YvShIFoAQyKzeMZlkE6Vrw==
X-CSE-MsgGUID: T1TQfrkSR2udvUENKhvSIA==
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
X-IronPort-AV: E=Sophos;i="6.18,240,1751234400"; 
   d="scan'208";a="237665982"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2025 11:16:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AB5CAE0264; Fri,  5 Sep 2025 11:16:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CC59DE0171
	for <cocci@sympa.inria.fr>; Fri,  5 Sep 2025 11:16:31 +0200 (CEST)
X-CSE-ConnectionGUID: zR2yjbkURVi2u6R5jrVatw==
X-CSE-MsgGUID: LvFes7icSieHkr+qy4Xarg==
IronPort-SDR: 68baaa6f_Az6MA6yOXZODkXIDfuhmM7YQNqsQT3OOyJixy+dz5OGAMPn
 tiPBsl/E/jwf7M0nPTUxltgKCQ5J6w/Y1hxVkKw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FNAADQqbpogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYI/gQdUMwQLSYRVj1CGX4c8h1WIeYFVgX0CDwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IIMgmoKjCsCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4KMYZPDYJbgSyBJgEBAQEBAQEBAQEBAQEBAQEBARcCR0YnH?=
 =?us-ascii?q?QEBESYBNAImAl8UAQGCfoIjAQYQAQM1B7I/gTKBAYIMAQEGgmnXdR8sIlmBZ?=
 =?us-ascii?q?AmBGy4BhWuCShoBBW6FNINCgSEPgVVEgTyCUoV/gw6CaYImgRaDWIQAiFuLN?=
 =?us-ascii?q?oFKHANZLAFVExcLBwWBYwMqNDEyPDIdgSeEAIENg1lFK0+FAT5Zg1Mkaw8Gg?=
 =?us-ascii?q?RWDXQaERUACAQttPTcJCxsGPZVvgjOCC4Jck0iRPKFFNAeCOIFngWQMiQiWZ?=
 =?us-ascii?q?AYTL5dSDgaTBAEemGgio0aFWYFpATiBXDMaJIM2TwMZD44hhDO5OkE1PAIHC?=
 =?us-ascii?q?wEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:dSm3d6F11GXcOmjupLqEMMeALOsnbusQ8zAXPo5KOH5om7+j5q
 OTdZMgpHnJYVcqKRYdcLW7U5VoLkmyyXcY2/h1AV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4pgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHSuQ6T9RZQpRoBUdAY0+6VMHfiLqX8KTMtOaYE
X-Talos-CUID: 9a23:zMFc+mMf2Cp3v+5DShM95UweGf0fTHyH0Snqfk2iN291V+jA
X-Talos-MUID: 9a23:AVX7OArUOyph3PtQGsgezxV8GspzvKWlM0EAsZYc+NCVaRx5ITjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,240,1751234400"; 
   d="scan'208";a="124726833"
X-MGA-submission: =?us-ascii?q?MDHPWH8gDLTQr/G97sVhvuPU4RW1NAB4Pr7eqs?=
 =?us-ascii?q?7svj+WSgGVt7DaOcGjWfP83qVVfmOqNnkI1f1xejzK1YOd+4OqMfK1lh?=
 =?us-ascii?q?TL6AoYExrrRrIoEzQrEVARlXQJc6iTyro/4ywsrHQG/tu+aldGETZP3u?=
 =?us-ascii?q?edJhsbk3G6uo1rDKsPJzdf8Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 11:16:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757063779; x=1757668579; i=markus.elfring@web.de;
	bh=XNP/r+TxlRIurgNJHIgXFs3tWQ7nh7YZAwRJr9xKh9g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PIDODqNqaIVfPDXrbRCynikhmJp6IvYw9KDqOZdZ+681rAR+3Iz9Sf1vTMvnuvTP
	 zz1NgN5JBzsbFQ9jpBz6aXGWJdk2HPeZ0swwgFVmjRItF3TPNU0guRk4gRjGxKrOn
	 hu+pRag1VZhoePBKawpUlbqB4YzxzbkwIFzwxL/dIVqxJZMof/rSPirJSw+lXUapA
	 ZsIW3PFiewOH4MNiGtaWKzzUsLu9iRXLYMOsvIL8VUZ5glP4bXMIm74yqlV6YTc/V
	 hutTdEaNAdyECuef7qsR0FGhUWCaQ4nWSIlqxYlsd8fb6ezFoeVrJs013N7Zd1b9w
	 nNxWHD8BLkFw6Ck36Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.210]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1u7uNu47FI-00qKoB; Fri, 05
 Sep 2025 11:16:19 +0200
Message-ID: <ba6b7f45-6c59-4ad1-9b4b-a02f34036d7e@web.de>
Date: Fri, 5 Sep 2025 11:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/eeXQpAaO2TDpJROFg9WwxgYije8mW7GHKOzTPKslDpAu/MVd6i
 3LoDrnw8GJSoTSjvlIVb52Bc7THzoPEjBgF9ACHE+bOkoQH8xqrajCWZdjj4k0CzwUjPHZ3
 RVtAJcN6nhXEiPpbfnEQpTy55KEc5lktctftm0LacDSM8mnjOM5qxu8p9c6vEtiKADrjyO4
 Kltzugzd8dBO5NEY2XkIg==
UI-OutboundReport: notjunk:1;M01:P0:O8KnwkyHYx0=;BCPwoR1mNgCJNCZvhdhmIxAfQvI
 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
 jdg7XKTA7inJKwG2cLW
Subject: [cocci] [RFC] Sharing data processing resources for selected SmPL
 scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2993
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/ba6b7f45-6c59-4ad1-9b4b-a02f34036d7e%40web.de>

Hello,

I became curious if further developers would like to try the following script out
for the semantic patch language.


@display@
identifier action;
type t;
@@
*t * action(...)
 {
 ... when any
 }


I interpret such a search approach in the way that it should extract some data
from a lot of source code places.
Thus I imagine that it results also in special software run time characteristics
which matter especially for big codebases like Linux.

How do you think about to clarify corresponding data collections
and computation resources?

Related source code analysis concerns can eventually be also clarified.

* Handling of function declarations in header files

* Relevance of some preprocessor directives


Regards,
Markus
