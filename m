Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7135CF9C64
	for <cocci@archiver.kernel.org>; Sun, 22 Sep 2024 13:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Ky1PFV6q3wr5eFCWexRazC3cYKdMPe8jyaeOvoA1ZY4=;
  b=jzDkWC0OOfVDda/SXZc58U2E4006ZnXhg3l93LrK2xawkuHGN5xYo2aD
   NbPAgp5QrdGbHjJhj5Jftj3ycAvj4BdJKOcxheLCaKJZUrPgcOcYQoViQ
   EZlBYLznybPGbtqyd1W7XS1sAw2EYtx8Qr0gWW+G7REunQ9QZeunxpBR6
   I=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184421178"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2024 15:25:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E68EE0145; Sun, 22 Sep 2024 15:25:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D1BABE00B7
	for <cocci@sympa.inria.fr>; Sun, 22 Sep 2024 15:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ky1PFV6q3wr5eFCWexRazC3cYKdMPe8jyaeOvoA1ZY4=;
  b=ia+0Q95rvq2RPn9hzZTE/YX8NY/H9TH1b3UAkR/oKu1voTxyUmoOmzjm
   rUl15eBFJM+0m6ES7NMFYloXdGsIvbIQmXEClEXb+Y81LOpt5m4fjltMp
   KRlfIxp2ySSsGhPeVmGogV45Y0OKagEo/VkLzs0I+gtNBFsJOeI6Uf9MZ
   U=;
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184421177"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 15:25:44 +0200
Date: Sun, 22 Sep 2024 15:25:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <42f5079e-472b-42ed-9429-2c636b9a14a3@web.de>
Message-ID: <alpine.DEB.2.22.394.2409221525030.3517@hadrien>
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de> <alpine.DEB.2.22.394.2409212209470.3471@hadrien> <b1872e36-154b-477f-907a-7fc98b301931@web.de> <c2b0fc58-a399-4376-a4a4-2f7a3ed219f0@web.de> <alpine.DEB.2.22.394.2409221148130.3517@hadrien>
 <5073d921-72a6-4992-97bf-36a7b792b7c5@web.de> <alpine.DEB.2.22.394.2409221321131.3517@hadrien> <d2d6b276-0f4d-43ea-86d6-6568b79f58ac@web.de> <alpine.DEB.2.22.394.2409221400080.3517@hadrien> <42f5079e-472b-42ed-9429-2c636b9a14a3@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-355897855-1727011544=:3517"
Subject: Re: [cocci] Determining a return code variable for a jump target
 (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1883
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/alpine.DEB.2.22.394.2409221525030.3517%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-355897855-1727011544=:3517
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 22 Sep 2024, Markus Elfring wrote:

> >> Would another SmPL code exclusion specification be sufficient (for a while)?
> >
> > I doubt it would cover everything, but it could be useful for some cases.
>
> I became interested in another extension of the discussed source code
> transformation approach.
> I would like to benefit from the SmPL question mark (singleton) together with
> another SmPL code exclusion specification.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/083506fcc2b833796a749a9da806d4920b545584/docs/manual/cocci_syntax.tex#L1205
> https://github.com/coccinelle/coccinelle/blob/2297fc0f90ce8bef78d2977e9aacc188d7e87c6d/docs/manual/cocci_syntax.tex#L1205
>
> SmPL script variant:
>
> // See also:
> // ath12k_pull_reg_chan_list_ext_update_ev()
> // https://elixir.bootlin.com/linux/v6.11/source/drivers/net/wireless/ath/ath12k/wmi.c#L4683
> @adjustment7@
> constant c;
> expression e1, e2;
> identifier x;
> fresh identifier target = "free_" ## x;
> @@
> -kfree(x);
> ?ath12k_warn( ... when != \( x = e1 \| e2(..., &x, ...) \) );
> -return
> +my_test =
>            -c;
> +goto target;
>
>
> Questionable test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci use_common_kfree_code7.cocci
> …
> minus: parse error:
>   File "use_common_kfree_code7.cocci", line 11, column 18, charpos = 282
>   around = 'when',
>   whole content = ?ath12k_warn( ... when != \( x = e1 \| e2(..., &x, ...) \) );
>
>
> I would appreciate your advice for this use case.

I don't understand what you are trying to do.  It is not common to find an
assignment, for example, in an argument list.  In any case, I guess that
when is not supported on argument lists.

julia
--8323329-355897855-1727011544=:3517--
