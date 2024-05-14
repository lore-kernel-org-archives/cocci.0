Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4589AC25B75
	for <cocci@archiver.kernel.org>; Tue, 14 May 2024 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Nqzt/CkX/oFXnayHB01OiK6AYIpjO3WLhuUibYcz5rY=;
  b=obY/7YDFh5B6D6yknB3O2XBD1ZiTohvgr/lDYWzRPks6JqiEccRST2nS
   McvloxwkIR1qEoBof7fcoDfhUKeY2b+kFPo30T3HvRyvY0NaO9ZHXcho7
   XY9A22Y9oggkitVQGvyT8tM8OR8ueYyS3ApT8NFI+/QlW4UllUVDbG7Fz
   M=;
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
X-IronPort-AV: E=Sophos;i="6.08,159,1712613600"; 
   d="scan'208";a="165613013"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 May 2024 11:32:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9FC82E0AF1; Tue, 14 May 2024 11:32:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 61C72E004E
	for <cocci@sympa.inria.fr>; Tue, 14 May 2024 11:32:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nqzt/CkX/oFXnayHB01OiK6AYIpjO3WLhuUibYcz5rY=;
  b=AvUim8bdovVmB1jSfhF0+MaQnlHJWrsSkE8Tq6QBEuBj0MSOL0l7F4g4
   6d8bUgDBgWrWWMO6p5FIUxImE3vx7nv2QvdWkAoLneJ8/sRVFC2OmNemA
   N1F6F96J8j8RnavQVWH4oRlz4GmpfUO8y1WIthB7MF603c1nTHJ5qeTUw
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,159,1712613600"; 
   d="scan'208";a="165612991"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:32:24 +0200
Date: Tue, 14 May 2024 11:32:24 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <48e0b9a3-dfa0-4e39-b049-93faa76c0735@web.de>
Message-ID: <d65aaff8-48a0-c670-fc16-abc97415a99@inria.fr>
References: <48e0b9a3-dfa0-4e39-b049-93faa76c0735@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Checking CTL code?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1738
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/d65aaff8-48a0-c670-fc16-abc97415a99%40inria.fr>



On Tue, 14 May 2024, Markus Elfring wrote:

> Hello,
>
> The Coccinelle software supports a computation tree logic variant.
> Can CTL code be directly passed to a corresponding tool for further analyses
> and system tests?

Not sure what you are asking.  You can print the CTL code with
--verbose-ctl-option.  There might be a way to get it printed in latex as
well.

On the other hand, you can also hand write CTL formulas and pass them to
Coccinelle.  I think that can be done in some way with the --test options.

julia


>
> Regards,
> Markus
>
