Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C0CD58D6C
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=56Th1mywygRkyQSkeajIhrDlUB1G3q90mFReeNK3MZ0=;
  b=C79F6D53tKkvMQdPqXiX7ibX29iI2CWpV4e99ysMajR8BNov/6kHwytK
   i0KaemJmb8g9GlzYct+SXEPo8RbUeTTeoupKnKPm4bUb2zciWGNl6pb28
   BUKP2WJE8rS71AbvZ/rNqoEVPLNGXrL+B5NhFJ41Le7YXXYeduh0Ypkpz
   c=;
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
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195728436"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 18:16:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3DC3DE0D1D; Mon, 25 Nov 2024 18:16:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 78360E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 18:16:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=56Th1mywygRkyQSkeajIhrDlUB1G3q90mFReeNK3MZ0=;
  b=LSwp3uql5eh0NCzGBeSXrZz1UDfErPDBYxJ/vhxJURlZlkgUOzx8S9ga
   cI/j8APDH7HhMzcdWmROme8fq6mvX9V7rlDulvleyUZbCiY5aReI7aUBR
   SeHPxkk0vzIsHkARf6GASwcXdS80IoXMJs9uqbdtKO+O6hOVRYg4XDrIC
   M=;
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195728431"
Received: from unknown (HELO hadrien) ([137.54.125.254])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 18:16:44 +0100
Date: Mon, 25 Nov 2024 12:16:42 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ee6bacc9-eece-40b5-b86a-fa022532af9e@web.de>
Message-ID: <76e08376-fc21-cef6-ec3-6ccfb33ed6a1@inria.fr>
References: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de> <9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68@inria.fr> <100663c2-6281-49cb-bb9f-55656dff80ca@web.de> <d05cde6b-6189-4c2-a452-a0851430dcb@inria.fr> <ee6bacc9-eece-40b5-b86a-fa022532af9e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Data processing challenges for pointer expressions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2124
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/76e08376-fc21-cef6-ec3-6ccfb33ed6a1%40inria.fr>



On Mon, 25 Nov 2024, Markus Elfring wrote:

> >> * I would occasionally like to restrict the source code search to pointer expressions.
> >
> > expression *e;
> There are further data processing challenges to consider with the determination
> of involved pointer types, aren't there?

Could you please explain what you mean?

You can use options like --all-includes or --recursive-includes to get
more information from header files if it is needed to obtain the type
information.

But I have no idea what is a "data processing challenge".

julia
