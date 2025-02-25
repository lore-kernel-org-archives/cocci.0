Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B64C021B8
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=YpDoZtP8PrcfAm2H9M7hP0wtS00tiq65kgahKiJKlHw=;
  b=aBvQLD/EZkzpLxofcvlegAesxrpqvqkzmcwrkUS2WiEn2z5sggdgUZ/Q
   gT1nR65wN3L36dCeTV+GVT6TP/1OU0DvLRzYUGwP0LRkMQ2TkEbugTujk
   pY8ja+Z/och9BzzcLI/xm9gCYY3Bj6DpVY50jxMCXiq2qiZCrhwJUtrkH
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
   d="scan'208";a="210044532"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:33:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3AE60E0D1D; Tue, 25 Feb 2025 21:33:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A954BE0260
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:33:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YpDoZtP8PrcfAm2H9M7hP0wtS00tiq65kgahKiJKlHw=;
  b=mPbs4mTet7UQLAb45ljFo+JARcL138awi0UYUI+u1PhkDB96Z2mtjnNK
   z93tbXK2C/OTzA3RK1C+FFTneD3jLNeKbWqobC82oHXFjNsKBjn1dGk2H
   3AouWfaUzguS7ytdq1e8vGIn/v65VudWyW9UePoTIxNBSXK4MOzbLWcTi
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="110053840"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:33:20 +0100
Date: Tue, 25 Feb 2025 21:33:19 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
cc: cocci@inria.fr
In-Reply-To: <Z7zjkyOeoPNYeOR3@blossom>
Message-ID: <alpine.DEB.2.22.394.2502252132540.3444@hadrien>
References: <Z7zjkyOeoPNYeOR3@blossom>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Replacement of the form `x |= function()`
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2450
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/alpine.DEB.2.22.394.2502252132540.3444%40hadrien>



On Mon, 24 Feb 2025, Alyssa Rosenzweig wrote:

> Hi, I've hit an awkward corner case combining operators-with-assignment
> with a function call in the replacement of a semantic patch.
>
> These patches both work as expected (@@..@@ sections omitted):
>
>     -lhs = rhs;
>     +lhs |= rhs;
>
> and
>
>     -lhs = rhs;
>     +lhs = myfunc(rhs);
>
> However, putting it together...
>
>     -lhs = rhs;
>     +lhs |= myfunc(rhs);
>
> ...fails with a parse error
>
>     plus: parse error:
>       File "s.cocci", line 7, column 8, charpos = 59
>       around = 'myfunc',
>       whole content = +lhs |= myfunc(rhs);
>
> Is this expected? Is this a Coccinelle bug, or an invalid semantic
> patch? Is there a correct way to specify this replacement?
>
> ---
>
> As a workaround, this patch does work
>
>     -lhs = rhs;
>     +lhs |= (myfunc(rhs));
>
> ..but results in superfluous parantheses in the output... which I guess
> can be removed with
>
>     -lhs = (rhs);
>     +lhs = rhs;
>
> ...but this is surely not the right fix :-)

What version of Coccinelle do you have?  For me it works fine...

julia
