Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8828BC5B552
	for <cocci@archiver.kernel.org>; Tue, 10 Jun 2025 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8a509sIBjqxcrLFTUpA9OdHpt12xSyK8z8InIX6lqVg=;
  b=FZ7aLUTuIBsrzKMeen8c+RvEC6MbA45cy4CVK4edyPiMHNYQ32Y3MW0O
   H7l/l/k1pE4jHgStS8AwQNqjoKuf04Vo4WbAHoOCN7paDHfZQx4QgfJOM
   j/raoM9UtBZ2ebxKdgIzayfCR5u9OXun3ZOlx28S+Vvnw4DndHl4ioZU6
   U=;
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
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="226154612"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2025 17:43:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 86888E0AF1; Tue, 10 Jun 2025 17:43:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D064DE0131
	for <cocci@sympa.inria.fr>; Tue, 10 Jun 2025 17:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8a509sIBjqxcrLFTUpA9OdHpt12xSyK8z8InIX6lqVg=;
  b=QSU3wTgNRZ/8/CcCzG0Bo/W5w9YdeaU3467RHuN6/bzFBfPivqTNqZHj
   +vwmh3kRXj0hpkOJhLORztL4OAHSw498yxkIO4MRQMlTHzXNeYoIuqajh
   PGCDJ2/ewV2hRq14dYGxIpDbf9iEDDPda28O6CIhyA55CtPpJFf6Xgzvy
   s=;
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="118678606"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:43:53 +0200
Date: Tue, 10 Jun 2025 17:43:52 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <90822099-5434-4421-a611-785511926ecb@web.de>
Message-ID: <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
References: <90822099-5434-4421-a611-785511926ecb@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1547811474-1749570232=:4658"
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2753
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/alpine.DEB.2.22.394.2506101739440.4658%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1547811474-1749570232=:4658
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 10 Jun 2025, Markus Elfring wrote:

> Hello,
>
> I accidentally noticed an update candidate.
>
> c4iw_rdev_open():
> https://elixir.bootlin.com/linux/v6.15.1/source/drivers/infiniband/hw/cxgb4/device.c#L908-L909
>
> I got into the mood to construct another script variant for the semantic patch language.
>
> @deletion@
> expression e;
> @@
>  if (...
> -    && e
>     )
>     kfree(e);
>
>
> A corresponding patch can be generated accordingly.
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --no-loops …/Projekte/Coccinelle/janitor/delete_redundant_checks4.cocci drivers/infiniband/hw/cxgb4/device.c
> …
> @@ -905,7 +905,7 @@ static int c4iw_rdev_open(struct c4iw_rd
>
>         return 0;
>  err_free_status_page_and_wr_log:
> -       if (c4iw_wr_log && rdev->wr_log)
> +       if (c4iw_wr_log)
>                 kfree(rdev->wr_log);
>         free_page((unsigned long)rdev->status_page);
>  destroy_ocqp_pool:
>
> real    0m0,454s
> user    0m0,413s
> sys     0m0,038s
>
>
> I tried another program call out.
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> git checkout next-20250606 && time /usr/bin/spatch --no-loops --timeout 45 -j4 --chunksize 1 -dir . …/Projekte/Coccinelle/janitor/delete_redundant_checks4.cocci > …/Projekte/Bau/Linux/scripts/Coccinelle/deletions1/next/20250606/delete_redundant_checks4.diff 2> …/Projekte/Bau/Linux/scripts/Coccinelle/deletions1/next/20250606/delete_redundant_checks4-errors.txt
> …
> real    5m42,692s
> user    20m26,077s
> sys     0m13,532s
>
>
> Now I wonder why the known generated patch was not written into the specified
> diff file for this command variant.
> How will the desired data output become consistent (after the software
> combination “Coccinelle 1.3.0”) for such an use case?

Could yo uplease make a small effort to make your reports understandable?

1) I don't ned to know the paths of your files?  This adds a lot of
clutter that makes it hard to find the important information.

2) The proper scientific method is to cange only one thing at a time.  You
seem tohave changed two things 1: in one case you give the specific file
name andin the second case you use the whole Linux kernel directory, and
2; in one case you are using linux-next from a specific date andin the
other case there is no information about what kernel version you are
using.

In the second test, can you check whether the file you expect to be
considered is included in a HANDLING line in the output?

If it is included in the HANDLING line in the output, can you resend your
report that addresses the above two issues?

julia
--8323329-1547811474-1749570232=:4658--
