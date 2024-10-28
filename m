Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A2BD1039A
	for <cocci@archiver.kernel.org>; Mon, 28 Oct 2024 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ibluXy/k0BRGXkixV/AVjgffcAphyk2W0AMvmL9+pDs=;
  b=bd7MWzEbwKreDARixkV7kD4lveRMFc/ufx+wM+SCljCL/ozLPAZsAEG2
   POd80HVcbLukweCOZO8aMwKTHjaGG6eHBoS0kJ9uz7zp/frMqX+Eu8ws0
   8aGEZezJuYbwS84ryv8tfQKwLZ+I9WGVyvGM26KmNITKRJbymfhdOJPA7
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.11,239,1725314400"; 
   d="scan'208";a="191055316"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Oct 2024 13:57:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3B74DE0D1D; Mon, 28 Oct 2024 13:57:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B3931E00B7
	for <cocci@sympa.inria.fr>; Mon, 28 Oct 2024 13:57:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ibluXy/k0BRGXkixV/AVjgffcAphyk2W0AMvmL9+pDs=;
  b=SyGurwrauHCvH+7t/lf254dJXCirhbYsjWI3p+eOg/wNlmbQ3FcsU+fa
   2iULLzsYAGrpO20eUJrcmZd0QJ/YNL9PwtjYftPxOuERhfhAYU0/RJAQO
   ceHE6PVkiYNoVDWVtqDzGEv/AAZ0fVX8O46pGux608bOgn/W58DknkusI
   E=;
X-IronPort-AV: E=Sophos;i="6.11,239,1725314400"; 
   d="scan'208";a="100203079"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 13:57:42 +0100
Date: Mon, 28 Oct 2024 13:57:42 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, "Derek M. Jones" <derek@knosof.co.uk>, 
    Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <656ad840-5a97-445d-8f70-5244402bc111@web.de>
Message-ID: <ef25c727-8bf5-41cd-ddc-7fe8e23ef51a@inria.fr>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk> <alpine.DEB.2.22.394.2410241646040.3352@hadrien> <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk> <alpine.DEB.2.22.394.2410241728210.3352@hadrien> <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien> <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk> <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk> <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de> <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de> <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de> <alpine.DEB.2.22.394.2410271429560.3498@hadrien> <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de> <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
 <4893c41d-bdaa-44b9-9381-d04bde2fedd8@web.de> <656ad840-5a97-445d-8f70-5244402bc111@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for macro calls besides function
 implementations (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1957
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/ef25c727-8bf5-41cd-ddc-7fe8e23ef51a%40inria.fr>



On Mon, 28 Oct 2024, Markus Elfring wrote:

> > The mentioned test output indicated a questionable function name generation.
> Will it ever become possible to find macro calls (between function implementations)
> which can construct further functions?
>
> A tiny source code search approach (like the following) does not produce desirable
> data processing results so far by the means of the semantic patch language
> (Coccinelle software).
>
>
> @display@

declarer name EARLY_PCI_OP;

> @@
> *EARLY_PCI_OP(...)

But maybe it won't work because thecode doesn't end with a semicolon.

julia

>
> See also:
> https://elixir.bootlin.com/linux/v6.12-rc4/source/arch/sh/drivers/pci/common.c#L33
>
> Regards,
> Markus
>
