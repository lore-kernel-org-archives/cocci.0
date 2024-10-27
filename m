Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61549D13572
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=hbIJmxNCUT7heOOy9UcTxMdU6VWLBWz7YTijNOJyEvE=;
  b=lPD3cOs87/Wcj9l3r6zncJXjc2wFBhxBi7BwTII6vnLFm6BDCwNX0FO/
   BCdahvie84xJ0KAY9qJzKXZAAvYpHPiON/rZrCNLcn9kiZZ9VgDNCMXDv
   i/0695vCMIPwRDUHI616t+WJoj9i745AkJk2hdGtE69C1BFFpAZXBafvE
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
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190929627"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 18:06:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B12EAE00B7; Sun, 27 Oct 2024 18:06:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BC9F7E00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 18:05:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hbIJmxNCUT7heOOy9UcTxMdU6VWLBWz7YTijNOJyEvE=;
  b=B5JkNDuxTSqCpycpAGTqwLG9C2D08Q1lfECpSKMmwlCeMWk5E6TGBobD
   +vk2vyiP0n9s7oN92QbLaWrUsnUUd6HrmlPO9+Jmqy796SGDE65RepPrx
   StlN+wAXQAo8CU5yb7kqneP672AQ+DVrwnPzfZs7qXDdlkU1qzWIf1BxD
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190929623"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 18:05:58 +0100
Date: Sun, 27 Oct 2024 18:05:57 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, "Derek M. Jones" <derek@knosof.co.uk>, 
    Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de>
Message-ID: <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk> <alpine.DEB.2.22.394.2410241646040.3352@hadrien> <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk> <alpine.DEB.2.22.394.2410241728210.3352@hadrien> <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien> <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk> <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk> <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de> <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de> <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de> <alpine.DEB.2.22.394.2410271429560.3498@hadrien> <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-753027268-1730048757=:3498"
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1947
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/alpine.DEB.2.22.394.2410271803580.3498%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-753027268-1730048757=:3498
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 27 Oct 2024, Markus Elfring wrote:

> …
> > If you could make a semantic patch that doesn't involve 30-some lines of
> > python code and would provide a minimal test case, then I could try to
> > understand if you are concerned about the same issue.
> Can you find another example helpful for achieving a better understanding?
>
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> spatch …/Projekte/Coccinelle/janitor/list_curly_bracket_positions_for_function_implementations4.cocci arch/sh/drivers/pci/common.c
> …
> -> duplicate data
> file:
> arch/sh/drivers/pci/common.c
> function:
> early_read_config_dword
> line:
> 36
> …
>
>
> https://elixir.bootlin.com/linux/v6.12-rc4/source/arch/sh/drivers/pci/common.c#L33 :
> …
> #define EARLY_PCI_OP(rw, size, type)					\
> int __init early_##rw##_config_##size(struct pci_channel *hose,		\
> 	int top_bus, int bus, int devfn, int offset, type value)	\
> {									\
> 	return pci_##rw##_config_##size(				\
> 		fake_pci_dev(hose, top_bus, bus, devfn),		\
> 		offset, value);						\
> }
>
> EARLY_PCI_OP(read, byte, u8 *)
> EARLY_PCI_OP(read, word, u16 *)
> EARLY_PCI_OP(read, dword, u32 *)
> EARLY_PCI_OP(write, byte, u8)
> EARLY_PCI_OP(write, word, u16)
> EARLY_PCI_OP(write, dword, u32)
> …

OK, that was much more understandable.  In general, we don't make a great
effort to give reasonable results for macro definitions.  I don't even
know what result is wanted?  The starting position of each EARLY and th
ending position of each )?  I guess the problem is that EARLY_PCI_OP is
not recognized as a declarer name, and so a parse error is found, causing
the macro to be expanded.

julia
--8323329-753027268-1730048757=:3498--
