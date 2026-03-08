Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C05CEA8545
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 21:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ew34NvJzyEJbcfT7ApJVqA3gH7U63VFaH1rVMB0WujQ=;
  b=mNGAD39YDOEw0nOXgCrExjxr9MgMMg+slfeDit+QhCeNMn7Ax0fBhfPC
   /wo+WW3tJPupC6zLioNWtjnY83YUj2RgqcfI68MdEBGDAN852gxN53EIj
   6s14jCXMSNa1twH0lA2+10PVeyD0wdyt8IHS+7qneGpQdSa5vayxCI3s/
   k=;
X-CSE-ConnectionGUID: 9Uobxp3yTZGRZG6NT5hApw==
X-CSE-MsgGUID: UgpxedBPTw6M0ANuDaii3g==
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266762326"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 22:43:09 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0FB148167B; Sun,  8 Mar 2026 22:43:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 88DA081626
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 22:43:06 +0100 (CET)
X-CSE-ConnectionGUID: yWkqylsTSaKZU0Ef2ReYIA==
X-CSE-MsgGUID: Y+Nja2SVSCGF8JrkgaPi2g==
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="140731558"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 22:43:06 +0100
Date: Sun, 8 Mar 2026 22:43:06 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sam Tygier <samtygier@mailo.com>
cc: cocci@inria.fr
In-Reply-To: <fc5aa4f0-0134-475a-9220-dedc71955fe7@mailo.com>
Message-ID: <6b795826-177a-4bef-81cd-1b783815114@inria.fr>
References: <fc5aa4f0-0134-475a-9220-dedc71955fe7@mailo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1912089884-1773006186=:3947"
Subject: Re: [cocci] c++ scope resolution operator
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3344
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/QyagZQXMsPq8deq0REapIg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1912089884-1773006186=:3947
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 8 Mar 2026, Sam Tygier wrote:

> Hi,
>
> I am having trouble using Coccinelle with C++ around scope operators, e.g.
> std::cout.

Sorry, but the support for :: is still work in progress.

julia

>
> For example this works as expected (replaces the string):
>
> hello.cpp:
>
> #include <iostream>
> using namespace std;
> int main(){
>     cout << "hello";
>     return 0;
> }
>
> hello.cocci:
>
> @@
> @@
> - cout << "hello";
> + cout << "hello sam";
>
> But the actual I want to work on uses explicit namespace scopes
>
> hello.cpp
>
> #include <iostream>
> int main(){
>     std::cout << "hello";
>     return 1;
> }
>
> hello.cocci
>
> @@
> @@
> - std::cout << "hello";
> + std::cout << "hello sam";
>
> gives an error:
>
> $ spatch --sp-file hello.cocci hello.cpp --c++=17 --debug
> init_defs_builtins: /usr/lib64/coccinelle/standard.h
> -----------------------------------------------------------------------
> processing semantic patch file: hello3.cocci
> with isos from: /usr/lib64/coccinelle/standard.iso
> -----------------------------------------------------------------------
> @@
> @@
> - std::cout << "hello";
> + std::cout << "hello sam";
>
> minus: parse error:
>   File "hello.cocci", line 3, column 6, charpos = 12
>   around = ':',
>   whole content = - std::cout << "hello";
>
> I am using coccinelle from the Fedora package 1.3-3.fc42
>
> $ spatch --version
> spatch version 1.3 compiled with OCaml version 5.3.0
>
>
> Thanks,
> Sam
>
>
>
>
--8323329-1912089884-1773006186=:3947--
