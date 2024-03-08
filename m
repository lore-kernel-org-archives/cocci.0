Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074F3C5475B
	for <cocci@archiver.kernel.org>; Fri,  8 Mar 2024 06:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9gCkuKBKfAqkw6yB3raTZf91Ja1o86hJHHn32RhGVGo=;
  b=EjEbjWzkeasm9ZnFdpaF0TN3PvLjBgazBPhtYqFhc/JNGcCczlQJsF/x
   lg3QPxfIiylPDRdDVLBPtIYwUwm2f5wiAaPPgpXfL6OF+bHD3xhMQ5Voi
   KV2vqdjnv3Bz2qUKw2f42RMiadvQ+4Ow3cmCgnMAsDNmaU0yEWZdUttCN
   0=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,108,1708383600"; 
   d="scan'208";a="155602243"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2024 07:39:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DE285E00B7; Fri,  8 Mar 2024 07:39:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 09B0AE0035
	for <cocci@sympa.inria.fr>; Fri,  8 Mar 2024 07:39:17 +0100 (CET)
IronPort-SDR: 65eab294_+Y98THF/gz1vQA6f2+ljYjPvrKyQMwQPgz/1gNge6RQkbQb
 1lSpPgoOAypf9odXUKI6A32vyoTwLI8dH9HtMIA==
X-IPAS-Result: =?us-ascii?q?A0GfBAAsseplhwwR49RQCh4BAQsSDECECH9TMgQLSIRVj?=
 =?us-ascii?q?0WBdTCEO4c4kD6DFj4PAQMBDUEBAgQBAQMEgguCdAKHdgIeBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4VsDYJcARCBD?=
 =?us-ascii?q?oEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQQECAgEjHQEBESYBBAsLGgImAgJWB?=
 =?us-ascii?q?gEUAQGCfIIrAQMOIwezbYEygQGCCgEBBoJnrHUfLCJXgWEJgRouiCYBhXWDQ?=
 =?us-ascii?q?nonD4FVRIE8C4J4PoQWLYNbgmiFUoIrA5sSVH8cA4EFBFoNGxAeNxEQEw0DC?=
 =?us-ascii?q?G4dAhEiOgMFAwQyChIMCx8FVANDBkkLAwIaBQMDBIEuBQ0aAhAaBgwmAwMSS?=
 =?us-ascii?q?QIQFAM4AwMGAwoxMFVBDFADZx8yCTwPDBoCGxQNJCMCLD4DCQoQAhYDHRYEM?=
 =?us-ascii?q?BEJCyYDKgY5AhIMBgYGXSAHDwkEJQMIBAMrKQMgdREDBBoHCwd4ggmBPQQTR?=
 =?us-ascii?q?AMQgTQGhTKEbQyDDAIFIyqBexhPAxkrHUACAQttPTUGAwsbBiIBHQKoKVMMk?=
 =?us-ascii?q?0yxZDQHgjWBYIFhDJ8+BhMvlzMOBpJimFwgoyGFO4F7I4FcMxokgzZPAxkPj?=
 =?us-ascii?q?iAZhBSPR0I1OwIHAQoBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 J7DmfCqQAo=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qe5H6q7IS+xKm+5B3APXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HIoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNwAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLfDtHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:A1y3xmCPzZzTOT/6EwhayWc7G+Q3Tk3E61npOWC/G2o5YbLAHA==
X-Talos-MUID: 9a23:T877tAttfWxpLFjd3M2n2zhdJMs0yPqSMWcnoK4Ulu+HNSt5AmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,108,1708383600"; 
   d="scan'208";a="81596261"
X-MGA-submission: =?us-ascii?q?MDE3oVGqBkTeHjU00Xb1nf9sBaXHJI8B7Sc2+v?=
 =?us-ascii?q?RMKJ8/M6UkHZ/v34LbCNkCQwt0mYKulYL0SVTsxte2kpRDJ7y72JmI7d?=
 =?us-ascii?q?Rye+lMZxoZSLv97byjdwN/XEeV6X5Rwa674h8SV5MVO1AVmDyxUDxkoT?=
 =?us-ascii?q?HfVHk8JjykgncyF6K1aPGmBA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:39:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709879949; x=1710484749; i=markus.elfring@web.de;
	bh=ZnEIIn8cQ0wfZE9v4L8hG51HQtqAhWYwi0Q3L85DRMY=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
	 In-Reply-To;
	b=B1fuZPDsdF5VqUX9H66ht76Sz4NVxjbKakzGH+U8rJt56oE66WtoL0oJibRzBxV8
	 jvc8dxlnK5zefcTAOOKC04kO4b371Aq4U4+o4rO5fUR8Za1w4gEfUJIuFnBSvK2Mb
	 +YOPUHZSuEM6x7xUaQlc7cKA1RbMX8uVsHFrQaRVQdG/DC35UCe+1J30rsMDgho6X
	 6/evgfvMetzqtP47s/PD+F3B1U1eAx71MmlILsqUTaBdrnwLh25oVHQdclNpdrOJK
	 FQc7Pqu7u3NJ4GASaHjhPuHv2C1p7DA+anK10px3+T/JG7zpK9J5bz468ix5lLZLN
	 4N7PoY3YMtoJikap6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mkmzl-1qywra2ULn-00mG1n; Fri, 08
 Mar 2024 07:39:09 +0100
