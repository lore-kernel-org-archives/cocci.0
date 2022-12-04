Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3523FC4332F
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cMoDRNen1HP0Z8txg4zcZD7ieWH0C4fC8Wudg9DQ+TU=;
  b=l30kSuB3Olm+pm1rrNJlgIBlKOQu2h1hNR3MawfzCfAwGkv9gXj4GSQf
   wF0FumbxokfFH+R4PTJAPhAjTLDO0RrzpruKlBXOTY8091H7b+/pXuuce
   iuDHSDB95uRMRyLMlIU8vHOHIsizuZWU3mYm1sYsH4GJ73M8vLefJUelk
   U=;
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
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81593356"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 14:26:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1DF24E01D1; Sun,  4 Dec 2022 14:26:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BA116E013A
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 14:26:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cMoDRNen1HP0Z8txg4zcZD7ieWH0C4fC8Wudg9DQ+TU=;
  b=GX9YXHx9UZ4WysplTqbX96IDcZgDw/2d0f2bOBTHPblIX/cxX2SEjOgM
   UEBIsSEBwbJYuU8C3pllj/k/joVtrIl8QxgK21nk55B+Px6gh6UEglQv6
   tmHD03YfJSZMY82y4OcPllDrsNR5MltZ3lIMLqHSLDTezIeJQJzdTYNCt
   E=;
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="41669364"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 14:26:51 +0100
Date: Sun, 4 Dec 2022 14:26:50 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Derek M Jones <derek@knosof.co.uk>
cc: cocci@inria.fr
In-Reply-To: <e9d8231c-9b98-6603-4786-7b61809af4d0@knosof.co.uk>
Message-ID: <alpine.DEB.2.22.394.2212041426120.3337@hadrien>
References: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk> <alpine.DEB.2.22.394.2212040832050.3337@hadrien> <e9d8231c-9b98-6603-4786-7b61809af4d0@knosof.co.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for ++ of volatile variables
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 763
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/alpine.DEB.2.22.394.2212041426120.3337%40hadrien>



On Sun, 4 Dec 2022, Derek M Jones wrote:

> Julia,
>
> > For the assignment operators, you should use:
> >
> > assignment operator b = {+=,-=,&=};
>
> Thanks.
>
> > But the much simpler and efficient solution is just to declare the
> > metavariable with the type you want, ie
> >
> > volatile int V_1;
>
> Good idea, that works.
>
> I was hoping for a solution that did not require me
> to enumerate all the different volatile types in separate
> rules (to handle the different names in the Python script).

Maybe

type t;
volatile t V_1;

Not sure if it works.

julia
