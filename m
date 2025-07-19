Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789A4C83F27
	for <cocci@archiver.kernel.org>; Sat, 19 Jul 2025 19:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ExrppfdTpo5fpgFTXFDRi20PtGAW1J70zSCUTCV4Emc=;
  b=vnM0S6vQrEmEygHUMUx/sh9k2881TAcAIL8QnIxN/TaylrcyT+ixL8PN
   CNzr8XCi9Rmx5gk4PqTTvewXujJPU7qpur0N5zwPmMd8m1UgO+xs+s1nK
   96pgnVK5wa1qKAnAxjGnaY+6Y7pjSoQcv22d8DaEumHjxW1HRJbhE88vW
   s=;
X-CSE-ConnectionGUID: PQl2tJkKQKyVhotOes7r3Q==
X-CSE-MsgGUID: FLJSKAtxR2ad9AedRhXFAA==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.16,324,1744063200"; 
   d="scan'208";a="232322222"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jul 2025 21:16:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B613AE0264; Sat, 19 Jul 2025 21:16:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 45A1AE0171
	for <cocci@sympa.inria.fr>; Sat, 19 Jul 2025 21:16:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ExrppfdTpo5fpgFTXFDRi20PtGAW1J70zSCUTCV4Emc=;
  b=bLV2NPaujqTuLbVcdMIgaB0HqZYwdoTVVobrQhRlW24vYpAD70m4ei7Z
   SzRBDVuTWkCspFs4/EX22gyiJ8XEeYXOxtYQ7NDpw+6hOgIjkOFJrKEQh
   wGNN+CPY4FEva/FYUWuEovC/L6V0b2qL6P9ypDzzGaKbF1C+tQxY4ojAU
   c=;
X-CSE-ConnectionGUID: 1RVcyuH4TwmLxqksFiBxvA==
X-CSE-MsgGUID: 32VUxIYiQhOTfBNxhjoPQw==
X-IronPort-AV: E=Sophos;i="6.16,324,1744063200"; 
   d="scan'208";a="232322217"
Received: from 205.153.92.156.ipyx-135073-zyo.above.net (HELO hadrien) ([205.153.92.156])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 21:16:03 +0200
Date: Sat, 19 Jul 2025 15:16:01 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
Message-ID: <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1442277903-1752952563=:3292"
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2877
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/21f78cc-6034-2b33-c2fb-cdf6d3694d2%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1442277903-1752952563=:3292
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 19 Jul 2025, Markus Elfring wrote:

> Hello,
>
> Some information is provided also according to the question “How to remove
> useless parentheses?” in the documentation of the semantic patch language.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/2548098a0c8b148555f4bf11a12898ecaf023dea/docs/manual/tips.tex#L6-41
>
> Another corresponding file contains a todo tag.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/2548098a0c8b148555f4bf11a12898ecaf023dea/standard.iso#L382-397
>
> It seems that some conditions should be reconsidered.
>
> I would occasionally like to capture detailed expression code by metavariables.

What conditions?  What detailed expression code?  It is not possible to
understand this without more information.

julia

> I am unsure about the properties of the found expressions which should be reused somehow.
> Thus I would tend to enclose such data by extra parentheses.
> A manual inspection would indicate then for an adjusted code place that this
> addition would occasionally be redundant.
> Can this aspect be better supported automatically?
>
> Regards,
> Markus
>
--8323329-1442277903-1752952563=:3292--