Message-ID: <e02915e5-e5a1-4365-8d09-3bae25b2d8ad@web.de>
Date: Fri, 8 Mar 2024 07:38:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Alan Brady <alan.brady@intel.com>,
 "Jacob E. Keller" <jacob.e.keller@intel.com>,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>
References: <CO1PR11MB49149F1167679926A2917E0997202@CO1PR11MB4914.namprd11.prod.outlook.com>
Content-Language: en-GB
In-Reply-To: <CO1PR11MB49149F1167679926A2917E0997202@CO1PR11MB4914.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LbBbqlcalE+25TSItXEPS6N6VJNF4aRVgYjS6a7lDJUjiRc3b9d
 XCTKxWHwoRvXKs9sMxEZqWVuz+q6gZT0crfgkLzCmZWMJi86yLQOs1Ez+ktfRjPsNV83h8B
 HH5oTnRHohefOSYwagWHOXIq2iGeIDfa/TYFgDRetXU6LjdhwRW9smLUl2xLPmM6l1MEIMl
 rpYhDh9eh3WFPc+wqVnkQ==
UI-OutboundReport: notjunk:1;M01:P0:e1zK2ike2ms=;3B2zKGEFgNnr8DltSwnFkFGQnRC
 qCDrS0MrEDblC+9cFuPNt0s6XT17eDtP0tu4TC6YL4KPpsG6zedsfkNw2wU0goYTEKkbSdEgD
 ATBr+kSLVzEW8lSC0bQzJHHJeMLS5aKOO+wU10EgZalcYHZJZn8lKbDAi54JZVBwndsKQBZSB
 sekK0kpM5P8d1tru2YgnoRIy3oLitVqGlj7Sze1DxQMYgWLMdr7a7pVkVGgGJUg2g1njPKMyl
 nuXZKXMrO7FVKIe9fzDv36bz0ctVWK98JHNK8JMA6wa4fS9FJidSjG5wey6saGXlOO2ILRuyC
 qRmefG0Vv0AJKYfWEhjtUbCbnp7LRQOO5LsA7GI+j70b8eYIy054nRmhb8EB8Eholk9AhTc5A
 AXYJZ3/X3sjnSDRavRyvfyfnwxpmtumabv9EqXrZSU7f5MbB45Ix9KrVShST82bEePHNgSF/X
 oNXJli6RhPKcv3iIx1yVkFQRFY+VVOulQMlD0cn7XGZ9TLAIbEv4orlC+LEOMSehzNcjkXo4c
 ZKxbS1Xu4hoYVm+2ohgPrgvkxfp5dwb4DQtqcShJzwRSFxKiSMF8BxOLS0d4uAck0wYAeXRjR
 W8FseTIVLiH5+qNN7WhEQNjFaX/rnSyoTfZYqlBysC2hBHXPmF681KM9f39/TVbz751H/e9ym
 v+dQOI1AJFPmVbEZ+UqAbQbUaC+Yo9xEnJNcOvd3drIYFl9RLCFb7zy4voo3OaVsfVMWKglyt
 7HKTatJ9WoiuhO7Y3Z100xXn4qfdEZa8lrrx4C9pv8ezETjUx7mQ7lN71NsWvXwrIrkXOrmkW
 3UOfUUS25yIrjxHlXDUoodmS59YhGKNfZMXZYJm0XV3gM=
Subject: Re: [cocci] question about kernel cocci and cleanup.h
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1611
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/e02915e5-e5a1-4365-8d09-3bae25b2d8ad%40web.de>

> Hi Julia and team, I had a question about whether it=E2=80=99s possible =
to use coccinelle/spatch to start to identify functions which are able to =
use inline destructors (__free or DEFINE_FREE()) from include/linux/cleanu=
p.h

Generally, yes.

A specific cleanup function is mapped to a selected pointer type.
Will any more collateral evolution happen according to the usage of =E2=80=
=9Csmart pointers=E2=80=9D?



> To some extent a missing kfree logic is already part of the scripts/cocc=
i, but what I was curious about is whether spatch can find

Further applications of the semantic patch language (Coccinelle software) =
have got
a lot of potential.
I find the corresponding data processing and development resources improva=
ble
in various ways.


>  1. Function that allocates a stack variable which is a pointer (or has =
one passed as a pointer argument)
>  2. Function calls *alloc
>  3. Function calls kfree() before return in all paths after alloc

I got the impression that advanced source code analyses can be very challe=
nging
for such cases.

How will knowledge representations evolve accordingly?


> I know this would be nearly impossible to auto-patch, but having a =E2=
=80=9Cgrep=E2=80=9D for this pattern would be super helpful.

Can the support grow for such an idea considerably?


> Would someone be interested in looking at this for the kernel?

Yes, of course.


> It seems like a valuable help to find refactoring locations.

Would you like to help any more to benefit from known adjustment possibili=
ties?

Regards,
Markus

