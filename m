Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8C5D116EA
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 20:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:in-reply-to:references:
   message-id:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=V5zHcuoLzZuOgSKe7X6pSjP5DvrFJXNka20+Kzz4q8o=;
  b=KRiMc31gKWsTixkyXBCTcAlsKiXh4GHVAstsLrtBRmsX0WJdQmn24yWo
   1yGxQEdqjY9RO15mfRde8VEYtltz/HDMwfLnrqOWnLPbSkntnKFQNS191
   pyXsQB9Eby/MGWDVI+wEc3roZ90M1JntjxHy7xwtZrKlX82vtTVvwIP+U
   E=;
X-CSE-ConnectionGUID: 6HradOd/TGSWskp4pCfBrA==
X-CSE-MsgGUID: XcCoS1wjSIqygCi2ig+Emg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@posteo.de
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="251906106"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 21:06:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1E6C1E02E4; Sat, 29 Nov 2025 21:06:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D673EE0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 21:06:45 +0100 (CET)
X-CSE-ConnectionGUID: +/GyfVdFRS6D9767Y2NxAA==
X-CSE-MsgGUID: EO3EuaDTROCqUJG2NLT1sA==
IronPort-SDR: 692b5254_F6JHYVv3+/nPLvVEszEbA95ieSIrYduirta7gfEERatC8gQ
 aFLZGV0I8bY7xnM5OM58cIGDLickpfB2EoByr3Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F3AwAwUStpe0EkQ7lagQmDaCiBAl4zBwhJjVCJDZ9kJ?=
 =?us-ascii?q?A8BAwENPRICBAEBAwEDgUyDNAKMZQIfBgEENBMBAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBDQEBBQEBAQIBAQIEBgECEAEBQg47hk8NgluBGxF0AQEBAQEBAQEBAgEBA?=
 =?us-ascii?q?SICAQEBAQEBAQEBAQEBHQIsXwIBAQI4AgYBATgPC0ZWIYIiWYIiAk8HAQwGs?=
 =?us-ascii?q?XqBNIEBggwBAQbcJYFkAwaBSoVugmUBhV6FCCcPgVVEhAcHMT6CYQECW4EZO?=
 =?us-ascii?q?IV3giaBDoYkkzIsJngcA1ksAQ9GExcLBwWBIEMDgQsjDzwFLR2BIyEdGBFgP?=
 =?us-ascii?q?RdAg0kdBmcPBoERGUkCAgIFAkA6gWYiBhwSAgMBAgI6VQyBdwICBIIWfYIKD?=
 =?us-ascii?q?4gLgQkFLoENAwsHZj03FBsGAgGBNZQSFDyDNCUQgh9YknSQFIE2oUU0B4I4g?=
 =?us-ascii?q?WeBXgYMii6VQRIcF5dgkwuZBo4IlSRAhVWBfyMugS5NJE+CZ08DGQ+OLRYcg?=
 =?us-ascii?q?3VRxCNDNTwCBwsBAQMJhWkTjCKBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:g8pRQqMlrQ0Wx8BcTsijsMiBIKoaSvp037BN7TEXdfU1SL39qy
 nKpp4mPHDP5wr5NEtPpTnEAtjifZq+z/JICOsqTNKftWDd0QPCQb2Kr7GSoQEIcBefygcy78
 ZdT5Q=
X-Talos-CUID: 9a23:PXU+rGOsTyrKpe5DG25I5UAqFu4fSSPxnSiOfH7iL3ZAYejA
X-Talos-MUID: 9a23:ZvOtagn3F3JDmF2NoshNdnpPE5xF/q2CNHoquow7mebeEwhMYiy02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="132293554"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDEb5Wo+uIkan5nrXXVVtH6zVM9Qim7r1Ls/mh?=
 =?us-ascii?q?CxBKECeGNBq4BGoMZsyLxtOG+82lEK70y4gk9mMK60Wk/1Yaq4IM+iNe?=
 =?us-ascii?q?W4vdDLR3l+kmiZvRVLTzx0GeChpiYqWSLKE9nLRvq8QKWxToQg3ngGNZ?=
 =?us-ascii?q?XFScwxC9gtFShQPQocpvSGpQ=3D=3D?=
