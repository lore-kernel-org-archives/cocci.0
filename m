Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D83CCCD195
	for <cocci@archiver.kernel.org>; Wed, 22 Oct 2025 09:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=i4eirF8jtI1nYSFbvxzcMcda4NE6wKBk2RNZSwfFdKc=;
  b=FbKCbH349VtYUHFtI2fF2djPmWo6UD6J8fgGvDek/GQpjdWBLdBm8J1M
   SiUZB1w36U2uLspeQbgLf2XfCDafr2uUi5/xNOBJE+eqQsGXWyKS8Z2L4
   HPKv2hfD4E8bg1ZMqG3Gzo6f+FaSg4PO8sZbBNlEcZgt7rNhI0Pt/c1g3
   w=;
X-CSE-ConnectionGUID: 8fdHlWZTRXiQAYS2idhDhg==
X-CSE-MsgGUID: fhg94pv9R4WBte+BxXczRA==
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
X-IronPort-AV: E=Sophos;i="6.19,246,1754949600"; 
   d="scan'208";a="245598314"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2025 11:20:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 60A34E0BE9; Wed, 22 Oct 2025 11:20:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 82039E0171
	for <cocci@sympa.inria.fr>; Wed, 22 Oct 2025 11:20:55 +0200 (CEST)
X-CSE-ConnectionGUID: qMNFvNqVQFCcJEvhgKmt5w==
X-CSE-MsgGUID: irDyRVQjSSqX5/2YsGySeQ==
IronPort-SDR: 68f8a1f7_KZjsGQPl0g5LtZhdN1i9pXvvkGG37h9ImoFnTcM4WH2+w6R
 Ua/tAUCwOBtcdQTaoZh7JG/O+bjAjWO8rDJfrxA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EvAACLofhogAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYI/ZR1eMwQLSYRViByHNoZfjxGKToF9Ag8BAwENPREBAgQBAQMEg?=
 =?us-ascii?q?gyCdAKMTAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgoxhk8NgluBLIEmAQEBAQEBAQEBAQEBHQINOkQCAQMjHQEBE?=
 =?us-ascii?q?ScPCxoCJgICVhsBAYJ+AYIiAQYQAQM2Bw0Gry6BMhNuggwBAQaCadd2HywiW?=
 =?us-ascii?q?YFkAwaBHC4BhWyCZAGKZCcPgVVEgTyCUjE+gmEDgiyDDoJpghEVgQ6BdIQ0k?=
 =?us-ascii?q?UVSeBwDWSwBVRMXCwcFgSBDA4ELI0sFLR2BJyIfGBNgPRdAg0kbBmgPBoETG?=
 =?us-ascii?q?UkCAgIFAkI6gWkiBh8SAgMBAgI6Vw2BdwICBIIbgRCCKQ+GawIBC209NwkLG?=
 =?us-ascii?q?wY9k0Asg28ZAoEgphWhRTQHgjiBZ4FkDIoulT4GEy+DcZNhDgaTBZkGjgibO?=
 =?us-ascii?q?YFoOoFcMxokgzZPAxkPjiGEADO9OkE1PAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 J8JV6MdS1E/UP8XWBwNIQ==
IronPort-Data: A9a23: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
 Q==
IronPort-HdrOrdr: A9a23:NO4rKKrZZ3b8rtCCbXhs4P0aV5r1eYIsimQD101hICG9Afbo8/
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkOos1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:AeZx222Vz2kajoXGtIEUTrxfA+UDXGP71UnpDWSzK0t3SLK2TEPN5/Yx
X-Talos-MUID: 9a23:ZDbrdAi67w7gSsR1S0b22cMpNd1E8p6QMUI2qow25o7eBDdfKgyQtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,246,1754949600"; 
   d="scan'208";a="245598311"
X-MGA-submission: =?us-ascii?q?MDGULfJDmc6FQMXe9DVfd1oPwAxkH2UApjdA53?=
 =?us-ascii?q?HfsZSJfLOab//eGnOhJqEE/MHrkRiAPVF+d7SDa4oTHHaRplnp+wbjJ0?=
 =?us-ascii?q?H1u+OzTYNRo+c+fU6hOAjyYC+Eat6+3qsDdAdtFxSLhGo0m5GyIA5lAg?=
 =?us-ascii?q?PzdOgckA2XG0G+x4rCDWSmow=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 11:20:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761124854; x=1761729654; i=markus.elfring@web.de;
	bh=i4eirF8jtI1nYSFbvxzcMcda4NE6wKBk2RNZSwfFdKc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YWevv+hpfsiw18fgtNcQRA/DzBHLTewqZIrtGMvyPxjSxmn0YtGuqnlvQv67IrZY
	 FFzm7eMqFHpuDRT7O3t9yFn1xMl+Fh0zfjCBHvPTLOe1Z/jojhYdcmNcKP8TeVRbB
	 mbBr1xz79uztXfhTm/lmbEM/7MrDzAXba33ffraj6cCIym4PW+vLjl94oWfByP5tq
	 6Uru1DEf65krZLpYRoBwFjQeqdng3SuS2Vf5goDZ46URe1c5UNh25NYBjiPsBfBcq
	 bYvn0j/g3MC580PfsYWxaX0mb5eP1CT+3uAraRbngZF9mM8X2l9tX24yIWF7Y5qm/
	 tD+KgsJDkfOmgqdLBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJFdP-1usbUr0be7-00YEUn for
 <cocci@inria.fr>; Wed, 22 Oct 2025 11:20:54 +0200
Message-ID: <6809504b-39d7-48e3-97d3-de5d0dc951c3@web.de>
Date: Wed, 22 Oct 2025 11:20:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <4afdfd37-3177-4480-9648-ab0d7f59097c@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <4afdfd37-3177-4480-9648-ab0d7f59097c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4mFljw2EvdwhKkCBefcZuZ7UdUcfOFZYNdf6Thv+0va/X9GD1B6
 M/71HpSi40JC9Kd8b0th3LlXC2O/x1Q6DboscBsG0V5xlKDESudC+JLFvKLSC8Eh5/9112C
 3/z0c2l8vYtWyuu3MGuYll59KvvscQmyHCby1OkBNT+VafPZPT111qwfQ2ePgquDB+PJkKI
 vDDmeYyJut6nUO5tv9kaw==
UI-OutboundReport: notjunk:1;M01:P0:mbOjkoE2cZ4=;thXzvY45E4Kg1SEoyXwFKgsDIm2
 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
Subject: Re: [cocci] Analysis challenges with SmPL for pass-through
 functions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3094
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/6809504b-39d7-48e3-97d3-de5d0dc951c3%40web.de>

> @display2@
> constant char[] literal;
> identifier i;
> @@
> *i = strcpy(i, literal)

Such an SmPL script example can look promising.
How will software refinements evolve for this source code search pattern?

1. Which function (or macro) names would you like to add according to calls
   where an input parameter gets forwarded to the return value?

2. How many variable reassignments would be avoidable then?

3. Is there a need to exclude the possibility for volatile data accesses?
   https://cppreference.com/w/c/language/volatile.html


Regards,
Markus
