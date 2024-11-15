Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3FFD68BCE
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=meCQUFE7XvMzjvkPRJucaqypcQenD20TlK06xpDU9sI=;
  b=loXLP6Ny/lOFyYquZrugCUvGx+PbRJ7jj2lLqCaNJkqr+rfelrIhiOwq
   OfvyjQkHoQzOPaOqh6KE/8pn20P/Rm7zvnr3Z1xTrZNr+k33RAt2X3iVZ
   cH4NISRxG942EtPWb+VT5tN8XofFfq+ZT8AmhMFrxVvV6lyC/EMuMYR3P
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194141608"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 17:50:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8019AE0D1F; Fri, 15 Nov 2024 17:50:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 240CEE0133
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 17:50:42 +0100 (CET)
IronPort-SDR: 67377be1_mXfYId88DkLU9WRbAIH8x+MxLucbPkayImy80LU/l2gYPl7
 iENJkXb7BbSpodrNJbP3k//3GiY/KS4qIGT8Heg==
X-IPAS-Result: =?us-ascii?q?A0GRAQCpejdnjhOg6VVagQmBU4JEfQZUMwcISIRWg0+OI?=
 =?us-ascii?q?p4WgX4PAQMBDTsJBAEBAwEDggyCdAKKSQIfBgEEMgcOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAhABAQEBAQEeGwUOO4V7DYJbO4IWLA1+AQEBA?=
 =?us-ascii?q?gEjFUYLCxoCJgICVhsBAYJ9AYJBIwMEDbJEgTKBAYMc2xeBZwaBGi6FaoJiA?=
 =?us-ascii?q?YVoAYR3FxAVBoINgTwOgnU+gmEBgi6DDoJpBIJBhRMliQCZR1J7HANZIREBV?=
 =?us-ascii?q?RMXCwcFgSkhLAOCSX+BNoFRAYMQSoMxgV4FNwo/gkppSzoCDQI2giR9gk+BJ?=
 =?us-ascii?q?QQFg2qBC4NhhGGDQB1AAgELbT01CQsbQ58DaUeEXRCnEaFrhCSMFpUyBg8EL?=
 =?us-ascii?q?4NxAZNOFJJ6mHeNf5VWhVKBbgEygVxNNASDIk8DGQ+OOoNhxSBDNTsCBwsBA?=
 =?us-ascii?q?QMJjxCBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:A9wW9Kge74uA93d+ZiHjbL4Gs3BQXtkji2hC6mlwRA09TyXqrb
 HMoB19726TtN9xYgBGpTnuAsS9qB/nhPxICMwqTNOftWrd1FdATrsJ0WIz+UyEJ8SWzIc0vp
 uIMZIfNDSaNzZHZKjBgTVQX+xO/OW6
X-Talos-CUID: 9a23:7a7dGW66nZvSKmyHb9ss72ArJcchTFPm9mbgAFSkCmdNWr2+cArF
X-Talos-MUID: 9a23:DvYBngvQJsZoy9FR582nuhtcZNYz2JyUOEEHiqw6g5ncHx5AEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101758628"
X-MGA-submission: =?us-ascii?q?MDElAXIUY/UbMhZ/yl7VZBAWzxFl+m7ZIPYnQz?=
 =?us-ascii?q?MZQyGsRCNmPA7merBDBy80ashfeQS3LT/ROCBOeNNJ8+nTPBX48ZMJfQ?=
 =?us-ascii?q?W+P+s4Xqr34aXAlX4xrgW701CKL0op28Q0/cglMvOLh2e5SY/V0FSDK3?=
 =?us-ascii?q?kGv64TNDx7660r2KvIec3O0g=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 17:50:40 +0100
Received: from [137.220.76.70] (helo=[192.168.1.187])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1tBzWp-000000004aL-3gY6
	for cocci@inria.fr;
	Fri, 15 Nov 2024 16:50:39 +0000
Message-ID: <87bba066-b262-4d07-aca7-4632f4e03816@knosof.co.uk>
Date: Fri, 15 Nov 2024 16:50:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <c1da3618-fdac-772b-133-a3e2df77d83@inria.fr>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <c1da3618-fdac-772b-133-a3e2df77d83@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] new release, 1.3
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 2002
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/87bba066-b262-4d07-aca7-4632f4e03816%40knosof.co.uk>

Julia,

> There is a new release of Coccinelle, version 1.3.  The most important

Yay!

> - Fix some C tests

If you are looking to produce lots of detailed C tests,
ChatGPT is surprisingly good
https://shape-of-code.com/2024/10/27/c-compiler-conformance-testing-with-chatgpt-assistance/

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

