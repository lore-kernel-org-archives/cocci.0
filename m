Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE4FC47DD9
	for <cocci@archiver.kernel.org>; Sun, 25 Feb 2024 21:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SVRkydJtuBpVf1A0TfjIHje+4Ayv2MOcLfl+Mv5fGLc=;
  b=XJqGSt7aEAp4ogRtPYr9VxL+tEFKXQ8ehwTqN/pFqyoIhvPuw7WOzjPI
   M4lg8WFFs5LuAbHTNgG4bPBG4+0rVnnLGWRr4hh8vqbk7T5Z4eY/rsmkm
   Nbkh1ck/vk7zZvFXo43KFIzjTcfFSqZCgDzlrUp17GRCmwp69Uuf/t+uA
   o=;
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
X-IronPort-AV: E=Sophos;i="6.06,185,1705359600"; 
   d="scan'208";a="153689383"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2024 22:21:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E2C95E0CDA; Sun, 25 Feb 2024 22:21:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C13B2E008A
	for <cocci@sympa.inria.fr>; Sun, 25 Feb 2024 22:21:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SVRkydJtuBpVf1A0TfjIHje+4Ayv2MOcLfl+Mv5fGLc=;
  b=Vv7klEEseX6c3ZwD5VZ7n9boq/+qNnUz/DAjUjZSeq6ChHeSQ6iewXa4
   JLcQE5O+RGtYyzBwkAsZfVU3FN7POhGoCI+xr4R0O+yUsDktTWRhZ5fSG
   BejK3bGtLXTHY4SP1yn0X8+YoGle/vBbkJMeawsxOD9/dq6YK46QxkdNT
   Q=;
X-IronPort-AV: E=Sophos;i="6.06,185,1705359600"; 
   d="scan'208";a="153689377"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 22:21:22 +0100
Date: Sun, 25 Feb 2024 22:21:22 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <3d07b481-066e-49b1-96c0-e63391975ad8@web.de>
Message-ID: <alpine.DEB.2.22.394.2402252220350.3333@hadrien>
References: <814fc9f8-9ef1-42fc-ae9f-ef8d4a82979a@web.de> <8548519-fb2f-5860-bd86-3a4d20669c5c@inria.fr> <3d07b481-066e-49b1-96c0-e63391975ad8@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for code within block by SmPL ellipsis?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1605
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402252220350.3333%40hadrien>



On Sun, 25 Feb 2024, Markus Elfring wrote:

> > The fact that no * is detected does seem like a problem.
>
> Will variations of a source code search approach (like the following)
> including the usage of a combination of SmPL asterisk and ellipsis
> between curly brackets become supported?
>
> @display@
> @@
>  {
> * ...
>   ;
>  }

Thank you for the smaller example.

julia
