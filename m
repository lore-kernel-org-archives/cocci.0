Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650F9C3ABD8
	for <cocci@archiver.kernel.org>; Sun, 18 May 2025 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RZNHJCjJAzwMY5DE2z9vuJbFZdb74DUPC0zHiVdN4fc=;
  b=orUfhpNGdIYXkRo4yCZkDmlZm44d32rcF4eVxWS+ZAPYeHlL44/e6Li+
   8gBC0FIrCMWc7WD9EnNuW+WtJmPpBCLNFbRITuVD+TjOADWImPV4IVxrU
   T26HjqaYAqNNXYL38qZn3jIzzYcz/otY9f+K3FPa1I/NjtVpN4Qxnxv8u
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.15,298,1739833200"; 
   d="scan'208";a="222595418"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 May 2025 10:56:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7664DE0AF6; Sun, 18 May 2025 10:56:16 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 30CA1E0131
	for <cocci@sympa.inria.fr>; Sun, 18 May 2025 10:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RZNHJCjJAzwMY5DE2z9vuJbFZdb74DUPC0zHiVdN4fc=;
  b=WG5tuwYs1ciJmWhCxsYZGoM1tu5/NNAT/TsNRT3Kpt/P72R9AUCIaq+G
   XW/A97Scf5F6ssucwxKXaNAezeZLccZb3Ct4bFgyJyJeFalGRhdwWG5OX
   pZgsvhBRdHSQtGxPCUDlLg7GP63OWTJFqgwzcGiWuTnZInXwtBVfQ5/ip
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,298,1739833200"; 
   d="scan'208";a="116863324"
Received: from cpe.ge-5-3-4-100.oebrnqe12.dk.customer.tdc.net (HELO hadrien) ([193.89.189.106])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 10:56:15 +0200
Date: Sun, 18 May 2025 10:56:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Olaf Hering <olaf@aepfle.de>
In-Reply-To: <55052f14-dbe4-467c-a7a4-41ce5fc1cc99@web.de>
Message-ID: <d2ccd1ea-8ee-a190-8b32-cc81becc88eb@inria.fr>
References: <55052f14-dbe4-467c-a7a4-41ce5fc1cc99@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-819081161-1747558574=:3283"
Subject: Re: [cocci] Reconsider software dependencies for PCRE support (with
 SmPL)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2738
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/d2ccd1ea-8ee-a190-8b32-cc81becc88eb%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-819081161-1747558574=:3283
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 18 May 2025, Markus Elfring wrote:

> Hello,
>
> I got into the mood to try another script variant out (like the following) for
> the semantic patch language.
>
>
> // See also:
> // update candidate: c4iw_rdev_open()
> // https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/infiniband/hw/cxgb4/device.c#L908-L909
> @Delete_unnecessary_checks@
> expression x;
> @@
>  if (...
> -    && x
>     )
>     kfree(x);
>
>
> Such SmPL code does not use features according to regular expressions.
> But I observed the following test result with the software combination
> “Coccinelle 1.3-00083-g4093aad2d” on my openSUSE Tumbleweed system.
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci delete_unnecessary_checks7.cocci
> spatch: error while loading shared libraries: libpcre.so.1: cannot open shared object file: No such file or directory
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --version
> spatch: error while loading shared libraries: libpcre.so.1: cannot open shared object file: No such file or directory
>
>
> Under which circumstances can the corresponding software dependencies become
> up-to-date again?

We will look into it.  Thanks for the report.

julia
--8323329-819081161-1747558574=:3283--
