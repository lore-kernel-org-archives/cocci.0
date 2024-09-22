Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78201CF9C69
	for <cocci@archiver.kernel.org>; Sun, 22 Sep 2024 09:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=b0AekWgX+flAycdwxrEFKlY0ZKtuEKFgQSDMqxRuQ+U=;
  b=mPIQtKagdZqe+g6kiCyQM7dHIy6JSJy47SbUqZNUhsDvvMIbblVmhHHf
   QAhjjZm1FfciK6E2HlldVVaadi+NBjpuAcO6upvclDxy20Vd74yxk6NoC
   N/pOk0J9Fb+LBFs/UgTd0F3tPrAFq9H1cVrqpZfJsywMYk8EtVSvmzlMf
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
   d="scan'208";a="184409987"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2024 11:49:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B5CD6E0133; Sun, 22 Sep 2024 11:49:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 98F62E00B7
	for <cocci@sympa.inria.fr>; Sun, 22 Sep 2024 11:49:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=b0AekWgX+flAycdwxrEFKlY0ZKtuEKFgQSDMqxRuQ+U=;
  b=XC0WsQ+p8v7pWF+aI1HVAvz2DZw2SejMl+KbdrSjqe19hOBr0BW5qi9p
   bQA1CNBUrd+tgW2f6pwNJIsOGs0B6nwtl+yRIGLezZtjnC1/CIPuVOyQU
   G653FF9MMxWROxltn8Ebs3bysLdBGYA1r+gQona5gA12yiFjTaGuwY87M
   4=;
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="97029708"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 11:49:08 +0200
Date: Sun, 22 Sep 2024 11:49:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <c2b0fc58-a399-4376-a4a4-2f7a3ed219f0@web.de>
Message-ID: <alpine.DEB.2.22.394.2409221148130.3517@hadrien>
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de> <alpine.DEB.2.22.394.2409212209470.3471@hadrien> <b1872e36-154b-477f-907a-7fc98b301931@web.de> <c2b0fc58-a399-4376-a4a4-2f7a3ed219f0@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-268358908-1726998548=:3517"
Subject: Re: [cocci] Determining a return code variable for a jump target
 (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1877
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/alpine.DEB.2.22.394.2409221148130.3517%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-268358908-1726998548=:3517
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 22 Sep 2024, Markus Elfring wrote:

> > I might be “lucky” for some function implementations
> > when they contain only a single integer variable for returning
> > result values.
>
> It seems that my source code transformation approach is still too incomplete so far
> if I would like to be able to improve also a function like ath12k_pull_reg_chan_list_ext_update_ev().
> https://elixir.bootlin.com/linux/v6.11/source/drivers/net/wireless/ath/ath12k/wmi.c#L4683
>
> It contains the following variable declarations.
>
> 	int ret, i, j;
>
>
>
> SmPL script variant:
>
> // See also:
> // ath12k_pull_peer_assoc_conf_ev
> // https://elixir.bootlin.com/linux/v6.11/source/drivers/net/wireless/ath/ath12k/wmi.c#L5612
> @adjustment2@
> constant c;
> expression e1, e2;
> identifier rc2, x;
> fresh identifier target = "free_" ## x;
> @@
>  int rc2;
>  <+...
>  if (...)
>  {
>  ... when != \( x = e1 \| e2(..., &x, ...) \)
> -   kfree(x);
> -   return
> +   rc2 =
>            -c;
> +   goto target;
>  }
>  ...+>
> +rc2 = 0;
> +target:
>  kfree(x);
>  return
> -       0
> +       rc2
>  ;

How do you expect Coccinelle to figure out what is the right value for
rc2?  The only match is in the declaration, but any int variable
declaration satisfies that.

julia


>
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> spatch …/Projekte/Coccinelle/janitor/use_common_kfree_code2.cocci drivers/net/wireless/ath/ath12k/wmi.c
> init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
> …
> SPECIAL NAMES: adding list_for_each_entry as a iterator
>
> previous modification:
> MINUS
>   >>> rc2
>
>
> According to environment 1:
>    adjustment2.rc2 -> id ret
>
>
> current modification:
> MINUS
>   >>> rc2
>
>
> According to environment 1:
>    adjustment2.rc2 -> id j
>
>
> exn while in timeout_function
> adjustment2: already tagged token:
> C code context
> File "drivers/net/wireless/ath/ath12k/wmi.c", line 4975, column 8, charpos = 151798
>   around = '0',
>   whole content =       return 0;
>
>
>
> How will corresponding case distinctions evolve further (with SmPL disjunctions)?
>
> Regards,
> Markus
>
--8323329-268358908-1726998548=:3517--