Received: from mout01.posteo.de ([185.67.36.65])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 21:06:44 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id D685B240027
	for <cocci@inria.fr>; Sat, 29 Nov 2025 21:06:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764446803; bh=V5zHcuoLzZuOgSKe7X6pSjP5DvrFJXNka20+Kzz4q8o=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=UWh4sGrdyrhQ3KkTU2CPqDHH7Px9D342IRnVW4fJYv25zLzJuZiHn5jKNmW1eqbpe
	 TDACQK/bQM8rd/f+o0paSPK8BXdqA/ue54wpucG1zGPiDaesfLhpZrfhJ7EwFgh/Zl
	 Bcpm7zmtK6aKI1yRsQhz5RAAcj0iAkacAK32fqd2eBbsWZ9ofLk1kttUQ4SRmgEZTJ
	 JNWIIxTpda+LhgPddmKVMe7ozCLwdm8TmiPiAND+lB5lpXf4YvDwrRU8nTY2bgzA2w
	 3y/QH9P8Pc8RzLR7XapCzAMmvEtwEhPWA2NHg/v11NAIwHXXsO060oB83W/5MifhOn
	 LhkzWp3b8vDQQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dJh5H3dG2z9rwn
	for <cocci@inria.fr>; Sat, 29 Nov 2025 21:06:43 +0100 (CET)
MIME-Version: 1.0
Date: Sat, 29 Nov 2025 20:06:43 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
In-Reply-To: <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr>
 <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de>
 <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr>
 <fd7307f8024706d4bd128d0b7f43bb96@posteo.de>
 <29c204aa0f1f08074279425b7de42dd7@posteo.de>
 <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
Message-ID: <ded004b275d73e35c46c3d30c057d58e@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3221
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/ded004b275d73e35c46c3d30c057d58e%40posteo.de>

Hi,

Am 29.11.2025 18:59 schrieb Julia Lawall:
> Sorry, I don't think it is going to work with the attribute in the 
> short
> term.
> 
> I succeeded with the following:
> 
> .cocci
> 
> @r@
> symbol SYSCALL_DEFINE1;
> identifier fn;
> type t;
> position p;
> @@
> fn(int SYSCALL_DEFINE1, ...) {@p ... }
> 
> // or put the corresponding python code
> @script:ocaml@
> p << r.p;
> @@
> 
> Printf.printf "line: %d\n" (List.hd p).line
> 
> ----------------------------------------------
> 
> standard.h
> 
> #define SYSCALL_DEFINE1(func, t1, a1) \
>     int func(int SYSCALL_DEFINE1, t1 a1)
> 
> ----------------------------------------------
> 
> .c
> 
> SYSCALL_DEFINE1(foo,int,x) { return 0; }
> 
> ----------------------------------------------

yep, that worked. Thanks a lot. What also works is to fake the return 
type to syscall_define_t in standard.h, and then do 'type t =~ 
"syscall_define_t";' in the rule.

This is good enough for my experiments *). Sure it would be nice if 
coccinelle could match on "known macros" somehow, maybe during the 
preprocessing run. But as said, I'm not in a position to make such 
suggestions and believe I understand how it's not well suited if the 
engine is designed to match on the AST.

Tobias

*) There's an ongoing effort to add testable code expectations / 
requirements to important functions in the Linux kernel [1]. I'm 
involved, and one thing that IMO would help is if we could quantify what 
"important" exactly means, i.e. how many functions are to be documented 
(100? 10000? 1000000?), and where exactly are they. So I'm looking for 
something that can find all syscalls, all exported symbols, all sysfs 
functions, subset of internal APIs, and so on. Raw grep is obviously not 
well suited. Coccinelle is already used for similar tasks, so it's an 
obvious candidate. tree-sitter queries could also work.

[1] https://lpc.events/event/19/contributions/2085/contribution.pdf
