Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF59CA1012
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=QymXvIVMfJQ7NTYIxZf+5uw521jLztUcsTXkx/mUuPw=;
  b=NrK0tGItS8PzvsWYeMxnKftGtE0vvf08OTR0MAj2Jw2tyZTaovqsZN3Q
   1oIMnm7kh10z1ExfSygUaXn99H22g9xiePQ1sAuuH8ZkozOiAxXUySnFg
   3A5EapiLKiiJFHx+CWABmzVsgpI5VKnufTVy7jmEyMN8aL8g/a4mx3pUA
   k=;
X-CSE-ConnectionGUID: TiRwhA1LS3y8f+R0xhympA==
X-CSE-MsgGUID: QyCgDTR9Q+SSOdd7GiV+6Q==
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
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="237807060"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 11:14:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 33266E0264; Sat,  6 Sep 2025 11:14:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6D344E0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 11:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QymXvIVMfJQ7NTYIxZf+5uw521jLztUcsTXkx/mUuPw=;
  b=qBwpF5Ro3PVTOAouQfZa7pxTpza06Vpvo4RmvP52m37WaQiBuVGjH94C
   YHV8AE3cQXxjQjnBpMNaBsEv2Bp0szN3HO1ImX0O5Q0Kq0DDC+4ilNEPR
   THL5YzUqOLZtT3AY1DfEMPxTvknmNyldZrIhrzMWEQq0cRLpHRn5hYaje
   o=;
X-CSE-ConnectionGUID: V2GTFez2QiCuMPrndLwYog==
X-CSE-MsgGUID: +0rTnXr1TvOr0gB3CscfMQ==
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="124817301"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 11:14:16 +0200
Date: Sat, 6 Sep 2025 11:14:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d28c6f76-6708-4dba-a446-910170e27572@web.de>
Message-ID: <b2e58328-97f3-4f1-e588-4647c6ff30d3@inria.fr>
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de> <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de> <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr> <b0221946-43a5-43c0-8573-32c12e149681@web.de> <ba87aeca-594d-10b6-960-cd4aa1fcd1e6@inria.fr>
 <d28c6f76-6708-4dba-a446-910170e27572@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3001
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/b2e58328-97f3-4f1-e588-4647c6ff30d3%40inria.fr>



On Sat, 6 Sep 2025, Markus Elfring wrote:

> >> Do I indicate a desirable extension for the Coccinelle software?
> >
> > No you asked for a feature, I said that that is already what happens.
> > So I don't know what you would see as an extension.
>
> Would you get further development ideas from an SmPL script variant
> like the following?
>
>
> @find1@
> expression e;
> position place;
> type t;
> t * pointer;
> @@
>  pointer = e(...);@place
>
> @display1@
> position find1.place;
> statement s;
> type find1.t;
> t * find1.pointer;
> @@
> *;@place
>  if (!pointer)
>     s
>  ... when != pointer
>
> @find2@
> expression e;
> position find1.place, place2;
> type t;
> t * pointer;
> @@
>  ;@place
>  ... when != pointer
>  pointer = e(...);@place2
>
> @display2@
> position find2.place2;
> statement s;
> type find2.t;
> t * find2.pointer;
> @@
> *;@place2
>  if (!pointer)
>     s
>  ... when != pointer

I don't get the point.  display2 should match a subset of the places
matched by display 1.

julia
