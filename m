Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE1EC47073
	for <cocci@archiver.kernel.org>; Sun,  7 Jan 2024 20:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ZC4KxFzo0O5EV2IYajNm3fyfmf0Z+qS6YE0EdoPl86g=;
  b=Z2XP+DiQSOV5IX/N+bhBmIxRDzzpyUGnGjEdcs3b/ZNgin8OGAAQa4H0
   /r8d58e2JzoLl0fVNlibzZGMPxtWNhs0oQTTHkMNTU2Hk83JoJ1nz0KsG
   ZJKEvbx+SyTZifFER82Aap1dbVP2UyEMfowUWMA/+7ygaLyCLsJdotZII
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.04,339,1695679200"; 
   d="scan'208";a="145269099"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jan 2024 21:16:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5EEF8E0CCC; Sun,  7 Jan 2024 21:15:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A88B2E004E
	for <cocci@sympa.inria.fr>; Sun,  7 Jan 2024 21:15:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZC4KxFzo0O5EV2IYajNm3fyfmf0Z+qS6YE0EdoPl86g=;
  b=jhrmUkUegM+HtvKFPyQMYuzNpBG3/2r4UgPmIAH8XzWdXzLq1guYzyZl
   yjlj4BXnPojDwB68hq+ZJHLOOcFpF/Yk1v7g4OALSGfmij0nOyG124CKy
   nuF5Fu9J8NSxzbBgVYpCi5nTpwkOUED8huXZmRU67AJuDud6H2HLCC3+I
   0=;
X-IronPort-AV: E=Sophos;i="6.04,339,1695679200"; 
   d="scan'208";a="76062538"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 21:15:55 +0100
Date: Sun, 7 Jan 2024 21:15:54 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jakub Kicinski <kuba@kernel.org>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
In-Reply-To: <20240107103536.5719ce30@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2401072115050.55089@hadrien>
References: <20240107103536.5719ce30@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] EXN: Coccinelle_modules.Common.Timeout
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1439
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/alpine.DEB.2.22.394.2401072115050.55089%40hadrien>



On Sun, 7 Jan 2024, Jakub Kicinski wrote:

> Hi!
>
> When running coccicheck on net-next I get:
>
> /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/free/clk_put.cocci --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/compiler-version.h --include ./include/linux/kconfig.h --jobs 64 --chunksize 1
> 158 files match
> ./drivers/bus/ti-sysc.c:2362:2-8: ERROR: missing clk_put; clk_get on line 2354 and execution via conditional on line 2361
> ./drivers/tty/serial/bcm63xx_uart.c:850:2-8: ERROR: missing clk_put; clk_get on line 845 and execution via conditional on line 849
> EXN: Coccinelle_modules.Common.Timeout in ./drivers/cpufreq/armada-8k-cpufreq.c
> EXN: Coccinelle_modules.Common.Timeout in ./drivers/cpufreq/mvebu-cpufreq.c
> An error occurred when attempting to transform some files.
> coccicheck failed
> make[1]: *** [/home/cocci/testing/Makefile:2003: coccicheck] Error 255
> make: *** [Makefile:234: __sub-make] Error 2
>
>
> I couldn't google out any meaningful info about this. Is the timeout
> something I can increase locally? Is something wrong?

Perhaps if you pull from github it will work better now, ie keep going
after the timeouts.

julia
