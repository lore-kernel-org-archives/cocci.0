Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB250C021B8
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 21:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=CtJBisrukwY6R4PMROv2AzHA+n4QFJUbqSpxvcHi7L8=;
  b=Odkef5S0a50SIOgMiqIBiBFDL204ZakgroTa9ui2g7hGq/LT45FAaFs2
   qL5SjwEbNoO67dzPGrjhYwiajNMBp0t62vzcy+TPSfIHJunaNsb/RY8jd
   q8Hm5EVDRE1UoJesFREZACaBZsGqh0PJ2s80pLkUM0Cy+aaJGn9BXLhNT
   A=;
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
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210047059"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 22:16:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 25919E0261; Tue, 25 Feb 2025 22:16:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 607A2E0260
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 22:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CtJBisrukwY6R4PMROv2AzHA+n4QFJUbqSpxvcHi7L8=;
  b=btMopOICiD8oojRvBqLGXShHzjyAM/Rb7cdnP2OuyUiS6yUufxbT5UWj
   xWpgxn176X3NEpyDhNrytjkmaB1tsey5qbfi4rbU7Mb24D61Ei2MqtyT3
   p+bc/yWtaD0ECjo6hl8ozmuTYF+wsWo9MfgKeELIO2t3ucUwas8sej6fF
   E=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="110055527"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:16:32 +0100
Date: Tue, 25 Feb 2025 22:16:31 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
cc: cocci@inria.fr
In-Reply-To: <Z74wnyWEjnZgsJuu@blossom>
Message-ID: <alpine.DEB.2.22.394.2502252215370.3444@hadrien>
References: <Z7zjkyOeoPNYeOR3@blossom> <alpine.DEB.2.22.394.2502252132540.3444@hadrien> <Z74wnyWEjnZgsJuu@blossom>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Replacement of the form `x |= function()`
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2451
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/alpine.DEB.2.22.394.2502252215370.3444%40hadrien>



On Tue, 25 Feb 2025, Alyssa Rosenzweig wrote:

> > What version of Coccinelle do you have?  For me it works fine...
>
> 1.1.1, apparently. I didn't realize Fedora 40 was so out-of-date, sorry!
>
> [BTW, I'm a huge fan of Coccinelle. Thank you for writing this
> phenomenal piece of software!]

Thanks!

You can ty the version on github.

julia
