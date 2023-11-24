Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC379C61D97
	for <cocci@archiver.kernel.org>; Fri, 24 Nov 2023 08:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=fPcAIJqZVK+b/DPDVlraKVpgebLwxK9MOs9FT22YiE8=;
  b=c2X39RwRoHBRU3QEr54Z67gYDq/SLUIfk8BKhoyI30P00xkhQQX9R2/L
   Pa2fnSgIhOSEwM7uTqcfL5wXP0BSpqSD3klbNKA/QQiVJlFhbyAARwUfM
   GQMk59b9ZVWo9T38N4n+t9kfPPlaHfWFgF/QtZv4ZHXywZXOkkT+acxVl
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138264053"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2023 09:26:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9178EE0CCE; Fri, 24 Nov 2023 09:26:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 77965E004E
	for <cocci@sympa.inria.fr>; Fri, 24 Nov 2023 09:26:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=fPcAIJqZVK+b/DPDVlraKVpgebLwxK9MOs9FT22YiE8=;
  b=j/FXSgIm9VRnZffABr+P9VPU9sOSzy39cj2JNUQNylMBYz3417FEcNSf
   wfATdHwFj6+ERjDWvOH8ki9bM1hihLAfiFrdeaadR2pKGkbSe3lsklN3H
   W7JKfSJsGfCxuWNoctFtRHUBRI8KR/8JS7v+wcykK45jDK3N1ZwuFPXpk
   g=;
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="72446826"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 09:26:31 +0100
Date: Fri, 24 Nov 2023 09:26:29 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <05cc07d3-385d-48ea-9e4d-be32c3e863fa@web.de>
Message-ID: <14be81ed-ab8e-cd1-205e-db30745442d3@inria.fr>
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de> <alpine.DEB.2.22.394.2311240807170.3349@hadrien> <05cc07d3-385d-48ea-9e4d-be32c3e863fa@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-415116852-1700814277=:3364"
Content-ID: <8ed030c2-7dd8-e791-9668-7e42f64c4317@lip6.fr>
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1328
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/14be81ed-ab8e-cd1-205e-db30745442d3%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-415116852-1700814277=:3364
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <aa1f471f-7389-f260-db37-9473499ad6d7@lip6.fr>



On Fri, 24 Nov 2023, Markus Elfring wrote:

> >> Test result:
> >> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch display_position_information_for_one_return.cocci only_return_from_main.c
> >> …
> >> (<coccilib.elems.Location instance at 0x7f8fc4fcefa0>,)
> >
> > The type of a position variable in python is an array.
>
> It seems that the output from a call of the function “pprint” did not indicate this.
> https://docs.python.org/3/library/pprint.html#pprint.pprint

I have no idea.  You access the thing as p[0].line, p[1].line, etc.  I
don't know what type is involved.

>
> > In OCaml it is a list.
>
> Will any more clarifications become helpful for the involved data structures?
>
>
> > This is completely independent of the number of element involved.
>
> Will further case distinctions be taken into account?
>
>
> >> Why was a tuple constructed for a single source code place?
> >> https://docs.python.org/3/reference/datamodel.html#immutable-sequences
> >>
> >> Can a “Location” object be provided directly according to a metavariable type
> >> like “position”?
> >> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de44e5c21b60d41938d32321b1a/python/coccilib/elems.py
> >
> > I don't understand the question.  I guess that a position variable is
> > mapped to an array of locations.
>
> This view can be reasonable.
>
>
> > So if you want a location, you would take the first element of the array.
>
> How do you think about the possibility to avoid such data processing?
>
> May it be expected that only a single source code place will be passed to
> the shown script rule?

No.  When you use ... by default it considers all paths.  Therefore in

a();
...
b@p();

multiple positions can be matched.  It doesn't make any sense to have a
special case for the case where there happens to be only one.

julia

>
> Regards,
> Markus
>
--8323329-415116852-1700814277=:3364--
