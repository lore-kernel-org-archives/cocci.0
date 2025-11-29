Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BC9D116EA
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 17:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5F/a7AmYm+qEAJFCpcDCIhvU7aE4fAJxY1NiEmsO6mE=;
  b=mYdx+geRIWk8SwjW7lxL0RSfw+c0CklS/xx263kAnskTcBGgrgnNDv6i
   TKDIIR26QqAU1Hd47bnfeB/HlxrC/NDSnAq6HZJGVlgZZiesWHLx+jvWC
   Eyj4DR5Oo/4iPPqCBPYusVJF4VaUOcHOndhFQ9M52YdL5UJjVS03DkZ02
   o=;
X-CSE-ConnectionGUID: VE63Jg/nTZekHn5emeDj7w==
X-CSE-MsgGUID: EMInsYoRQz2I1PuLIX1Vnw==
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
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="251900702"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 18:59:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1BDA6E0AF1; Sat, 29 Nov 2025 18:59:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 676B3E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 18:59:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5F/a7AmYm+qEAJFCpcDCIhvU7aE4fAJxY1NiEmsO6mE=;
  b=tCQ5JLUBCYi4Sh/RzZ/PEkH5l1SMlOP0wlsOoHiOqmG72vbKIAsaOVLG
   4A8D5nA038KMTsfJ7iNOmq1T8YQkOcPkNZnXPQg5KROUm9K7Vdwy+zE33
   b5pLywCHl+xjrJ2K0iaz9I5L2Cqt4JCHe/2GlNzt0oPvUD5S3q+Gu/M4I
   4=;
X-CSE-ConnectionGUID: rBfZfGV0R+aS3X0VMlW8ow==
X-CSE-MsgGUID: GWWeyw2ZQg+FUrCNCKSOOg==
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="251900697"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 18:59:09 +0100
Date: Sat, 29 Nov 2025 18:59:09 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Tobias Deiminger <tobias.deiminger@posteo.de>
cc: cocci@inria.fr
In-Reply-To: <29c204aa0f1f08074279425b7de42dd7@posteo.de>
Message-ID: <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de> <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr> <2897bda0c438111e967017f6bb3422f0@posteo.de> <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr> <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr> <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de> <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr> <fd7307f8024706d4bd128d0b7f43bb96@posteo.de> <29c204aa0f1f08074279425b7de42dd7@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3217
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/825ab32a-2544-d2a8-bc48-38f26c62bc%40inria.fr>

Sorry, I don't think it is going to work with the attribute in the short
term.

I succeeded with the following:

.cocci

@r@
symbol SYSCALL_DEFINE1;
identifier fn;
type t;
position p;
@@
fn(int SYSCALL_DEFINE1, ...) {@p ... }

// or put the corresponding python code
@script:ocaml@
p << r.p;
@@

Printf.printf "line: %d\n" (List.hd p).line

----------------------------------------------

standard.h

#define SYSCALL_DEFINE1(func, t1, a1) \
    int func(int SYSCALL_DEFINE1, t1 a1)

----------------------------------------------

.c

SYSCALL_DEFINE1(foo,int,x) { return 0; }

----------------------------------------------

Using * was a bad idea.  You can't transform macro expanded code.

julia
