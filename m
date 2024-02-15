Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AACC4829E
	for <cocci@archiver.kernel.org>; Thu, 15 Feb 2024 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=t65hmGwvvjTLIR6enc2BqP3zjPvYzIDy9lBnFEfrRgM=;
  b=pf5GX4Jq4Kyp9h3sMYcmLQtgGqWldU+zLYwBWlGNnZA93ggJWnmEoRZd
   +PeFnyj/lCT5CNF1klT2VgSq1GNMERP9w3aZJ11TrGbcZl89TauzwuRdL
   dDSlAf3V+IK1nQ/xtjt51zcDgoKixyvvPe35SZiYdeC9aQU5KWy13bZNo
   4=;
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
X-IronPort-AV: E=Sophos;i="6.06,161,1705359600"; 
   d="scan'208";a="152078002"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Feb 2024 10:29:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7A356E0CD5; Thu, 15 Feb 2024 10:29:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 12488E008A
	for <cocci@sympa.inria.fr>; Thu, 15 Feb 2024 10:29:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=t65hmGwvvjTLIR6enc2BqP3zjPvYzIDy9lBnFEfrRgM=;
  b=lyclbHAH/yffdPanT8HIoHzTOvVkdJk0VE7bOE70qkdNHPv7Tj5RFnNc
   Tp3PwE2vTCxW658dmD0qg2rsYQyLRy71Rq+UTa9p5XmXb3nC7sgJWhW6u
   AiSPeJAzxlrFOAmle3zhuRh6xSk8sfW3ntqPaJIphcNE3Di2oqAiCRsD1
   Q=;
X-IronPort-AV: E=Sophos;i="6.06,161,1705359600"; 
   d="scan'208";a="152077993"
Received: from wifi-eduroam-84-115.paris.inria.fr ([128.93.84.115])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 10:29:20 +0100
Date: Thu, 15 Feb 2024 10:29:19 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de>
Message-ID: <38d77d89-ffb7-d495-ff80-898861d46d32@inria.fr>
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de> <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de> <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1922106047-1707989360=:6747"
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1556
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/38d77d89-ffb7-d495-ff80-898861d46d32%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1922106047-1707989360=:6747
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 15 Feb 2024, Markus Elfring wrote:

> > I got into the mood to check also
> > how good the following SmPL script variants would work
>
> also together with the software combination “Coccinelle 1.1.1-00687-g0df3efff”.
>
>
> > @succinct_deletion@
> > binary operator bo;
> > constant c;
> > identifier var;
> > statement s;
> > @@
> > ( if (var bo c) return var;
> > & s
> > )
> >  ... when != var
> > - s
> >
> >
> >
> > Another test result:
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time spatch drivers/md/dm-vdo/slab-depot.c …/Projekte/Coccinelle/janitor/delete_redundant_if_statement3.cocci
> …
> real    0m17,970s
> user    0m17,754s
> sys     0m0,080s
>
>
>
> > @specific_deletion@
> > identifier var;
> > statement s;
> > @@
> > ( if (var != VDO_SUCCESS)
> >      return var;
> > & s
> > )
> >  ... when != var
> > - s
> >
> >
> > Another test result:
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time spatch drivers/md/dm-vdo/slab-depot.c …/Projekte/Coccinelle/janitor/delete_redundant_if_statement4.cocci
> …
> real    0m13,992s
> user    0m13,348s
> sys     0m0,071s
>
>
> Which recent commits did improve the software situation for this issue?

The one on which you keep asking me to add the link to your email message.

But I had the impression that it would have the effect of making both of
your tests slower...

julia
--8323329-1922106047-1707989360=:6747--
