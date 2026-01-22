Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602D0C44500
	for <cocci@archiver.kernel.org>; Thu, 22 Jan 2026 08:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=oapfiMGVcCCumG5GbYmYUCsabBtKeykkn9QXMXYP5DU=;
  b=jKrosw3N5L+eXeCONdX2pU+y5DbvnS42ldstBbxZFSuM7U7M5KwWzaeu
   bUnVoInUR8Q1mX2vZTg9hq8YqGeatMESPTYRFWGR9o+Gw57pVtwkKkUGA
   diNQNl51HmFY4P/GrRdnfdRA+8fCrKIzxnsuootr31zgk253/V5HyQVYg
   o=;
X-CSE-ConnectionGUID: 8hdhwavYRmimYwieG0gxeQ==
X-CSE-MsgGUID: vQhLXT9bQz2SBMjgEBSMdQ==
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
X-IronPort-AV: E=Sophos;i="6.21,245,1763420400"; 
   d="scan'208";a="259788782"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2026 09:36:24 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7D6C781B9E; Thu, 22 Jan 2026 09:36:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8660280629
	for <cocci@sympa.inria.fr>; Thu, 22 Jan 2026 09:36:22 +0100 (CET)
X-CSE-ConnectionGUID: g5cwrb3/QPm+IZ9t9PSBbg==
X-CSE-MsgGUID: nOJyn504SlKf9KEWDxjj1Q==
IronPort-SDR: 6971e185_vBaumtUmekJTcV9ua10fH7qC+i2YA+1V8QixgwmxOVV0Yyv
 DCBXQ6F+8zvcuXBiucuOQKKTVwptL9fjsg+xFLQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FMAgD133FpgAMP49RaHgEBCxIMQIFFC4JBaB9fMwQLS?=
 =?us-ascii?q?YRYg0+MBIIhA4Q7jxGKToF9Ag8BAwENSgQBAgQBAQMBA4IMgi48CgKNCAIeB?=
 =?us-ascii?q?wEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHD?=
 =?us-ascii?q?juGTw2CYgEzcYElAQEBAQEBAQEBAQEBAQEBAQEBARcCDTpEAQEBAgEjHQEBE?=
 =?us-ascii?q?SYBBAsLGgImAgJWBgEUAQGCfgGCIgEGEAEDDycHDQawH4EygQGCDAEBBoEIU?=
 =?us-ascii?q?EHYSx8sIlmBZwMGgR8uhW6CZQGJbXonD4FVRIE8C4JHMT6CYQECAYU5gmmCJ?=
 =?us-ascii?q?oEOihAGiWtSeBwDWSwBVRMXCwcFgSNDAyovLSNLBS0dgSMhHRcTH1gbBwUTI?=
 =?us-ascii?q?zIGGQYcEgIDAQICOlMMgXYCAgSCEHuCAQ+HAIEABS5vGg4iAkF+AgELbT03C?=
 =?us-ascii?q?QsbBD2PXBoqgxBXAlARGiCBFwukeKFFNAeCOIFngWQMii6VPwYTL5dSDgaTB?=
 =?us-ascii?q?ZkGIo1nmziBaDqBXDMaJIM2TwMZD44hhAAzhGDAcEI1AgE5AgcLAQEDCYVGA?=
 =?us-ascii?q?QGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 LapqG9cnR1uZpg5KP6ITJc=
IronPort-Data: A9a23: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
 Qkix0DN
IronPort-HdrOrdr: A9a23:+NXbiq1PXgLjoQIVGwWdOAqjBeFxeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ4exoS5PwOk80lKQFq7X5WI3PYOCIghrNEGgP1+rfKnjbalTDH41mpO
 pdmspFebrN5DFB5K6UjjVQUexQpuVvm5rY5ts2uk0dKD2CHJsQjTuRZDz6LmRGAC19QbYpHp
 uV4cRK4xC6f24MU8i9Dn4ZG8DeutzijvvdEFE7Li9izDPLoSKj6bb8HRTd9AwZSSlzzbAr9n
 WAuxDl55+kr+qwxnbnpiHuBtVt6ZrcI+l4dY+xY/suW3fRY8GTFcFcsoi5zXAISSeUmRIXeZ
 f30lAd1o9ImgnslymO0GbQMk/boXoTAjbZuC6lqGqmrsrjSD0gDc1dwYpfbxvC8kIl+Mpxya
 RRwguixtNqJAKFmT78o9DEWhFs0lW5umAjl+l7tQ0gbaIOLLpKrcgB8FhOEJEGdRiKl7zPPd
 Mee/003swmB2+yfjTcpC1i0dasVnM8ElOPRVUDoNWc13xTkGpix0UVycQDljNYnahNAKVs9q
 DBKOBlhbtORsgZYeZ0A/oAW9K+DijITQjXOGyfLFz7HOUMOm7LqZTw/LIpjdvaMKAg3d83gt
 DMQVlYvWk9dwbnDtCPxoRC9lTXTGC0TV3Wu7VjDlhCy8jBrZbQQF++oQoV4rudiuRaBteeQP
 q6Mo9XBfj4RFGeZbqh9zeOKKVvFQ==
