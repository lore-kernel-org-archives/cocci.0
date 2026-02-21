Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B078C61DE5
	for <cocci@archiver.kernel.org>; Sat, 21 Feb 2026 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0E0cRYqijrCwJh0X9loWN0ExmdDOCjZ4/52FX0z2YyY=;
  b=Nb0P22FNp0A4jg4YuPBTMPVBriV8vMR4pwKUmN6uGUiAAs3zZ3XDLSTA
   s4KVikwXnid3qDMppSnhNnUg/IC0pXLayKnjoWFBtf3EuTqIS0kgrlPDD
   5b7NumvOmtcVc31r8Siq233mXk2YJYOSd/j0nmzHPz4X47DR6WM+JWGWd
   s=;
X-CSE-ConnectionGUID: YjFqo0iBQ0OU4cMoZ2rMsQ==
X-CSE-MsgGUID: FSir41dETZW1dtf2yX82Tw==
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
X-IronPort-AV: E=Sophos;i="6.21,304,1763420400"; 
   d="scan'208";a="264543514"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Feb 2026 17:40:39 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 73A2F817AC; Sat, 21 Feb 2026 17:40:39 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0A2F48029C
	for <cocci@sympa.inria.fr>; Sat, 21 Feb 2026 17:40:34 +0100 (CET)
X-CSE-ConnectionGUID: XshNDX13RiGDrwkmXEs6Uw==
X-CSE-MsgGUID: H9TCGdPvS/WbwM0UP93BxQ==
X-IronPort-AV: E=Sophos;i="6.21,304,1763420400"; 
   d="scan'208";a="139448696"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2026 17:40:34 +0100
Date: Sat, 21 Feb 2026 17:40:33 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Benjamin Philip <benjamin.philip495@gmail.com>
cc: Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, Jonathan Corbet <corbet@lwn.net>, 
    cocci@inria.fr, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20260106190836.36630-1-benjamin.philip495@gmail.com>
Message-ID: <905ec76f-027-c71-5154-76d8c4e7dbc8@inria.fr>
References: <20260106190836.36630-1-benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH RESEND 0/3] scripts: coccicheck: document debug
 log handling
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3306
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-02/HdJtC0FjWHxmLmGAmTweGg>



On Wed, 7 Jan 2026, Benjamin Philip wrote:

> Currently coccicheck prints debug logs to stdout unless a debug file has been
> set. This makes it hard to read coccinelle's suggested changes, especially for
> someone new to coccicheck.
>
> This patchset documents this behaviour in both the coccicheck script as well as
> in the dev-tools documentation. Additionally, it simplifies some of the logic
> for handling debug files.

All applied, thanks.

julia

>
> Benjamin Philip (3):
>   scripts: coccicheck: simplify debug file handling
>   scripts: coccicheck: warn on unset debug file
>   Documentation: Coccinelle: document debug log handling
>
>  Documentation/dev-tools/coccinelle.rst | 21 ++++++++++++++++-----
>  scripts/coccicheck                     | 21 +++++++++++++--------
>  2 files changed, 29 insertions(+), 13 deletions(-)
>
> --
> 2.52.0
>
>
