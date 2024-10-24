Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4246CE8E90
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+M/xPkF8uC9NP7VOL8Sw+3uYy4vBT9CT2caw1h09LXA=;
  b=hriV/oj6xyd/6sfKx1Ur6njofDhC3WVsEntdWh5YsXEgHKw2K5lvZVoW
   V4FYY97Tlvl6LXCeQg/nb/kdKbwWyQ+6NMu8SUPYguNzag8Y+kLw2mbBK
   +kaZA7sQvwisr3Xqh5AK19oSccayjjTKGsXW8eWuU5DnQW5pz3E6qRYb2
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190600992"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 18:00:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3B2D7E0D1E; Thu, 24 Oct 2024 18:00:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 555CFE0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 18:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+M/xPkF8uC9NP7VOL8Sw+3uYy4vBT9CT2caw1h09LXA=;
  b=KcVWUECNUp7Om0/Vwn1DnlrMYIuQBjMx+L6domKL/tcKXlsInvVAqoZr
   s5pHqJdpG4IvUCC74xldp8lLRXgioIEVcr5YYGQdESdjUXv2og1KgYY4b
   MF9h3IxdiUMWKIf0nSHjuH62b34wg65MyHajouwVLxvFN1UCex4qWryu5
   o=;
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190600986"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 18:00:26 +0200
Date: Thu, 24 Oct 2024 18:00:26 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Victor Gambier <victor.gambier@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <817cc00b-cc68-4346-b894-3dd728a9e05a@inria.fr>
Message-ID: <alpine.DEB.2.22.394.2410241759500.3352@hadrien>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk> <alpine.DEB.2.22.394.2410241646040.3352@hadrien> <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk> <alpine.DEB.2.22.394.2410241728210.3352@hadrien> <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien> <817cc00b-cc68-4346-b894-3dd728a9e05a@inria.fr>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1759388173-1729785626=:3352"
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1927
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/alpine.DEB.2.22.394.2410241759500.3352%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1759388173-1729785626=:3352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 24 Oct 2024, Victor Gambier wrote:

> > Not in itself.  In my solution you only need one position variable, which
> > is the one on the top {
> >
> > Every position variable contains complete information about the enclosing
> > object.
> >
> > julia
>
> Presumably something along the lines of:
>
> $ cat temp.c
>
> int g;
>
> void f1(int a)
> {
> a++;
> }
>
>
> void f2(int a)
> {
> a++;
> if (g)
>    {
>    a++;
>    return;
>    }
> }
>
> $ cat temp.cocci
> @ func_def
> @
> identifier f;
> parameter list parms;
> position p_1;
> @@
> f(parms)
> {@p_1
> ...
> }
> @
>
> script:python @ func << func_def.f;
>                 parm_n << func_def.parms;
>                 loc_1 << func_def.p_1;
>               @@
>
> import sys
> def printf(format, *args):
>     sys.stdout.write(format % args)
>
> printf("%s,func", loc_1[0].file)
> printf(",%s", func)
> printf(",\"%s\"", parm_n)
> printf(",%s,%s", loc_1[0].current_element_line,
> loc_1[0].current_element_column)
> printf(",%s,%s\n", loc_1[0].current_element_line_end,
> loc_1[0].current_element_column_end)

That's the idea.  Thanks for making ti more concrete.

Perhaps that is worth an example in the demos directory.

julia

>
> >
> >
> > > --
> > > Derek M. Jones           Evidence-based software engineering
> > > blog:https://shape-of-code.com
> > >
> > >
>
--8323329-1759388173-1729785626=:3352--
