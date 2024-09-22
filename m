Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC94CF9C6C
	for <cocci@archiver.kernel.org>; Sun, 22 Sep 2024 12:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GNAXf/guRQolax9TIW3CIGPIARlAcMVxrtndC4tJ+ig=;
  b=R9OWxtxNE8a/lx0RH+Wv0jpXbGqK9sRFCRgrtjHxYk+3emzo+H4DQhTD
   5mjAot3Yi20uSPWVEIDcXL2Z8nm+davA2LmCP8PtJxr0lTOECQ8n9+gJS
   DKAqw9LiIHdUy+vBpBEkV1iv6GGNSNGjc1DvSuwr6f7TcrNUqdEQsiKIW
   E=;
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
   d="scan'208";a="184417178"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2024 14:00:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9C540E013D; Sun, 22 Sep 2024 14:00:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 81313E00B7
	for <cocci@sympa.inria.fr>; Sun, 22 Sep 2024 14:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GNAXf/guRQolax9TIW3CIGPIARlAcMVxrtndC4tJ+ig=;
  b=neiYIU+PI1jPok7G03xd5Xh3wmkJjYKEx1aVHgcqLSzXrO4HlfJTu1KZ
   dUV4d/i48vDuY3lN+HUwcoqJKYrOJO/gbVRrgM2ivm3e82+dTKJwNjnAj
   aZmQ9M5LvtPmQFNtbvvi/q6bYQRg74LBoY6y7RDlefS19G5X0PTPZWlS2
   s=;
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184417174"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 14:00:37 +0200
Date: Sun, 22 Sep 2024 14:00:36 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d2d6b276-0f4d-43ea-86d6-6568b79f58ac@web.de>
Message-ID: <alpine.DEB.2.22.394.2409221400080.3517@hadrien>
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de> <alpine.DEB.2.22.394.2409212209470.3471@hadrien> <b1872e36-154b-477f-907a-7fc98b301931@web.de> <c2b0fc58-a399-4376-a4a4-2f7a3ed219f0@web.de> <alpine.DEB.2.22.394.2409221148130.3517@hadrien>
 <5073d921-72a6-4992-97bf-36a7b792b7c5@web.de> <alpine.DEB.2.22.394.2409221321131.3517@hadrien> <d2d6b276-0f4d-43ea-86d6-6568b79f58ac@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-561580743-1727006437=:3517"
Subject: Re: [cocci] Determining a return code variable for a jump target
 (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1881
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/alpine.DEB.2.22.394.2409221400080.3517%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-561580743-1727006437=:3517
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 22 Sep 2024, Markus Elfring wrote:

> >>> The only match is in the declaration, but any int variable
> >>> declaration satisfies that.
> >>
> >> I would like to increase case distinctions accordingly.
> >> Variables like “i” and “j” are obviously used in some for loops (for example).
> >> How should such control flow properties be restricted by the means of
> >> the semantic patch language?
> >
> > You can use other rules, inheritance, position variables, etc to
> > disqualify a variable that is not used in the way you like, or that is
> > used in a way that you dont like.
>
> Would another SmPL code exclusion specification be sufficient (for a while)?

I doubt it would cover everything, but it could be useful for some cases.

julia

>
> SmPL script variant:
>
> // See also:
> // ath12k_pull_reg_chan_list_ext_update_ev()
> // https://elixir.bootlin.com/linux/v6.11/source/drivers/net/wireless/ath/ath12k/wmi.c#L4683
> @adjustment5@
> constant c;
> expression e1, e2;
> identifier rc2, x;
> fresh identifier target = "free_" ## x;
> @@
>  int rc2;
>  <+... when != \( rc2++ \| ++rc2 \| rc2-- \| --rc2 \)
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
>
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time spatch …/Projekte/Coccinelle/janitor/use_common_kfree_code5.cocci drivers/net/wireless/ath/ath12k/wmi.c
> …
> Note: processing took    17.6s: drivers/net/wireless/ath/ath12k/wmi.c
>
> real    0m17,669s
> user    0m17,556s
> sys     0m0,106s
>
>
> Regards,
> Markus
>
--8323329-561580743-1727006437=:3517--
