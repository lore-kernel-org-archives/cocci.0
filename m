Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E169CF9C5B
	for <cocci@archiver.kernel.org>; Sat, 21 Sep 2024 20:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=9mQmrBgrOF5XFiCIUt6AtbaH07aKo/zzW2aQp+CG9NU=;
  b=AJaP9n++UNGnXuz+iNDMJ1va7ChXQ0t+zGa8qazIvLbGZBJ/DSs7izq0
   Fw587+4RJnQ2+S2M/fvKBt8+wdT9sQD9NvCg2jVC+ehXZuP9/a4rVh6mf
   Hbrc1sZ/0ZjPx6y2Jqhwdmdq256dkHAa5TPlQEw/OI6eydOPwyhA7H7O0
   s=;
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
X-IronPort-AV: E=Sophos;i="6.10,247,1719871200"; 
   d="scan'208";a="184374271"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Sep 2024 22:10:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 58A2FE0133; Sat, 21 Sep 2024 22:10:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D3095E00B7
	for <cocci@sympa.inria.fr>; Sat, 21 Sep 2024 22:10:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9mQmrBgrOF5XFiCIUt6AtbaH07aKo/zzW2aQp+CG9NU=;
  b=NjTJt1egcYuPPx9tmKlMClT3wlhkBNIlIAqvdMveMcLTOBSJ4weA5wjc
   BcbTKYVOKpEEw4VrVsAap4PlC/AvRfhtcDBEgFwsU7q2MWZrLZeQUVWf3
   lDq/nEbdObQfw5RkshjP1vzBFli/PEL+OO+y+q9mCO+Yro7K6SCZxlZ57
   I=;
X-IronPort-AV: E=Sophos;i="6.10,247,1719871200"; 
   d="scan'208";a="184374270"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 22:10:39 +0200
Date: Sat, 21 Sep 2024 22:10:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de>
Message-ID: <alpine.DEB.2.22.394.2409212209470.3471@hadrien>
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-510740328-1726949412=:3471"
Content-ID: <alpine.DEB.2.22.394.2409212210140.3471@hadrien>
Subject: Re: [cocci] Determining a return code variable for a jump target
 (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1873
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/alpine.DEB.2.22.394.2409212209470.3471%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-510740328-1726949412=:3471
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2409212210141.3471@hadrien>



On Sat, 21 Sep 2024, Markus Elfring wrote:

> Hello,
>
> I constructed another tiny script variant for the semantic patch language.
> A corresponding test run generated data which contained some update candidates
> for further development considerations.
> Thus I constructed another small script variant for the semantic patch language.
>
> I would expect then that a patch can be generated with the software
> combination “Coccinelle 1.2-00038-g2297fc0f”.
> Unfortunately, this does not happen according to the attached two files.
>
> How can involved software components be improved?

Please put code on which you would like feedback inline in the message so
I can comment on it properly.


// See also:
// ath12k_pull_peer_assoc_conf_ev
//
https://elixir.bootlin.com/linux/v6.11/source/drivers/net/wireless/ath/ath12k/wmi.c#L5612
@adjustment2@
constant c;
expression e1, e2;
identifier rc2, x;
fresh identifier target = "free_" ## x;
@@
 int rc2;
 <+...
 if (...)
 {
 ... when != \( x = e1 \| e2(..., &x, ...) \)
-   kfree(x);
-   return
+   rc2 =
           -c;
+   goto target
    ;

You seem to expect that the source code contains two semicolons here.

julia


 }
 ...+>
+rc2 = 0;
+target:
 kfree(x);
 return
-       0
+       rc2
 ;




>
> Regards,
> Markus
>
--8323329-510740328-1726949412=:3471--
