Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F88CA1013
	for <cocci@archiver.kernel.org>; Fri,  5 Sep 2025 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=qjDMlR820tFBEhIlW52LN6YMtOAXMSSbrvE9DaKH11M=;
  b=aC4gvmnGFBms+JcfKJt0oDd0OgyflCZ51vs+jGSsHRfHHq56UyqE9zmb
   8vrZvpiM6aEEo2VcZNmvHf63x/bgENF1VRdxEA+pTn8InYmFNMDrSiDdn
   zJsaVq9Cxplwl7MuTN6S0fUPx+up7yYlnep22XDX2FpFLorIB9tv1r0eP
   Q=;
X-CSE-ConnectionGUID: XkxXHiQpSJy3kRCCj7XWuA==
X-CSE-MsgGUID: zqFd5O5+Sai2ioXTp9dKfw==
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
X-IronPort-AV: E=Sophos;i="6.18,240,1751234400"; 
   d="scan'208";a="237673319"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2025 11:42:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CC266E0CDF; Fri,  5 Sep 2025 11:42:15 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F407BE0171
	for <cocci@sympa.inria.fr>; Fri,  5 Sep 2025 11:42:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qjDMlR820tFBEhIlW52LN6YMtOAXMSSbrvE9DaKH11M=;
  b=fE3LFOOFjvW8jmXGhS6mOvTib2UKaUl7Xyj09cauR0IuiRoa8xHgcFUX
   ZhsIRQSj/n/QGtFK83NTa5UvCMvuBlZPD4QRegTaoN2+FcBOFGKYsgkNE
   EOPAmxaQ7+UtYpTnpmrN9RjuA0nG8dhTlPHOo4zUK/ycTOssRB9Rkn5PU
   A=;
X-CSE-ConnectionGUID: /WQY4bALRvepvsRnZZROKQ==
X-CSE-MsgGUID: hkoij3PeRQGduZquHfoiIw==
X-IronPort-AV: E=Sophos;i="6.18,240,1751234400"; 
   d="scan'208";a="237673286"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 11:42:15 +0200
Date: Fri, 5 Sep 2025 11:42:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <ba6b7f45-6c59-4ad1-9b4b-a02f34036d7e@web.de>
Message-ID: <a00a59b-3079-d55c-eaf6-2db4c14f92a3@inria.fr>
References: <ba6b7f45-6c59-4ad1-9b4b-a02f34036d7e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [RFC] Sharing data processing resources for selected
 SmPL scripts?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2994
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/a00a59b-3079-d55c-eaf6-2db4c14f92a3%40inria.fr>



On Fri, 5 Sep 2025, Markus Elfring wrote:

> Hello,
>
> I became curious if further developers would like to try the following script out
> for the semantic patch language.
>
>
> @display@
> identifier action;
> type t;
> @@
> *t * action(...)
>  {
>  ... when any

when any is not useful here.

>  }
>
>
> I interpret such a search approach in the way that it should extract some data
> from a lot of source code places.
> Thus I imagine that it results also in special software run time characteristics
> which matter especially for big codebases like Linux.

I guess it would be quite fast, because it will just find the deader of
each function.

julia

> How do you think about to clarify corresponding data collections
> and computation resources?
>
> Related source code analysis concerns can eventually be also clarified.
>
> * Handling of function declarations in header files
>
> * Relevance of some preprocessor directives
>
>
> Regards,
> Markus
>
