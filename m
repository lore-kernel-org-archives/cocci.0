Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5429C47073
	for <cocci@archiver.kernel.org>; Sun,  7 Jan 2024 18:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5J8Ge3mMzjklco1PluIUUY7DRh4pLi5eb8stAP2Ht5A=;
  b=d8G/RWRMXGwQM3cL/y1c+OZXz8k6hWvN164r357H6Mli1j69/IubpdyV
   /kADmgSZFikwK82pDYZ06XldCM5wG1hLSBD0A05CRR7O9Eq8rwtWzW4gc
   j9XmUEZgZxwz5l/Zojo/IphMknnFHiFVqk435b+RCIy83eOUVh4U5jKEz
   I=;
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
   d="scan'208";a="145264305"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jan 2024 19:52:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7DA05E0CCC; Sun,  7 Jan 2024 19:52:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 22E07E004E
	for <cocci@sympa.inria.fr>; Sun,  7 Jan 2024 19:52:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5J8Ge3mMzjklco1PluIUUY7DRh4pLi5eb8stAP2Ht5A=;
  b=dZVGCjBKFRj5azXinZLGvf0kfsKtf1p4bhyZ3MEvoxkdd8XhF/kB3sAR
   3qhlsYxEMUgp4N9EQyWVDlr8+/NelFVyBxhEKeD1UvifY+cLV4N0Qjkfy
   CM9UVb7eZh7bWqpyspKYEOCwISPXcqkniCrYuOk2+9eqobh0AcgBkrndv
   8=;
X-IronPort-AV: E=Sophos;i="6.04,339,1695679200"; 
   d="scan'208";a="76059897"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 19:52:07 +0100
Date: Sun, 7 Jan 2024 19:52:06 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jakub Kicinski <kuba@kernel.org>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
In-Reply-To: <20240107103536.5719ce30@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2401071947460.3185@hadrien>
References: <20240107103536.5719ce30@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1938901480-1704653526=:3185"
Subject: Re: [cocci] EXN: Coccinelle_modules.Common.Timeout
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1438
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/alpine.DEB.2.22.394.2401071947460.3185%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1938901480-1704653526=:3185
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



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

The documentation says:

You can use SPFLAGS to add debugging flags, for instance you may want to
add both –profile –show-trying to SPFLAGS when debugging. For instance you
may want to use:

rm -f err.log
export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
make coccicheck DEBUG_FILE="err.log" MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c

So you could say SPFLAGS="--timeout 200", for example.

But the real problem is that Coccinelle was changed at some point to fail
if anything failed.  Whereas in many situations, like here, that is highly
undesirable.  The original motivation was to avoid partial
transformations, but I think it is better that users just monitor the
output to see if there is a risk of that.  Having the most complete
attempt to perform the transformation is almost always better, because it
can help the user figure out what to improve.

julia
--8323329-1938901480-1704653526=:3185--
