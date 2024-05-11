Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F33C04FFE
	for <cocci@archiver.kernel.org>; Sat, 11 May 2024 17:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/O6qhDOvgl3t6C7c1egEyUHIzDnfuhKFahxrCvbbowk=;
  b=bY6pF7ESqIAIqoSz63+c8Fs0pZQXIqQQueC8PSB/qhIeSpkKngAekcPy
   ZBoBCZ9rU2+MUYKBuCQtIpBOmGeUEaKiyCHR+iUX3AgeKiGSUzhI6pZhJ
   ynQrgg3aLio+EPIKOF4rrn7UtiAkfZfhiCys0CxNFJ44JHV6+t0qqbp9Q
   8=;
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
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="165202072"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2024 19:12:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2CEBFE0CCC; Sat, 11 May 2024 19:12:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 700F3E004E
	for <cocci@sympa.inria.fr>; Sat, 11 May 2024 19:12:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/O6qhDOvgl3t6C7c1egEyUHIzDnfuhKFahxrCvbbowk=;
  b=dE/ZnA404gdqhoED4ZmsFEXIQksPV/ABcudVzvUHtx4fN4ZRG+5x1QZj
   7psJIM/1F8VFdEPCPltjclmKBvj6Z0fFquYNs5LWwIOgKLbbriz1oAvUP
   e4d5FPBjAWk1OKtrc0RvSeNQ2mDq/rmpuEdj70e3IYHBDSI7R80vAvZCl
   A=;
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="86775817"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 19:12:44 +0200
Date: Sat, 11 May 2024 19:12:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <5b96b1f7-9bc3-41d3-b2fa-a377086702d0@web.de>
Message-ID: <alpine.DEB.2.22.394.2405111912230.14453@hadrien>
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de> <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr> <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de> <alpine.DEB.2.22.394.2405111803140.14453@hadrien> <3c953d7c-561d-4ba8-ae23-ffeb12840d02@web.de>
 <alpine.DEB.2.22.394.2405111836340.14453@hadrien> <5b96b1f7-9bc3-41d3-b2fa-a377086702d0@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-494468368-1715447563=:14453"
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1718
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405111912230.14453%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-494468368-1715447563=:14453
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 11 May 2024, Markus Elfring wrote:

> >> I would appreciate if undesirable duplication of search patterns can be avoided here.
> >
> > If you want to find code that occurs at least twice, isn't it most natural
> > to make a pattern that shows the thing occurring twice?
>
> Obviously, yes.
>
> Our development views seem to differ in the desire to express such
> a data processing task in a more succinct way also by the means of
> the semantic patch language.
>
> Which SmPL constructs can indicate a minimum occurrence number (≥ 2) accordingly?

There is no dedicated construct for that purpose.

julia
--8323329-494468368-1715447563=:14453--
