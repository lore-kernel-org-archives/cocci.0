Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCF0C4345F
	for <cocci@archiver.kernel.org>; Thu, 11 Apr 2024 21:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=koudlguX7+fu+S3E+8nmMVSo8RohFqRNtrwfAeufHHk=;
  b=KxpJDW1KFpM1NNVDa9G9GXIoLVFVVBAGQGvz9E4F9Ux9RH89hI/dmDDp
   5gSRfZR+5MVQVHnBX+UeMuasgJ9xCviiV0w2cKZyYBY4FR3wXn0gjocU0
   /t2Y3vstChxBu3Xq0JJcOF6VQYy7aPtW/hcF176qthFafCxRCoVc72md7
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.07,194,1708383600"; 
   d="scan'208";a="161154901"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2024 23:25:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E7C04E02E4; Thu, 11 Apr 2024 23:25:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6C3CAE0131
	for <cocci@sympa.inria.fr>; Thu, 11 Apr 2024 23:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=koudlguX7+fu+S3E+8nmMVSo8RohFqRNtrwfAeufHHk=;
  b=OK9JSmIqiQ6kBuQNxB0rj5N0HtvN+p3qOP+ZFQAfYQgYhEpJQLqsUKO5
   VF95pH97tUj0nPG1L492m+ybzgTX12l8UNWRzaoCrxrTUFe98XV8YDiNR
   A7nYoKFw+8SVBSb79b7GLOkBA23hT7hB+0phY2z5tjPRQOzZS2r7648m7
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,194,1708383600"; 
   d="scan'208";a="84523127"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:25:45 +0200
Date: Thu, 11 Apr 2024 23:25:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Akos Pasztory <akos.pasztory@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAJwHcF6YRniP0C8SMg-iM+SJ1wu61KeLS+gLZ-mkek90OMH6cg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2404112325330.3048@hadrien>
References: <CAJwHcF57ee4M6P-nzg9=1drDQbpic-4qqbpSCbL1FO7XXsetVw@mail.gmail.com> <80e895d-301f-90c6-fe89-e72f7c3ff039@inria.fr> <CAJwHcF6YRniP0C8SMg-iM+SJ1wu61KeLS+gLZ-mkek90OMH6cg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2141984944-1712870744=:3048"
Subject: Re: [cocci] type of integer decimal constants
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1642
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/alpine.DEB.2.22.394.2404112325330.3048%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2141984944-1712870744=:3048
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 11 Apr 2024, Akos Pasztory wrote:

> Yes, sorry, didn't read it beforehand.

Applied.  Thanks!

julia


>
> On Thu, Apr 11, 2024 at 8:52 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>       On Thu, 11 Apr 2024, Akos Pasztory wrote:
>
>       > Hi,
>       >
>       > I noticed an issue with how coccinelle determines types of (at least) decimal literals.
>       > This only happens if --int-bits and/or --long-bits is specified, since otherwise everything is treated as "int".
>       > The output below was truly puzzling initially:
>
>       Thanks!
>
>       The patch looks good to me.  Could you resend it with a Signed-off-by (see
>       the end of readme.txt).
>
>       julia
>
>
>       >
>       > $ { echo 'void f() {'; printf '%d;\n' $(seq 0 32); echo '}'; } > decimals.c
>       > $ ./spatch.opt --long-bits 32 --int-bits 32 --type-c decimals.c
>       > void f() {
>       > 0/*int*/;
>       > 1/*int*/;
>       > 2/*int*/;
>       > 3/*unsigned long*/;
>       > 4/*unsigned long*/;
>       > 5/*long long*/;
>       > 6/*long long*/;
>       > 7/*long long*/;
>       > 8/*long long*/;
>       > 9/*long long*/;
>       > 10/*int*/;
>       > 11/*int*/;
>       > 12/*int*/;
>       > 13/*int*/;
>       > 14/*int*/;
>       > 15/*int*/;
>       > 16/*int*/;
>       > 17/*int*/;
>       > 18/*int*/;
>       > 19/*int*/;
>       > 20/*int*/;
>       > 21/*int*/;
>       > 22/*unsigned long*/;
>       > 23/*unsigned long*/;
>       > 24/*unsigned long*/;
>       > 25/*unsigned long*/;
>       > 26/*unsigned long*/;
>       > 27/*unsigned long*/;
>       > 28/*unsigned long*/;
>       > 29/*unsigned long*/;
>       > 30/*unsigned long*/;
>       > 31/*unsigned long*/;
>       > 32/*unsigned long*/;
>       > }
>       >
>       > After some investigation, I think the problem was introduced in 3c5dc62bae3e38d77044423ecb3575f30ab230fa
>       > when a bigint dependency was removed. The commit replaces integer thresholds with strings, 
>       > however in is_long_dec it does the following kind of changes:
>       >
>       > -      if Big_int.ge_big_int bn ulong_threshold
>       > +      if s >= ulong_threshold
>       >
>       > This seems to do a lexicographic comparison on strings instead of numeric.
>       > One solution that came to my mind is to zero-pad the strings to same length,
>       > then lexicographic comparison should be also correct.
>       >
>       > Attached a patch, but note that I'm not an OCaml programmer, so it may be not idiomatic.
>       > Feel free to solve it another way;)
>       >
>       >
>       >
>
>
>
--8323329-2141984944-1712870744=:3048--
