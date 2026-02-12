Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38A9EE369B
	for <cocci@archiver.kernel.org>; Thu, 12 Feb 2026 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UxuQXWjt+XPZA1mw+PjvGM+eBbC9st0ibBqhiOgXypY=;
  b=haIdrNMzHkhHzQFeds47dpiEE/yYR4h8MljEnqYTRkGDhnQcZF0zoxMT
   +kSX07jzedphG7eXW8cHDNvBiXOKWirrpwzCKJ4x+szapwLuTqFD2xeY8
   FsEP3WzhuBsI07c+IF8JyLnsOd0x8DyE7JR2bH6yuTjWfSH0wTEyQLZZe
   4=;
X-CSE-ConnectionGUID: N62bvngPRcOrise1ZbJ2vA==
X-CSE-MsgGUID: NHOCXb6iSnObna42L8i9ug==
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
X-IronPort-AV: E=Sophos;i="6.21,286,1763420400"; 
   d="scan'208";a="263216292"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Feb 2026 16:45:08 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 48F0E82715; Thu, 12 Feb 2026 16:45:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 24D1482717
	for <cocci@sympa.inria.fr>; Thu, 12 Feb 2026 16:45:03 +0100 (CET)
X-CSE-ConnectionGUID: jnccIH/dSwyRF8Lh/xrGRQ==
X-CSE-MsgGUID: qvtTaLp3T82W+EeZ4E6S/g==
X-IronPort-AV: E=Sophos;i="6.21,286,1763420400"; 
   d="scan'208";a="138669831"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 16:45:03 +0100
Message-ID: <188a3101-bc35-4f07-9425-72463a44a59b@inria.fr>
Date: Thu, 12 Feb 2026 16:45:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
References: <20260212134249.3790-1-olaf@aepfle.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <20260212134249.3790-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH v1] Substitute LIBDIR for file paths
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3305
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-02/NQYHo5P4AvGhgxoGjOav4A>

Looks good. I just merged it, thanks for the patch!

On 2/12/26 14:42, Olaf Hering wrote:
> LIBDIR is already used earlier in this file, but such usage was
> apparently overlooked in commit 99d699e8eaf5ba49faf5ac55584e24357580df50.
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>   docs/spatch.1.in | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/spatch.1.in b/docs/spatch.1.in
> index e54150402..37975f330 100644
> --- a/docs/spatch.1.in
> +++ b/docs/spatch.1.in
> @@ -166,13 +166,13 @@ set number of diff context lines
>   report partial matches of the SP on the C file
>   .TP
>   \fB\-\-iso\-file\fR
> -<file> (default=/usr/local/lib/coccinelle/standard.iso)
> +<file> (default=@LIBDIR@/standard.iso)
>   .TP
>   \fB\-\-macro\-file\fR
>   <file>
>   .TP
>   \fB\-\-macro\-file\-builtins\fR
> -<file> (default=/usr/local/lib/coccinelle/standard.h)
> +<file> (default=@LIBDIR@/standard.h)
>   .TP
>   \fB\-\-recursive\-includes\fR
>   causes all available include files, both those included in the C file(s) and those included in header files, to be used
