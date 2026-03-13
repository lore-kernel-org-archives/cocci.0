Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5954B105F7AE
	for <cocci@archiver.kernel.org>; Fri, 13 Mar 2026 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=fwiq13gqjQdzo48CKf3t93iJb5Nel368zc3diyxPnh4=;
  b=ON2r5//MFeniyGhAkXoEaoRRMQkKTH2R0ELnu+P4HG2OV+4WeGwMsyjR
   UgPosOKuX1q+QQIVSLm2+5iIEypYL5FSk0Ll/42pvW0PU/COttWC2e8NE
   yPwGDtZ4LbI1Jd5KsF5Nbb5JP5juN07kS7BYNVz4rLODvzlHfpU6rz8+0
   c=;
X-CSE-ConnectionGUID: cX+alKWSTCKOVGdGho8kyA==
X-CSE-MsgGUID: eQLZ2eqqTryRQv29qU6Xzg==
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
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267692927"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2026 15:12:45 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B048781DE2; Fri, 13 Mar 2026 15:12:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 989D381DD4
	for <cocci@sympa.inria.fr>; Fri, 13 Mar 2026 15:12:43 +0100 (CET)
X-CSE-ConnectionGUID: 1Pfm//3bTrm1fGfwM+HBMg==
X-CSE-MsgGUID: lpI5BnurRZGtbeifyfrz7g==
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267692902"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:12:35 +0100
Date: Fri, 13 Mar 2026 15:12:34 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Alice Lee <Alice.Lee@ist.ac.at>
cc: "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <274abdf3dbbe4c3e8f1f33fba516c8b3@ist.ac.at>
Message-ID: <5cd9a9c8-9f99-417f-dcfe-5c1b136ec5bf@inria.fr>
References: <274abdf3dbbe4c3e8f1f33fba516c8b3@ist.ac.at>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-797032318-1773411155=:3973"
Subject: Re: [cocci] Can Coccinelle parse files where macros are used as
 binary operations?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3427
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/9tls0KQ7YvR3qeB5fhx8LQ>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-797032318-1773411155=:3973
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Thu, 12 Mar 2026, Alice Lee wrote:

>
> Hello,
>
> I am trying to use Coccinelle to search C codebases (I split up my questions
> to make the threads more clear) and I am struggling to understand the scope
> of the --macro-file argument.
>
> Can macros used with #if in the source code be defined in a file passed with
> --macro-file, and then the right sections of source code are ignored? I was
> unable to get a small example to work, so I assume that I can define the
> macro but then there is no preprocessing to drop code. If I'm not
> overlooking something, how would you recommend I parse a file
> including these lines and then uses LS/RS as binary operators: 
> #if __BYTE_ORDER == __LITTLE_ENDIAN
> #define LS >>
> #define RS <<
> #else
> #define LS <<
> #define RS >>
> #endif
>
> I'm especially confused by this example because Coccinelle also cannot parse
> a version in which I remove the code above and put one of the pairs of
> defines in the macro definition file.

I think you want the following command line options:

  --defined                     <symbol> treat cpp symbol as defined in #ifdef
  --undefined                   <symbol> treat cpp symbol as undefined in #ifdef

--macro-file is for providing dummy definitions for macros used in the
code that you are trying to parse.

julia

>
> Thank you,
> Alice Lee
>
>
--8323329-797032318-1773411155=:3973--
