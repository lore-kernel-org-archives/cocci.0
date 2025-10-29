Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6D0CCF9EE
	for <cocci@archiver.kernel.org>; Wed, 29 Oct 2025 21:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=FERmsB+tS9xO1ykNi67NXdFvsLGuPfJXUcOk6M+xjwo=;
  b=hjgDYlngnGEfSvsFaLpg4vdGmKZJ0CdrWwfXYkjIRqagDkzdvpW5TRyY
   TbKI4ssPJdr+uxn4YAFT04ydgOpMbUPgTEWPi7VdXaqxaQfFYit8kYOm2
   LSWa4Nq5Vy93fHFV1boV7GTK55M6LLzwya7J0m4aNgvmOuXgj7Y0Cc6uY
   A=;
X-CSE-ConnectionGUID: jw5UfO/5R+W4TX2JLm8qxw==
X-CSE-MsgGUID: LrRESE3eSDO+FlNd1iOGXw==
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
X-IronPort-AV: E=Sophos;i="6.19,265,1754949600"; 
   d="scan'208";a="246753530"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2025 22:24:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1CC2DE0C55; Wed, 29 Oct 2025 22:24:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7E440E0171
	for <cocci@sympa.inria.fr>; Wed, 29 Oct 2025 22:24:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FERmsB+tS9xO1ykNi67NXdFvsLGuPfJXUcOk6M+xjwo=;
  b=l4LgjgNse9C2yymulJpUXI76EyG66UuPXFBWOd3zZQdypaNsyrbIdf6u
   ITfTyetuwWDSwJP7lXikmkY1J+y/zibBw2JQBymcw3C+fsFvfs18EONMZ
   wgdUd8p8PpnLJUX/nZunXR1usZMA48/eIo7vN+rvpymSPO2ORnQJVtdIy
   U=;
X-CSE-ConnectionGUID: 3nQfdhFETqCNj1Uo4OorKw==
X-CSE-MsgGUID: 3JezrcibS/2QdtaevInyXQ==
X-IronPort-AV: E=Sophos;i="6.19,265,1754949600"; 
   d="scan'208";a="246753524"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 22:24:01 +0100
Date: Wed, 29 Oct 2025 22:24:01 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
Message-ID: <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-899333787-1761773041=:4032"
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3113
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/e54a6e57-6bde-f489-f06f-fed9537688df%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-899333787-1761773041=:4032
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 29 Oct 2025, Markus Elfring wrote:

> Hello,
>
> I got into the mood to try another simple source code transformation out which
> can be achieved also by the means of the semantic patch language.
>
> @replacement@
> expression object, size, source, target;
> @@
>  target =
> -         object;
>  memcpy(
> -       target
> +       object
>         , source,
>         size);
>
>
> Test result (according to the software combination “Coccinelle 1.3.0”):
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --timeout 23 -j4 --chunksize 1 --no-loops -dir . …/Projekte/Coccinelle/janitor/use_memcpy_assignment.cocci > …/Projekte/Bau/Linux/scripts/Coccinelle/use_memcpy_assignment-no_loops-20251029.diff 2> …/Projekte/Bau/Linux/scripts/Coccinelle/use_memcpy_assignment-no_loops-errors-20251029.txt
> real    5m35,579s
> user    20m20,037s
> sys     0m14,467s
>
>
> It can be determined then from the generated diff file that mentioned
> implementation details can be transformed in 304 source files at the moment.
> Thus I became curious if it would be supported to adjust any places there
> according to (Linux) coding style preferences.

If you have a concern, you have to say what it is.  It doesn't seem it is
about the running time, so why do you include that information?

I should not have to repeat your experiment to figure out what you are
asking about.

julia
--8323329-899333787-1761773041=:4032--
