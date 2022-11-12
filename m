Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55349C4332F
	for <cocci@archiver.kernel.org>; Sat, 12 Nov 2022 11:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ESQfin/k0CmD4SKRFdPzK9ckROM2CtM0EH7rLB0u/mY=;
  b=PYSr6KPatgl5gYD0c9GOpoNC53Mtsy7RLyQgnZnQyMZto8f25h3qLZom
   rohy1/3y7gH8YbmGuRq7CcOQOSXR8PYDtAKY3ahnd8qdXWG7MKlszkKUa
   GqsTAXgvk0jFnqLK/anOLUfd8ecmg+NXaGEJp2gMbFJaEYGj0G8sUNpW5
   A=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.96,159,1665439200"; 
   d="scan'208";a="77856971"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2022 12:17:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CF7FAE0241; Sat, 12 Nov 2022 12:17:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 46756E0092
	for <cocci@sympa.inria.fr>; Sat, 12 Nov 2022 12:17:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ESQfin/k0CmD4SKRFdPzK9ckROM2CtM0EH7rLB0u/mY=;
  b=XAdimpyqCUEZu/CYES6tFVIo8evdPooIF08w1NKPY+fHVT8a8ioGLZHf
   Sie+gWtns0J7qG924QJTC0wIANfVz+14OZIIOqqLapZ+/XMDyg3tMtF8O
   /812MTl8ObndiqbkMNGZ9WPIrz619T1fWzAc7cV74pKE0aJ1v0mLUiPMG
   c=;
X-IronPort-AV: E=Sophos;i="5.96,159,1665439200"; 
   d="scan'208";a="39562398"
Received: from unknown (HELO hadrien) ([129.126.215.52])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 12:17:54 +0100
Date: Sat, 12 Nov 2022 19:17:52 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Elia Pinto <gitter.spiros@gmail.com>
In-Reply-To: <1282431d-b379-0ddf-5dbd-a50cb5d1605d@web.de>
Message-ID: <17a6959f-993f-3342-dc79-ad684e4ac67b@inria.fr>
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com> <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de> <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de> <1282431d-b379-0ddf-5dbd-a50cb5d1605d@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-82440265-1668251874=:3600"
Subject: Re: [cocci] Fixing the adjustment of variable declarations
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 737
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/17a6959f-993f-3342-dc79-ad684e4ac67b%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-82440265-1668251874=:3600
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 12 Nov 2022, Markus Elfring wrote:

>
> > Would you like to clarify a related bug report for the software combination “Coccinelle 1.1.1”?
>
> Can another variant make sense for a transformation specification
> if you would like to increase the change precision?
>
> @moving2 disable decl_init@
> type t;
> identifier x, y;
> @@
>  t
> -x,
>  * y;
> +t
>  x = 'x';

Have you actually tried this?  Because multiple declarations, ie of both x
and y, are not supported in SmPL.  Please actually try suggestions before
posting them.

julia

>
>
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> spatch --parse-cocci move_a_variable_declaration2-20221112.cocci
> …
> minus: parse error:
>   File "move_a_variable_declaration2-20221112.cocci", line 7, column 1, charpos = 64
>   around = '*',
>   whole content =  * y;
>
>
> How will the handling of declarators evolve further?
> https://en.cppreference.com/w/c/language/declarations
>
> Regards,
> Markus
>
--8323329-82440265-1668251874=:3600--
