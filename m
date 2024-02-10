Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AB6C48260
	for <cocci@archiver.kernel.org>; Sat, 10 Feb 2024 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=wtdMfQeQTnqYcJ8zFWxA/wNzy2KJWk9zK03j8bTN0JQ=;
  b=OGQJdNcTPL177amAzc0IFZbDlsWHorQ8EaeSlrUgtSHQEeWpgz7WLhg6
   5jXzn1rQan2DlSrP8y5XnCXQ7tBuDOZiJpGWjsujpR+d0FLDIL3dz4VMT
   iH5Eekd/sQvfAQt9K0N1M5PGbQs3vzQNJ+/be0VnQBNo3viyjikouMiEF
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
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="151304188"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2024 11:25:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 035B0E0CD5; Sat, 10 Feb 2024 11:25:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 98E7EE008A
	for <cocci@sympa.inria.fr>; Sat, 10 Feb 2024 11:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wtdMfQeQTnqYcJ8zFWxA/wNzy2KJWk9zK03j8bTN0JQ=;
  b=szO9+4lvXZRA0G+YtZ/9BgNhqKiZzarX3ic4lcYu02ghysS+M86qBIjV
   3wjbT4leijuVlb33aFeFzZU3t/VEvhbr1qL2SCFTA6Y/L6peUmPtM/HOz
   6NgvkY2zNh1JYjitMwOP6EZ0VKJFh9nVG/1zNhpbzpjfaGX7LVkQsIzq3
   o=;
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="79277191"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 11:25:02 +0100
Date: Sat, 10 Feb 2024 11:25:01 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <1c2bfc73-cf2e-4949-bf60-6fc432ef67a8@web.de>
Message-ID: <alpine.DEB.2.22.394.2402101124030.53569@hadrien>
References: <d4abffb5-6221-4109-9316-acb5c3720c31@web.de> <alpine.DEB.2.22.394.2402100936350.53569@hadrien> <1c2bfc73-cf2e-4949-bf60-6fc432ef67a8@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Extending handling of position information for SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1535
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402101124030.53569%40hadrien>



On Sat, 10 Feb 2024, Markus Elfring wrote:

> > I can never really understand what you are asking for.
>
> I find such communication difficulties interesting somehow.
>
>
> > Please include a concrete example.
>
> Can the presented idea be clarified also without extra SmPL code
> (at the moment)?

No.  If you want some feature, a bare minimum is that you can illustrate
some use case for it.

>
>
> > A priori, I don't see any need for changing the way in
> > which matching of metavariables is expressed.
>
> An improved software documentation can probably help also
> with a better understanding.
>
> * Do we distinguish anyhow if a (position) metavariable was initialised
>   by a script?

No.

>
> * May further uses be considered (besides variable inheritance) in SmPL code?

No idea what this means.

>
> * Can a position metavariable be reused in the same SmPL rule?

Yes.

julia

>
>
> Regards,
> Markus
>
