Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7054D609AD
	for <cocci@archiver.kernel.org>; Tue, 16 Dec 2025 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EdN0EjW05ttpkbLIMNBG774R5f00tBXBywdgYj9cy7E=;
  b=pLLMpvWUun3+6Hrb/MkTQkHAdI8zk2BIKv3eWduB8rwqdwWcKrqHHIy7
   /pC4v8g2zKYkvOTpUWa807bhf5mvIPMyMa0mBy1ILwWz+EbxlFI3UyWeG
   bHaJX8SEcVxRMg8eNn/PCPsuWse+gp4t00NAFRjMkGNiwOf4Cpdyvofpv
   E=;
X-CSE-ConnectionGUID: bkzkSgRHQkG41n5lfOwRvg==
X-CSE-MsgGUID: TVQSbjZTQvCIds6Cmox7Uw==
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
X-IronPort-AV: E=Sophos;i="6.21,153,1763420400"; 
   d="scan'208";a="254732941"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Dec 2025 16:25:16 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1572081C56; Tue, 16 Dec 2025 16:25:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (dsi-ha-lb1-dmz.inria.fr [128.93.162.100])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7136381C56
	for <cocci@sympa.inria.fr>; Tue, 16 Dec 2025 16:25:12 +0100 (CET)
X-CSE-ConnectionGUID: scrtsO8ORF2y6i+dZhN+Ew==
X-CSE-MsgGUID: +dowO3FtT/K2OGB9CAD7SQ==
IronPort-SDR: 694179d8_Ym2t+jqvlQJoNo2iEQoI/hp7fJhnVPeNtryvptrx4h1039y
 /6hJTFisZ5JKuuPqnM/RnrTCrEo4/7ddBpjk4ag==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ErAAA/eUFpgA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYI/gQxZMwQLSYRViByHN4IkhDuHPIdViHmBVYF9Ag8BAwENTgECB?=
 =?us-ascii?q?AEBAwSCDIJqAQkCjGkCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQE7Bw47hk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBA?=
 =?us-ascii?q?QECASMdAQERJgEECwsaAiYCAlYGARQBAYJ+giMBBhABAw8nB7M1gTKBAYIMA?=
 =?us-ascii?q?QEG2mEfLCJZgWQJgR0uAYVtgmUBhimEPScPgVVEgTyCUjE+gQUBhxiCaYImg?=
 =?us-ascii?q?Q6Zd1J4HANZLAFVExcLBwWBI0MDKjQtI0sFLR2BIyEdFxNgPRdAg0kYBmgPB?=
 =?us-ascii?q?oERGUkCAgIFAkA6gWYGHAYcEgIDAQICOlULgXYCAgSCGH6CCg+HPoEBBS56J?=
 =?us-ascii?q?TICAQttPTcJCxsGPZUTToZjpD6hRTQHgjiBZ4FkDJ9sBhMvg3EBk2AOBpMFm?=
 =?us-ascii?q?QYiqR6BaDqBXDMaJIM2TwMZD44hF4QcyERCNTwCBwsBAQMJhUYBAYxWgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 hsxlxc4fuknsjvhsQ9fGw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:VEHpLqFXOOhJiIrOpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 WTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:uGH/0WP0z6H/Fu5DQyJ96FUzSucfXCfMknaTL324LyVEV+jA
X-Talos-MUID: 9a23:SuKebQb0mmwZ3eBT9DPrmxY5GttUpIf0L28nwL4vl5a/DHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,153,1763420400"; 
   d="scan'208";a="254732923"
X-MGA-submission: =?us-ascii?q?MDEmxj1CH2HMfLpcbINadmMWWXfF+IXjAPB0x5?=
 =?us-ascii?q?MMJEvzNvjuN4CZwP/RpJPFbcI2b4++Q93OfsCfTFiIDe1Dw4jEsUv+ab?=
 =?us-ascii?q?xsk1tG0j5OTHK+ZLZIgVFjxXwR/QPNkCKMMrW1nQDAt1sfcI7vgEArMZ?=
 =?us-ascii?q?PR35GT0K/nCn/BaHQ7lvFFyQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 16:25:12 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkElZ-1wFXr41PU9-00lKG2; Tue, 16
 Dec 2025 16:25:03 +0100
Message-ID: <951741e8-a44a-4a8c-880b-09343443cab7@web.de>
Date: Tue, 16 Dec 2025 16:24:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <87v7i7g615.fsf@mmap.at>
 <af6a88ac-fe87-47d9-8e55-b570f205afc4@inria.fr>
Content-Language: en-GB, de-DE
Cc: Manuel Wiesinger <m@mmap.at>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <af6a88ac-fe87-47d9-8e55-b570f205afc4@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sA4p6dNIqYF0ujicnSY+Qs5rUsdZ+vKZ7lUcJp3GDEvSrxg3VWR
 8JLIrTGp3gRoG5PExYGPu7hOg3KFs6xLvrrrMF2ij57/3EeM5XQr+je6IbUkDy4MYnqfAu7
 rJUNMK+6aiR+6VNAaQjdbEuUqWd0wRfwgV4oMipXlI8BFlkwFed2ycBFXF+b5rhvV7inFHA
 sdf4etlaWhXyBTNKuvuaA==
UI-OutboundReport: notjunk:1;M01:P0:2nq9QWV3d+c=;Fh7JuObsv4bZYUsY7beWmizdzRE
 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
 wjwnzBSFg/JT/RXSA=
Subject: Re: [cocci] Pre-compiled spatch links against EOL PCRE version
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3265
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2025-12/sSJD_4JKD4Xa1HR_ti5wUQ>

> You're right, we should move to PCRE2.

We are waiting on further collateral evolution.


> Olaf Hering suggested a patch earlier this year to do just this

Adjustment possibilities were demonstrated.


> and I forgot about it until now.

How could this happen?


> I'll work on reviewing and merging it.

Will development interests grow also for extending corresponding
software build configuration parameters?

Regards,
Markus
