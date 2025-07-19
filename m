Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0949C83F27
	for <cocci@archiver.kernel.org>; Sat, 19 Jul 2025 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=BhHjEzkEOO8Ng5Om3bpczRSJsz2YfH/Qyd1qjYEtfG8=;
  b=QTj8SZqFD7jIuUqWnurJg6+a+nDG7wMqxRXwCqq9v/SHUBFw2K/O1nZk
   A++YxiwEhlwKteUxjDf71nEsmBHBKTu+iFnCGadf9WFrqf42qbv3YdQ2c
   m2ElXnQNjSP1fgxPgr9X4fLEvFBpM233e5+dCDMGO530K4K0qwg4JgBBg
   c=;
X-CSE-ConnectionGUID: u4rfnO+oSICs1d+uAMycZQ==
X-CSE-MsgGUID: bgwuCXh7Rg+fu6Uc2Q9V8A==
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
X-IronPort-AV: E=Sophos;i="6.16,324,1744063200"; 
   d="scan'208";a="232306484"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jul 2025 14:05:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 773F1E0264; Sat, 19 Jul 2025 14:05:06 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DE206E0171
	for <cocci@sympa.inria.fr>; Sat, 19 Jul 2025 14:05:00 +0200 (CEST)
X-CSE-ConnectionGUID: BbiYGPdJSSyH9ybn1hVc2g==
X-CSE-MsgGUID: ZHxGidUOQimMXKPI/Btw7w==
IronPort-SDR: 687b89ec_OtjSvloeWQe77zCBH0Kxhc2bTfBxxKBy3Af/Q8rDdToLApF
 hCWfO45GKf94+0g+uqSKmh27m/e1zgTw4tMh1KQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EkDgCHiXtogAMP49RagQmBU4JEgQAGVDMEC0kIhE2PU?=
 =?us-ascii?q?IIhhD6PEIh4gVWBfQIPAQMBDUoEAQIEAQEDAwGRFQIeBwEEMQgOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhXsNgluBLIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR20dA?=
 =?us-ascii?q?QERJzQCJgJzAQGCfgGCIQEGEAEDMgcNBrEIgTKBAYIMAQEGgUYCEEFQ13UfL?=
 =?us-ascii?q?CJZgWQDBoEbLoVtgkoaAQVtiGCBOA+BVUSBPAuCeIMfAQOCK4MOgmmCJoEWg?=
 =?us-ascii?q?2Q2gjOBKpBvgUocA1ksAVUTFwsHBYFjA4EPbjIdgSeECIEOhCgrT4UQQViDU?=
 =?us-ascii?q?yRtDwaBGIJwQAIBC209NwkLGwY9kmGCcoEVLSyBXh+TfLJ/NAeCOIFnBYFfD?=
 =?us-ascii?q?IkIgSaVPQYTL5dRDgaTBJkGjgiVXoVZgWkBOIFcMxokgzZPAxkPklSBC8BKQ?=
 =?us-ascii?q?TUCCTECBwEKAQEDCYVGAQGJPYFLAQE?=
IronPort-PHdr: A9a23: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
 4qX/EocAChP+ZTY8JlFb/U=
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:A7/T1a8VlqpCnxLBhHpuk+D6I+orL9Y04lQ7vn2ZOiYlEfBw8P
 re+8jztCWE7Ar5PUtKpTnuAsa9qB/nhPxICOoqU4tKPjOLhILAFugLgLcKqAeQfhEWmNQ86Y
 5dU+xZFMD6C0R8gP33+Q+iDr8bsaG6GeyT5Ns31B1WPGdXgkxbnn5E4o33KCdLeDU=
X-Talos-CUID: 9a23:9Ev7GW8K4wMxEJSbVa+Vv2QeG/EKSnH/90zBAx6pA2AwSIOeE1DFrQ==
X-Talos-MUID: 9a23:HyU3fAnuD0CQj5szjBH2dnpQFNdH4qiTL3kMlLA2mPGlcgZsJGiC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,324,1744063200"; 
   d="scan'208";a="232306480"
X-MGA-submission: =?us-ascii?q?MDEwzLbM1PI7oSncuq1kKKwd2JAzGXWhUz2g8X?=
 =?us-ascii?q?u8scJQ4woCIeYlDsYxrK8XQ4l9AZuKQm70W0H+/DQ4XTmVrEkh6S1INl?=
 =?us-ascii?q?z+szaDjSx3w+qwRlBqmyRTrjsbhdo/GLZMO0RIze4LyAhOXChMOz4Evh?=
 =?us-ascii?q?Aq2VyXDMHwT7o1mh7pOluwHw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 14:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752926699; x=1753531499; i=markus.elfring@web.de;
	bh=BhHjEzkEOO8Ng5Om3bpczRSJsz2YfH/Qyd1qjYEtfG8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CI+qxFPL0U19ldn1Y6QkSx7zW3BjW828pgr9JuBZ5hR7M5mSAe6oAWYItiafnxZ4
	 P07QDAoNqcdVAMlMK24GBcWlGWMGkeNjlSbxZJLSWULOvYUaLYGwe55xr31OsNfcs
	 ZdEvGf9dcysFTZ8Ntdh+vFEq3OuKnA2W4iZAoym9P+1XcOGH54yW0RZYuC4WJa/vG
	 JY9ntaKQht9PcvptkQFXGYICxas+HS7SXRIAHCWfpQP2BpxOGpNli69gcLZs1Tnae
	 JgkHfoX+UmDGpKfVVQDvYULh3Ik9eipmvFLzStSSc3UMPLFOe7DWtMPFrp4ZFY7TV
	 4W15lyfQKmzj9ber8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.241]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8C07-1uXtW41oYN-00BRMV for
 <cocci@inria.fr>; Sat, 19 Jul 2025 14:04:59 +0200
Message-ID: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
Date: Sat, 19 Jul 2025 14:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ihiKPL5P1zAl5DhZbTFqYrkyj7RBoMrDLbqi9KfCCESKoRFbE5
 0iJswzVtpOnGil17C5Z4Eqcnj6GqIrKBY7yZBcFe4UpxLfZweOb3AB8EKan94dcMnNTA0o9
 x7p1Z2sfw9FMvbvE2FfN617lOnpjCa0ClKaXCa29rvmkEjMhnnBVUUqQmfqW6iZ8kce+ygj
 IAqVFr7iuCyMr4ES1wIZA==
UI-OutboundReport: notjunk:1;M01:P0:6ShpHr4x0oI=;JfCOtTwiQJ7WERcj8ajNCUgMJ8n
 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
Subject: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2876
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/0830325b-6697-49d1-a0a4-d06814c6450f%40web.de>

Hello,

Some information is provided also according to the question =E2=80=9CHow t=
o remove
useless parentheses?=E2=80=9D in the documentation of the semantic patch l=
anguage.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/2548098a0c8b148555f4b=
f11a12898ecaf023dea/docs/manual/tips.tex#L6-41

Another corresponding file contains a todo tag.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/2548098a0c8b148555f4b=
f11a12898ecaf023dea/standard.iso#L382-397

It seems that some conditions should be reconsidered.

I would occasionally like to capture detailed expression code by metavaria=
bles.
I am unsure about the properties of the found expressions which should be =
reused somehow.
Thus I would tend to enclose such data by extra parentheses.
A manual inspection would indicate then for an adjusted code place that th=
is
addition would occasionally be redundant.
Can this aspect be better supported automatically?

Regards,
Markus
