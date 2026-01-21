Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1501D4694E
	for <cocci@archiver.kernel.org>; Wed, 21 Jan 2026 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=wslOWCGMe4c5HvEwFq5IG3jW5W/2RML+IoZKFQX6GHQ=;
  b=Xnd5+zaOg5S3siTEaY1xgD7II5wqqNlgpyNsf5jHjh/EXyxpY2nmBMTt
   L4NOXqalqag39N62xeGQoArDR12HjOntwLuotpDTopkm7ZMTg6et/aNGf
   Nfl/zFY5jgd1djTiIOFFhVYDCa7RtIOIMMIlTPpDjIaqeZqHLmWtE5dyM
   8=;
X-CSE-ConnectionGUID: 9CTQyOAPQ3+8pWW8PUdOxQ==
X-CSE-MsgGUID: go1tVqxDQ36aFhCAEATpAg==
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
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259695349"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2026 16:57:59 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4DA4481A3B; Wed, 21 Jan 2026 16:57:59 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 70F4B819E6
	for <cocci@sympa.inria.fr>; Wed, 21 Jan 2026 16:57:54 +0100 (CET)
X-CSE-ConnectionGUID: jiBhVSqYS4C4xOwH5w/2RA==
X-CSE-MsgGUID: 06rW0qMZQoSXXR1i2IK3lQ==
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259695327"
Received: from unknown (HELO hadrien) ([4.26.64.170])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 16:57:54 +0100
Date: Wed, 21 Jan 2026 10:57:51 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
In-Reply-To: <f222ef51-388a-441d-b9e3-c7abebc0a2d7@web.de>
Message-ID: <258386cb-4f80-64a-4340-ec9b7c4d336@inria.fr>
References: <87v7i7g615.fsf@mmap.at> <af6a88ac-fe87-47d9-8e55-b570f205afc4@inria.fr> <c393376f-a5b7-4e7c-b593-052528b9fcb0@inria.fr> <f222ef51-388a-441d-b9e3-c7abebc0a2d7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Pre-compiled spatch links against EOL PCRE version
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3297
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/HLeXzKvomZbpWRExrQ9edg>



On Wed, 21 Jan 2026, Markus Elfring wrote:

> > Work on PCRE2 has been completed - I've finished what Olaf's started.
> >
> > The patch is on master (b231de0db). Feel free to send feedback if you notice any issues once this becomes a release.
>
> Thanks for another remarkable software development progress.
>
> Unfortunately, I would miss further improvements for the software build system so far.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/b231de0db3f9513f6ea936caea5428fe627af1b9
>
> I tried also to influence corresponding adjustments somehow.
> Will development interests grow accordingly?

If you want something to change, could you please explain what should
change, or better yet provide a patch?  "miss further improvements" gives
no information about what should be done.

julia
