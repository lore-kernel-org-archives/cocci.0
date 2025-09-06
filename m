Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40B6CA1002
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xdeadZjTeEvfzRLGiI4I6XkCxsYUeUKqc2c6Vb34RYk=;
  b=eqatYvhv4jJvXObbkqe3CIjxg/9N1rhZocekRdQCuIc/TS8FCj1SUIfa
   /ENG9IBTdbEkoJ+hxNQ432K6tVSBSJId7M8EgVccMRvyOTUBnjBHo+KRY
   da21pEunwrKMbjw874SU5O61o5xZQkRWkQRxZqCdsOycKc99Ip02Jh709
   I=;
X-CSE-ConnectionGUID: qLW9wsqATYCu7NjaCmvKXw==
X-CSE-MsgGUID: WQC8CpDDS1eVsWSdos1OHw==
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
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="237813639"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 14:13:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6CE8FE0264; Sat,  6 Sep 2025 14:13:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A4F04E0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 14:13:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xdeadZjTeEvfzRLGiI4I6XkCxsYUeUKqc2c6Vb34RYk=;
  b=oqYDrHb2LzG5Jj+Num1PrdgLzzHmNEp2bM/NXvThfyPdKIG8az+2/tlg
   Te94Fh76M3bV8FJMgsZhslXiO4WVAN03TrobTAgM1dBkbJX+EZCZZjYZS
   ctYlcrmyGlIiL7dtLT2t99bJHt42gwySOPC4Yiyff+5hkudnDLpEmhvA8
   c=;
X-CSE-ConnectionGUID: hjnrDN9lSSyPN8ZvMo86nA==
X-CSE-MsgGUID: eGouU0LxQ9+yDigupJf2nA==
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="237813638"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 14:13:46 +0200
Date: Sat, 6 Sep 2025 14:13:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <469a978c-5b6f-4cfd-99c6-69671de653ad@web.de>
Message-ID: <e630c74d-c125-9d12-6bf8-59d1f5bbaafe@inria.fr>
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de> <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de> <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr> <b0221946-43a5-43c0-8573-32c12e149681@web.de> <ba87aeca-594d-10b6-960-cd4aa1fcd1e6@inria.fr>
 <d28c6f76-6708-4dba-a446-910170e27572@web.de> <b2e58328-97f3-4f1-e588-4647c6ff30d3@inria.fr> <13ed7845-6fd9-4a8e-9670-3d2b7e7a0f4e@web.de> <ce7a7254-bbb3-4666-8a57-2e6cccaa51fc@web.de> <4959806f-e03e-9a59-63eb-f71b6bf6f954@inria.fr>
 <469a978c-5b6f-4cfd-99c6-69671de653ad@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1227487145-1757160825=:4008"
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3006
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/e630c74d-c125-9d12-6bf8-59d1f5bbaafe%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1227487145-1757160825=:4008
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 6 Sep 2025, Markus Elfring wrote:

> >> @find@
> >> expression e;
> >> position place;
> >> type t;
> >> t * pointer;
> >> @@
> >>  pointer = e(...);@place
> >>
> >> @display@
> >> position find.place;
> >> statement s;
> >> type find.t;
> >> t * find.pointer;
> >> @@
> >> *;@place

This line certainly doesn't work.  It is searching for an empty statement
at a place where there is an assignment statement.

julia

> >>  if (!pointer)
> >>     s
> >>  ... when != pointer
> >
> > how about:
> >
> > pointer = e(...);
> > if (!pointer) s
> > ... when != pointer
> > ? pointer = ...;
>
> Do you support to split the search approach into multiple SmPL rules
> also with the application of additional position variables?
>
> The following SmPL script variant seems to work as expected.
>
> @display@
> expression e;
> statement s;
> type t;
> t * pointer;
> @@
> *pointer = e(...);
>  if (!pointer)
>     s
>  ... when != pointer
>
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> /usr/bin/spatch --no-loops …/Projekte/Coccinelle/janitor/show_unused_addresses_from_variable_assignments2.cocci arch/arm/kernel/devtree.c
> …
> @@ -77,7 +77,6 @@ void __init arm_dt_init_cpu_maps(void)
>
>         u32 tmp_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
>         bool bootcpu_valid = false;
> -       cpus = of_find_node_by_path("/cpus");
>
>         if (!cpus)
>                 return;
>
>
> Regards,
> Markus
>
--8323329-1227487145-1757160825=:4008--
