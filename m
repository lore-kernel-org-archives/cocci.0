Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED01FEA834
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2026 08:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=QdISq1mLEkSmYiyHY5mgXBKhZJmxdxIL7BPpE2zLKjQ=;
  b=UTu2IM6qNPhDGZJgGUnB/YAhxsHMw0NCmLMU62sdUyRYWlVX4npP2Jvl
   fbx6heZ2ABQ9bj++D271pfJbEmWFTqckE/FstXNfoRGWxg399OlRvDAoH
   k8wj21wRF/GWB46JqDIQKEfePMtcuA9EZJw4VekmTWRTR8POw9cwvKvjW
   E=;
X-CSE-ConnectionGUID: iqINBigNSXOqXGKddtAWsg==
X-CSE-MsgGUID: MicGmxDsR9qO+7XaLFteyw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,139,1770591600"; 
   d="scan'208";a="269382334"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2026 09:48:15 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D0EE881709; Wed, 25 Mar 2026 09:48:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id EF74281709
	for <cocci@sympa.inria.fr>; Wed, 25 Mar 2026 09:48:09 +0100 (CET)
X-CSE-ConnectionGUID: KW1FnxXVSPmXNPbduTvK/Q==
X-CSE-MsgGUID: x0SwrxFySIGVkIohqeQ7Wg==
IronPort-SDR: 69c3a149_tTo9VWz+fw8P/3fsQAxYyGgmChHZ+DPZ83KlGeyv0jDBeFu
 qGByjfhw4PvmBQl0ruL9iTpwXhL150zyxVbiyeg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ELBQCcn8NpgAwR49RahRqBB140BAtJCIRQj1OGX48Ri?=
 =?us-ascii?q?HmDUgIPAQMBDUQKAQIEAQEDBJImAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QENAQEFAQEBAgEBAgQGAQIQAQE7Bw47hk8NgluBLIEmAQEBAQEBAQEBAQEBH?=
 =?us-ascii?q?QINOm0dAQERJzQCGA4CcwEBgn4BgiIBBhABAzYHDQavHYEygQGCDAEBBoJp1?=
 =?us-ascii?q?3sfLCJZgWcDBhWBCi6Fb4JKHAFziiMPgVVEgTyCUoNQBIIrgw6CaYImgQ6Rd?=
 =?us-ascii?q?YFKHANZLAFVExcLBwWBZgOBBjI8Mh2BIz4XNFgbBwWCBA+IbYFhgRIBg2JJA?=
 =?us-ascii?q?gELbT03CQsbBD2NSjODboEFgQiTbJE8jGKUYzQHgjiBZwWBXwyJCIEmlT8GE?=
 =?us-ascii?q?y+DcZNhDpMLmQaOCZVghViBfyOBXDMaJIM2TwMZD5IhM8h3RTICAToCBwIHD?=
 =?us-ascii?q?QMLhUQBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 J7DmfCrQAo=
IronPort-Data: A9a23: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
 PEhoVbO0RnAYAk=
IronPort-HdrOrdr: A9a23:p09cQ6yKbGOI2PGpVvS0KrPwDr1zdoMgy1knxilNoG9uA6+lfq
 eV7ZMmPH7P+VIssRQb8uxoV5PufZqxz+8W3WBzB9mftWvd1FdARbsKhebfKlbbakjDH4BmtZ
 tIT4g7LsHsBl5nisvA7BC/CMtI+qj+zEnlv4bjJ2wGd3ANV0iM1XYBNu4Rf3cdeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3AiJJB7mmIE4XVhhthlH8vLvFPPOvXOV7ilVnWM3+?=
 =?us-ascii?q?GMl5seJutQ1ONxL1H1PM7zg=3D=3D?=
X-Talos-MUID: 9a23:aK71MAbZ/4iIy+BTp2fXmytyGtZTwouQC2EKkYwLgpa7Onkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,139,1770591600"; 
   d="scan'208";a="269382236"
X-MGA-submission: =?us-ascii?q?MDFj3ZPSY8HgbueQkI2wsKsy6tdfib6WANDpNa?=
 =?us-ascii?q?4A7YOkMPvGrLBplm//5plBIRkcqsfv7GCENNOj0Ia0zP6Shy33jWmTcF?=
 =?us-ascii?q?gWclYARWEfRP2chJIVljkSvKG09nkaDKN+2hPDLMZKRIUnU9S6Pu8KPi?=
 =?us-ascii?q?JNQIdUoBTXo7565xkIjYcALw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 09:48:09 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4vNe-1vOKB23fUK-01525i for
 <cocci@inria.fr>; Wed, 25 Mar 2026 09:48:08 +0100
Message-ID: <1f5a4f0b-ed5e-4e16-a39d-f1289b7a50aa@web.de>
Date: Wed, 25 Mar 2026 09:48:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:f159sWtxmYcCYNtmz2f6XVPFB494I56hCzoM5DzgGlA1iWl0DMf
 SYehmtFuk/nFQ9DMQnwbz+6Yzx16mOLtSSM21cvJyLij46pKutcg6tOlA3pGPngp0WBleWU
 Vb/oOHbQF1Noi9IkN80KGApktV6bn0uAChE18gCPt6JdjO4kXxW0/xbtzuJY+yWDwUMNWFy
 3WWuRSobXidsD6mCHzqPA==
UI-OutboundReport: notjunk:1;M01:P0:nK97eTEV2bw=;/EK6SNom86sbxOKgfF08G2IK/4o
 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
 IOdhwXUHbLZuGJ5KnDGl
Subject: [cocci] Searching for function calls with known parameters (by
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3449
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/xBCE_V4seWlhvAuq15AaUg>

Hello!

A function like pm_request_autosuspend() has got the property that it needs
a single input parameter.
https://elixir.bootlin.com/linux/v7.0-rc5/source/include/linux/pm_runtime.h#L460-L483

Such an implementation detail can be easily determined also by the means of
the semantic patch language.
I imagine that corresponding data processing would become more challenging
if it should be determined that a varying number of parameters would be passed
to other function calls at the beginning.
Can function calls be restricted to known parameters accordingly?

Regards,
Markus
