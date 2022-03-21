Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676CAC433EF
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 06:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3Y/vlbBY0VEGz0wQM45s/OrhZqSmzlXiYc5FBR+xCiQ=;
  b=JaT8PN0w/hXhMm/9nsydChfbVIQLSa/WxfX2jesBsEV+eE6RnAcuHIy/
   S7ApcfMOjJWNMxw8niLa6x8aIsDUXFjv6F8aAQxvVT/lfJcGAZkXuLkfF
   i2JYE4R8lhDKsi28Kq6QU5OTq7HAQEeTBZd2X8fvzHFERyOc7uvYYIbbu
   g=;
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
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="27125552"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 07:05:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5556DE020F; Mon, 21 Mar 2022 07:05:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CF685E0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 07:05:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3Y/vlbBY0VEGz0wQM45s/OrhZqSmzlXiYc5FBR+xCiQ=;
  b=PF1fK3eEX4IC5QukDjMK2gFFcFc4I2EVUQKhItT8vxmyV6P/CZnRQDJ4
   lqsPAalZ+RoZ53GzNrPJg2z8qoZyN3nXaE70RyAdupsDapyj710wYzkS3
   Z45TkN6RHssD9bAzg10VV+orNTN9QzvVoW6vEdwqhRvhPjYeivK19K7KD
   0=;
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="9090190"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 07:05:30 +0100
Date: Mon, 21 Mar 2022 07:05:29 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <a28111b-90ab-1d57-58de-113a50f61f41@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203210703261.3210@hadrien>
References: <a28111b-90ab-1d57-58de-113a50f61f41@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Is there a stringify operator?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 270
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203210703261.3210%40hadrien>



On Sun, 20 Mar 2022, Eric Wheeler wrote:

> Hello,
>
> I keep running into situations where it would be nice to stringify an
> arbitrary metavariable.
>
> For example:
>
> 	@ r1 @
> 	type T;
> 	identifier I;
> 	@@
> 	T I;
>
> 	@ r2 @
> 	type r1.T;
> 	identifier r1.I;
> 	@@
> 	++printf(#I " has a datatype of " #T "\n");
>
> I used '#' as the stringify operator provided by macros.  This alternative
> format would work if I define a stringify macro (I think this works):
> 	#define STRINGIFY(a) #a
>
> and then:
> 	++printf("%s has a datatype of %s\n", STRINGIFY(I), STRINGIFY(T));
>
> Not sure of others would find a '#' operator or some other stringify
> functionality in Coccinelle useful...

You can do this with python.  See demos/pythontococci.cocci forthe general
idea.

julia
