Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1E8C4829B
	for <cocci@archiver.kernel.org>; Sun, 11 Feb 2024 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Qllbl9vIJL6fOX6JeDAHiUEngploYNeVkoHtMpoy4mg=;
  b=Spbbl3OL+US1CIMA16UIB4HPZF9iNtPgGk5qnJYPIeQjdvz0Kstot8gx
   M6FMdRTfCLSKdRwwEmDrTWDKKDKGyN6e8ZMgeTrPMBx//vnWsPwYrbC98
   xic4ybphk5+B7bFFQC46BwotPArP6U3Dd3/ff7WOigVmEyKwSDhkc7MIf
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
X-IronPort-AV: E=Sophos;i="6.05,260,1701126000"; 
   d="scan'208";a="151348068"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2024 09:42:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 07F0BE0CD6; Sun, 11 Feb 2024 09:42:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 444EBE008A
	for <cocci@sympa.inria.fr>; Sun, 11 Feb 2024 09:42:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Qllbl9vIJL6fOX6JeDAHiUEngploYNeVkoHtMpoy4mg=;
  b=NvuXkQsxec+k+A2KIrD/HcnI8BOzRz4fMyVjKkx0SjO/hxnT6Vsr1YWS
   rEGEZj5alz8oGxXT90TIh8hjJb54754yWmHNZcBiToQTc++qJbtQ92HDW
   2V/hvgN3cE0NRKCOmoUiLrMyckpMsWmwA9j3VRV/0eOaJ0I/uxPdaDo/8
   E=;
X-IronPort-AV: E=Sophos;i="6.05,260,1701126000"; 
   d="scan'208";a="151348065"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 09:42:08 +0100
Date: Sun, 11 Feb 2024 09:42:07 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
Message-ID: <alpine.DEB.2.22.394.2402110938330.53569@hadrien>
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de> <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-949066252-1707640928=:53569"
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1542
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402110938330.53569%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-949066252-1707640928=:53569
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 11 Feb 2024, Markus Elfring wrote:

> > @deletion@
> > binary operator bo;
> > constant c;
> > expression e;
> > identifier var;
> > @@
> >  if (
> > (    var bo c
> > &    e
> > )
> >  )
> >     return var;
> >  ... when != var
> > -if (e)
> > -   return var;
>
> This script example for the semantic patch language contains a bit of
> duplicate SmPL code.
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time spatch drivers/md/dm-vdo/slab-depot.c …/Projekte/Coccinelle/janitor/delete_redundant_if_statement.cocci
> …
> real    0m1,046s
> user    0m0,969s
> sys     0m0,055s
>
>
>
> I got into the mood to check also
> how good the following SmPL script variants would work.
>
> @succinct_deletion@
> binary operator bo;
> constant c;
> identifier var;
> statement s;
> @@
> ( if (var bo c) return var;
> & s
> )
>  ... when != var
> - s
>
>
>
> Another test result:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time spatch --timeout 123 drivers/md/dm-vdo/slab-depot.c …/Projekte/Coccinelle/janitor/delete_redundant_if_statement3.cocci
> …
> timeout (we abort)
> Fatal error: exception Coccinelle_modules.Common.Timeout
>
> real    2m5,419s
> user    2m2,733s
> sys     0m0,719s
>
>
>
> @specific_deletion@
> identifier var;
> statement s;
> @@
> ( if (var != VDO_SUCCESS)
>      return var;
> & s
> )
>  ... when != var
> - s
>
>
> Another test result:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time spatch --timeout 123 drivers/md/dm-vdo/slab-depot.c …/Projekte/Coccinelle/janitor/delete_redundant_if_statement4.cocci
> …
> timeout (we abort)
> Fatal error: exception Coccinelle_modules.Common.Timeout
>
> real    2m5,305s
> user    2m3,025s
> sys     0m0,547s
>
>
>
> Will such data achieve any software improvements?

Since you haven't provided any test data and since the file that you
reference is not part of Linux 6.8-rc3, I'm not going to look into this.

First, please use --debug --verbose-ctl-engine and see if you can figure
out the answer yourself from the output.

If you can't figure out the answer and you want to pursue this, please
send back one email that includes both the esmntic patch above and a
single function that illustrates the problem.

julia
--8323329-949066252-1707640928=:53569--
