Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB82C54EAA
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nsZNOPjoMnwtQMUrEFata21tc/gHCRzZ9k3d/lroJzA=;
  b=NV1fUVQ8uuz4PrfiLgogDUJXGGmnTECTdt5FX/PlMwf1/whQoNoTjMid
   noabATT/f2ALj99bKQADaYSvNT2g50/ppMLCXevlvyU1FG9iTCksNfqxZ
   vM3cz/0K4LGSnZUs1H8MKBgpGqDjT8NDAC0AaT1OPgThkARA9Lilepinv
   I=;
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
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="90052637"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 11:52:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 53B85E7440; Mon, 30 Jan 2023 11:52:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 30EEFE743E
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 11:47:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nsZNOPjoMnwtQMUrEFata21tc/gHCRzZ9k3d/lroJzA=;
  b=SSSXBjSL8oSSkdHA9rNHVI/6yJjydS6OcxXauCbYaUg3UoyKMRzUtMzP
   e/rQIUZ+c3h1uZkkn4yeS/kC5gcXj+HncjtzupZGtTUW2YSt1eHCF71hQ
   lZf2xWF9o25UOBYtUa5Zo34OCos7tujVeYIKOXLLTsbLnyeDhobFSHwdc
   k=;
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="90051307"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 11:47:44 +0100
Date: Mon, 30 Jan 2023 11:47:44 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Luca Coelho <luca@coelho.fi>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <99bb02f6fdcb711102ef0b544fd6cf5a5dd90f97.camel@coelho.fi>
Message-ID: <4ce77f5f-2433-bb99-9270-f66267a84432@inria.fr>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>  <alpine.DEB.2.22.394.2301272148570.4094@hadrien>  <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>  <808cd549-f96d-872d-a4db-30ea33095207@web.de>  <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
  <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>  <alpine.DEB.2.22.394.2301281432120.2822@hadrien>  <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>  <alpine.DEB.2.22.394.2301291826510.2852@hadrien>  <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
  <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>  <alpine.DEB.2.22.394.2301292109320.2852@hadrien>  <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>  <dc9d939d-e1bb-8447-e950-deacc7a3645a@inria.fr>  <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
  <23ba4681-0b9e-cf60-5422-64526cdf462a@web.de>  <e1ebf2b582bd97d42e8573471fac83578d47ef17.camel@coelho.fi>  <079efecb-91da-e111-1a28-2c883b69af7b@web.de> <99bb02f6fdcb711102ef0b544fd6cf5a5dd90f97.camel@coelho.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 853
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/4ce77f5f-2433-bb99-9270-f66267a84432%40inria.fr>

It doesn't find the file with the definition.  You may need to give more
paths.

I have the impression that the result is improved with

-I drivers/gpu/drm/i915

Maybe -I drivers/gpu/drm/i915/display is necessary also.  If you add the
argument --relax-include-path then just -I drivers/gpu/drm/i915 may be
sufficient.  With that option, it will just hunt around in and under the
various include paths for a unique file that has the required name.

julia