X-Talos-CUID: =?us-ascii?q?9a23=3ARlsVsmmJphQSqaLNVuNSjTmxoBvXOXKAx2jKKRT?=
 =?us-ascii?q?/MF5sC5ynGEPBwJhOmcU7zg=3D=3D?=
X-Talos-MUID: 9a23:nrDLzwWsDq84akvq/DnLpiBkaZ802KCNBhEuvKoqq8uGbBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,245,1763420400"; 
   d="scan'208";a="136697657"
X-MGA-submission: =?us-ascii?q?MDEL57JJSiZu0p8Au1bAJmTnZUaU5iq0VEifxc?=
 =?us-ascii?q?mlrhf0IfhgTf5EnM+WY8+6CDmYerepg5gxBbgq8GwpKuW+/TPbQGAy1G?=
 =?us-ascii?q?egbCtf7E9do6EsN9jwg3CE9bjWHNVV6+DCKNhkstbwSV5tUbFSEXPKEj?=
 =?us-ascii?q?wZ8MQ4ZIueoqmQHp63aSlWew=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 09:36:22 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIF2-1vKY2O2ciu-00SfyC; Thu, 22
 Jan 2026 09:36:20 +0100
Message-ID: <76e3b97f-1754-4de9-bebe-378bf5a7fe57@web.de>
Date: Thu, 22 Jan 2026 09:35:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 Victor Gambier <victor.gambier@inria.fr>
Cc: cocci@inria.fr
References: <87v7i7g615.fsf@mmap.at>
 <af6a88ac-fe87-47d9-8e55-b570f205afc4@inria.fr>
 <c393376f-a5b7-4e7c-b593-052528b9fcb0@inria.fr>
 <f222ef51-388a-441d-b9e3-c7abebc0a2d7@web.de>
 <258386cb-4f80-64a-4340-ec9b7c4d336@inria.fr>
 <421aee9d-5483-4c74-a149-778d439e33ff@web.de>
 <95d08195-7fa3-4d56-9947-ae5714a5a37b@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <95d08195-7fa3-4d56-9947-ae5714a5a37b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:C0lne7UzGVmRAxs0RE4Tj9MxxO/30dchC7eHvubSQPApVkRlwgT
 tpbFQh1VnjVd4IQcJY1shK4umdIel/oGwY+dnKi7ADjpFkSYfNg1QeEm7IXmGgZiyBYG2P1
 hBDdSuWBjfrQAUIsBGOjSrHoEc3m3Mme8sohy60lc/FAKiQhQD8qYhQvEFtHD+4RBDeWW9e
 nQ6oWVSqDpB9ewB2XTSSA==
UI-OutboundReport: notjunk:1;M01:P0:dzJI7mVmIsw=;eRMfWNMhKfltnTFFT6zS6NbBnZX
 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
 f6CyPNgs=
Subject: Re: [cocci] Evolution for the software build system?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3301
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/9GnQp56M1WNzEYi22HDTMQ>

> Where?  Why don't you send a link to that?

You probably know ways for distinguishing package sources
for involved software components, don't you?

How do you think about to support parallel system configurations accordingly?


Can we benefit any more from related information sources?

* Choosing Package Options
  https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.72/html_node/Package-Options.html

* Configuration and Cache Variables
  https://cmake.org/cmake/help/v4.2/guide/tutorial/Configuration%20and%20Cache%20Variables.html

* Arbitrary variables from dependencies that can be found multiple ways
  https://mesonbuild.com/Dependencies.html#arbitrary-variables-from-dependencies-that-can-be-found-multiple-ways

* Managing Dependencies With opam
  https://ocaml.org/docs/managing-dependencies


Regards,
Markus
