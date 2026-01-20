Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13066D2ECF7
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 12:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GSlYyMNPyo3nTygPcryodFS1sqXZdlseWzX9iuCJUy0=;
  b=vVUdzXNAdhtgxlvCPlsSOUbwZEfDt3edUTftBE8WO0nTtF+Ynswq+o/P
   pCuroJPzNhaPAFtsqidhLtOwwbSivq9lzaX4lBoNP+zbhzqwFjg+BIdHU
   B4sKif/6gUdzRG70SD6klCI/jzSHukjDy26U5ZpAG5PURIjirK9T5V2QE
   g=;
X-CSE-ConnectionGUID: tktn2V3aR4ickyLpkN/0kQ==
X-CSE-MsgGUID: tZzoxJSURhuBU1pI+PPKIQ==
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
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259448593"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 13:32:12 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8051083A4A; Tue, 20 Jan 2026 13:32:12 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5B68283A0A
	for <cocci@sympa.inria.fr>; Tue, 20 Jan 2026 13:32:09 +0100 (CET)
X-CSE-ConnectionGUID: F+ym4SO7RgyYZhvhYKVWZA==
X-CSE-MsgGUID: C4kPhhLYR06hOY4KseEzbA==
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="136504220"
Received: from unknown (HELO hadrien) ([4.26.64.170])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 13:32:07 +0100
Date: Tue, 20 Jan 2026 07:32:06 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Benjamin Philip <benjamin.philip495@gmail.com>
cc: Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, Jonathan Corbet <corbet@lwn.net>, 
    cocci@inria.fr, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20260106190836.36630-1-benjamin.philip495@gmail.com>
Message-ID: <699831d6-694b-5435-5afc-c86e5a815a61@inria.fr>
References: <20260106190836.36630-1-benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH RESEND 0/3] scripts: coccicheck: document debug
 log handling
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3286
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/zPvEiC1BSePeoWikfzE8ng>



On Wed, 7 Jan 2026, Benjamin Philip wrote:

> Currently coccicheck prints debug logs to stdout unless a debug file has been
> set. This makes it hard to read coccinelle's suggested changes, especially for
> someone new to coccicheck.
>
> This patchset documents this behaviour in both the coccicheck script as well as
> in the dev-tools documentation. Additionally, it simplifies some of the logic
> for handling debug files.
>
> Benjamin Philip (3):
>   scripts: coccicheck: simplify debug file handling
>   scripts: coccicheck: warn on unset debug file
>   Documentation: Coccinelle: document debug log handling
>
>  Documentation/dev-tools/coccinelle.rst | 21 ++++++++++++++++-----
>  scripts/coccicheck                     | 21 +++++++++++++--------
>  2 files changed, 29 insertions(+), 13 deletions(-)

Thanks for the update.  I will try to get this in for the next release.

julia
