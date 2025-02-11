Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E05C021A4
	for <cocci@archiver.kernel.org>; Tue, 11 Feb 2025 17:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=gxPM2mnPwYaGS8uPtFsg4L2S0LZCPVbb23tfc42eovM=;
  b=Q2SUxvLt2oqxXj8pjroexFhYmfCvjiFjh+EDWNOeAiMoy62a0TweHk//
   WKgatBbKdZ2SK03h/bMw9fxnUL8ospaoybhbN1l+xTRhWyO9z8HXpkB8e
   4Kt4Sh1T2H0ATsWtD1ST/jl55xs7xYemmzoQzXIGpB2YUFzaWqqKRz/OG
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@synchrotron-soleil.fr
X-IronPort-AV: E=Sophos;i="6.13,278,1732575600"; 
   d="scan'208";a="207774929"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2025 18:43:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ABA9BE0D1E; Tue, 11 Feb 2025 18:43:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 48F5CE0260
	for <cocci@sympa.inria.fr>; Tue, 11 Feb 2025 18:35:54 +0100 (CET)
IronPort-SDR: 67ab8a7a_R5ByUcqqepslgoDa+rEFYM4gGf/9eSkhbGD+Bbza2Ex9sQX
 pf7XqXMQGAl+pqikE5tZvF+rwzrtpbfUw6DXr0g==
X-IronPort-AV: E=Sophos;i="6.13,278,1732575600"; 
   d="scan'208";a="108818461"
X-MGA-submission: =?us-ascii?q?MDGK5vH9MmpanBzRTuNVL22xCzAQKpTm1K4ruV?=
 =?us-ascii?q?oyr9zW9K2CT7awODtaAnHrHRXFJ5msqJ8+v8aTcZnlI6Dzzgjq1FAMWB?=
 =?us-ascii?q?S+UFrSbK/jQ1pG0kt63k8b8efJ9O3nUM1UJuPzHplSjtk+8Sdufrps81?=
 =?us-ascii?q?7wmHV/vZa5rxZvVH8uEev/xg=3D=3D?=
Received: from smtpout02-ext4.partage.renater.fr ([194.254.241.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 18:35:55 +0100
Received: from zmtaout04.partage.renater.fr (zmtaout04.partage.renater.fr [194.254.241.61])
	by smtpout20.partage.renater.fr (Postfix) with ESMTP id AB57EBFCC4
	for <cocci@inria.fr>; Tue, 11 Feb 2025 18:35:52 +0100 (CET)
Received: from zmtaout04.partage.renater.fr (localhost [127.0.0.1])
	by zmtaout04.partage.renater.fr (Postfix) with ESMTPS id A5746140348
	for <cocci@inria.fr>; Tue, 11 Feb 2025 18:35:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zmtaout04.partage.renater.fr (Postfix) with ESMTP id 9679B140382
	for <cocci@inria.fr>; Tue, 11 Feb 2025 18:35:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaout04.partage.renater.fr 9679B140382
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=synchrotron-soleil.fr; s=9F6402A8-1C0B-4606-AB49-0E95EABF6935;
	t=1739295352; bh=gxPM2mnPwYaGS8uPtFsg4L2S0LZCPVbb23tfc42eovM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=P4S3p+2SA/q18eKI5we0RGn8na6V5uSNg9YeRmNFY8QD9CyxV2mXcc1+IIZwauIPa
	 IojljGqP48LPm5Oh9g6BGv+eSgL0zkRl/tlDtUbjruHtt049UBH7BG1FwXuy4+9zmj
	 DNTZVv/UrnluOHnLq1SkT5+VSUbEjqw/4qf5q2yOE7f0hoQXl5S3+iiVU0fHTnl9n3
	 PPv9aLQGTKyEJpwZdZgLQHwCVRPIN52oLOh8zhRhsGoZOVABuD4GwlCY2xBb+W1Gzg
	 KD+6v2YnVuT8fs+LwzzCfKhiBd2MmwviA0lgHkbD4B8fUmYyeMY9TMWoUrTu9WG8gD
	 s7R79en2WV60g==
Received: from zmtaout04.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaout04.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id qR7KnQ4Nu78U for <cocci@inria.fr>;
 Tue, 11 Feb 2025 18:35:52 +0100 (CET)
Received: from zstore-b3-012.partage.renater.fr (zstore-b3-012.partage.renater.fr [10.254.240.145])
	by zmtaout04.partage.renater.fr (Postfix) with ESMTP id 79F01140348
	for <cocci@inria.fr>; Tue, 11 Feb 2025 18:35:52 +0100 (CET)
Date: Tue, 11 Feb 2025 18:35:52 +0100 (CET)
From: PICCA Frederic-Emmanuel <frederic-emmanuel.picca@synchrotron-soleil.fr>
To: cocci@inria.fr
Message-ID: <537594832.54620672.1739295352359.JavaMail.zimbra@synchrotron-soleil.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4652 (ZimbraWebClient - FF128 (Linux)/8.8.15_GA_4652)
Thread-Index: KAw05lD0TqihIA9LlPAnvl7pkfqbtA==
Thread-Topic: how to write an spatch in order to replace guard vs #prama once
X-Virus-Scanned: clamav-milter 0.103.8 at clamav01
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: 0
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucftgffptefvgfftnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffkufggtgfgofhtsehtjegttdiitdejnecuhfhrohhmpefrkfevveetucfhrhgvuggvrhhitgdqgfhmmhgrnhhuvghluceofhhrvgguvghrihgtqdgvmhhmrghnuhgvlhdrphhitggtrgesshihnhgthhhrohhtrhhonhdqshholhgvihhlrdhfrheqnecuggftrfgrthhtvghrnhepvdevudeigfekleeijeekheeftdeihfehfeekuddvhfeluddufeekueejkeeutdegnecukfhppedutddrvdehgedrvdegtddrudegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedutddrvdehgedrvdegtddrudeghedphhgvlhhopeiishhtohhrvgdqsgefqddtuddvrdhprghrthgrghgvrdhrvghnrghtvghrrdhfrhdpmhgrihhlfhhrohhmpehfrhgvuggvrhhitgdqvghmmhgrnhhuvghlrdhpihgttggrsehshihntghhrhhothhrohhnqdhsohhlvghilhdrfhhrpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptghotggtihesihhnrhhirgdrfhhr
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] how to write an spatch in order to replace guard vs #prama
 once
Reply-To: PICCA Frederic-Emmanuel <frederic-emmanuel.picca@synchrotron-soleil.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2409
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/537594832.54620672.1739295352359.JavaMail.zimbra%40synchrotron-soleil.fr>

Hello,

I am trying to write an spatch in order to replace  in my code, the header guard, by the #pragma once.

Is there somewhere a repository of spatches, where I can inspire myself ?

thanks for your help

Frederic
