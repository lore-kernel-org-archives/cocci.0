Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA291C0219B
	for <cocci@archiver.kernel.org>; Tue, 11 Feb 2025 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SfaN8CWjNy1j6tNYO1yBRuspnhy15ItfJDaklRf8ChU=;
  b=eWbZqgbohVf/K7/7zofJWcZ31FoPTCmx1xQvDKS+PftEL6/Ht1r4OONo
   tf3GOyf+qRKJl5337SwFGaJoHMzv9QF7M5aM2LGhSp2HPWnFtb1gKReG3
   APF2ORSLjJ5laHw6bkvQUeBWDb07kEXRqJEp5SHhDkq+75/jDAXtkC5bU
   M=;
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
X-IronPort-AV: E=Sophos;i="6.13,278,1732575600"; 
   d="scan'208";a="207776134"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2025 18:53:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3B47FE0261; Tue, 11 Feb 2025 18:53:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1F4D6E0260
	for <cocci@sympa.inria.fr>; Tue, 11 Feb 2025 18:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SfaN8CWjNy1j6tNYO1yBRuspnhy15ItfJDaklRf8ChU=;
  b=Du/uP3a2ossEOJAJHdK6r234zfZxhN50sTyQ71ELKheBdygRiq32YnZ9
   lFctWO8zO10V8kHASqG65+zFx9D5kwrdVLmmi5c1v9CQkam6DWCJ5O/w9
   RckJhrqMf3u6w8giFXuwIqyRJepXJQ+wAhQSidMKMj2/I5yLqO7vpWbtC
   k=;
X-IronPort-AV: E=Sophos;i="6.13,278,1732575600"; 
   d="scan'208";a="207776127"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 18:53:00 +0100
Date: Tue, 11 Feb 2025 18:52:59 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: PICCA Frederic-Emmanuel <frederic-emmanuel.picca@synchrotron-soleil.fr>
cc: cocci <cocci@inria.fr>
In-Reply-To: <1295029600.54623953.1739296026146.JavaMail.zimbra@synchrotron-soleil.fr>
Message-ID: <78c94b6d-23aa-fe7c-72e5-3edef225adf@inria.fr>
References: <537594832.54620672.1739295352359.JavaMail.zimbra@synchrotron-soleil.fr> <24871c64-9c5d-238c-201e-d76988bed1a@inria.fr> <1295029600.54623953.1739296026146.JavaMail.zimbra@synchrotron-soleil.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] how to write an spatch in order to replace guard vs
 #prama once
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2412
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/78c94b6d-23aa-fe7c-72e5-3edef225adf%40inria.fr>



On Tue, 11 Feb 2025, PICCA Frederic-Emmanuel wrote:

> something like this
>
>
> // replace guard by pragma once
>
> @@
> expression E;
> @@
>
> -#ifndef E
> -#define E
> +#pragma once
>
> ...
>
> -#endif
>
>
> where the #endif is the matching one of the first #ifndef

I'm sorry, but I doubt that it will be possible.  The treatment of #ifdef
etc is quite limited, and there is nothing to match the #ifndef up to the
corresponding #endif.  Coccinelle parses the source code, and these
preprocessor options can appear in places that don't really follow the
parse tree structure.

julia
