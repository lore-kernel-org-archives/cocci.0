Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB3DC433FE
	for <cocci@archiver.kernel.org>; Thu, 20 Oct 2022 05:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ChvVggEjZAGmZdww55h7L/CIwQ302wkB6/9mfy2/Kxk=;
  b=rCgKZ617JJ1l2Ht42ZGR2FYcpIHKLEUCZjpTjAROdD9VIkGkp6VBNcHE
   9pN56i+9XUFGSq5O70er6EAxUcEueb1kMsGR1QYpHKG+b5Y9U+1Xci3qQ
   w3XBt9Gp8e4ss8d84UMZyom50iDK7BpZEQX7ynzEeIZJikAo34V6WoUNg
   s=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="66068952"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2022 07:11:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 11056E01D1; Thu, 20 Oct 2022 07:11:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8319DE004E
	for <cocci@sympa.inria.fr>; Thu, 20 Oct 2022 07:11:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ChvVggEjZAGmZdww55h7L/CIwQ302wkB6/9mfy2/Kxk=;
  b=gdW5yUuCh2wOan3iTRV4vqzH+smuKfYsc16+py4DabCjGsOP3iyhdJ68
   +W50TFCodEgbsQY7U2y0VBn5adMJhZWWAbTxxFJAcChp4FgecDtDQ9Gkf
   0JjTvWj7Q+4DUsWuZBMka70zHzXRacNI8iaziC5i594ghD4IZYKY3uTkI
   A=;
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="31919002"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 07:11:23 +0200
Date: Thu, 20 Oct 2022 07:11:22 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
cc: cocci@inria.fr
In-Reply-To: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] "not supported"
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 657
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210200705030.2988%40hadrien>



On Wed, 19 Oct 2022, Jason A. Donenfeld wrote:

> Hi,
>
> I'm trying to generically replace constructions that look like this:
>
> @@
> expression E;
> type T;
> identifier I;
> @@
>   {
> -   T I;
> -   do {
> -     I = get_random_u32();
> -   } while (I > E);
> -   return I;
> +   return get_random_u32_below(E + 1);
>   }
>
> But trying to run it results in "not supported". Any idea what's up?

Maybe you have an old version of Coccinelle?  For a long time do while was
not supported.  But it's supported now, and your rule seemed to work fine
for me.

>
> Also, it'd be nice if there was a way for Coccinelle to figure out
> variants of that, such as I >= E in a succinct way, and maybe other
> different loop constructions that amount to the same thing.
>
> Is there any way to express what I'm after?

The only way Coccinelle figures out variants is with its isomorphisms, and
allowing I > E to match I >= E seems strange as a general rule.  There are
the following isomoprhisms:

Expression
@ gtr_lss @
expression X, Y;
@@
X < Y <=> Y > X

Expression
@ gtr_lss_eq @
expression X, Y;
@@
X <= Y <=> Y >= X

You may want to at least consider putting a ... when != I just under
the T I.

You may want to write a rule like:

do { ...
*  I = get_random_u32();
  ...
} while (...);

To see what the possible options are.

julia
