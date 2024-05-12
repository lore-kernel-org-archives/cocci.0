Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEA1C10F1A
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 14:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=DHgieCMJdjKnjrQlj+QmDrh9WlxB1Shbk29SHsq+vg0=;
  b=C7A+/wcd5EA7Fcw6dkavAvx7b2wlLavb+tgUJNR+CG5dsAPpTviJUM6C
   xb7w3g1mcYuUpHQW9uzf1D25zAe2c3bWpJLBHDYpMyWOLxMEFLvOqc41e
   gojiYhSAwcRNCjcin+vZbSE0VggxeuUHFGNBpTS0TOUKgtD17rm3GA9iA
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.08,156,1712613600"; 
   d="scan'208";a="165250071"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 16:57:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E732CE0CCE; Sun, 12 May 2024 16:57:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 97048E004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 16:57:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DHgieCMJdjKnjrQlj+QmDrh9WlxB1Shbk29SHsq+vg0=;
  b=O5Kk59O0y8Sk70URa26USmQhIV08p/NSavaQik2xvAcZJyEwYwMtAdBG
   6ANAeM3KLBWvSrSzV9crFtrf48FB0N6KMLOMHd4HnbMeQ11mqkC/RXVzA
   SEC1v0IY8RhCk4hA+fxyoPaz7Tqp0ay36PSmwAN20jCgh02DDdU93YN2U
   A=;
X-IronPort-AV: E=Sophos;i="6.08,156,1712613600"; 
   d="scan'208";a="165250070"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 16:57:36 +0200
Date: Sun, 12 May 2024 16:57:36 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <0f37e7b2-df29-44ac-b4da-69168bf7a85c@web.de>
Message-ID: <alpine.DEB.2.22.394.2405121655440.6747@hadrien>
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de> <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr> <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de> <alpine.DEB.2.22.394.2405111803140.14453@hadrien> <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
 <alpine.DEB.2.22.394.2405120932360.6747@hadrien> <ac4b8c84-abb1-496b-9377-4f47c1f7cbb0@web.de> <alpine.DEB.2.22.394.2405121451530.6747@hadrien> <ac848508-8b0f-418a-a2b0-45cd68176d7c@web.de> <alpine.DEB.2.22.394.2405121513320.6747@hadrien>
 <0f37e7b2-df29-44ac-b4da-69168bf7a85c@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-804189328-1715525856=:6747"
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1735
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405121655440.6747%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-804189328-1715525856=:6747
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 12 May 2024, Markus Elfring wrote:

> > The language is as it is.  You can express various things by adding more
> > or less information.
>
> The previous SmPL script example indicated special SmPL code design possibilities.
> Thus I would like to apply such development experiences to another SmPL script variant.
>
>
> // See also:
> // qca_read_fw_build_info()
> // drivers/bluetooth/btqca.c
> @replacement@
> identifier exit, result;
> statement s;
> @@
>  ... when != if (...) { ... when any result = -EILSEQ; goto exit; }

There is currently no way to nest whens.

julia

> (if (...)
> -{
> -   result = -EILSEQ;
>     goto
> -        exit
> +        e_ilseq
>     ;
> -}
> |if (...)
>  {
>  ... when any
> -   result = -EILSEQ;
>     goto
> -        exit
> +        e_ilseq
>     ;
>  }
> )
>  ...
>  exit:
>  s
>  return result;
> +
> +e_ilseq:
> +result = -EILSEQ;
> +goto exit;
>
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci use_common_code_for_EILSEQ-4.cocci
> …
> minus: parse error:
>   File "use_common_code_for_EILSEQ-4.cocci", line 8, column 37, charpos = 162
>   around = 'result',
>   whole content =  ... when != if (...) { ... when any result = -EILSEQ; goto exit; }
>
>
> Unfortunately, it seems that I stumble once more on questionable software limitations.
>
> Regards,
> Markus
>
--8323329-804189328-1715525856=:6747--
