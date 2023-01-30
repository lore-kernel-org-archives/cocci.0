Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DD0C54EED
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 08:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+3mlULqdN0vsku1oiinopwhy9+1vxhgo9NP6mynnsoA=;
  b=vYVKxLZ3PvqOtgrkbWZzju8YHduE5v8lMI1mmEhhmD+TMMWz66Ps9aDe
   4gPriOQBlYXeUIc4ap7okG34mWjcF44BgTfyoyq0twCYFt1GtC+9BwUen
   hSGPu33orvyLIWi/w+1Cf1IJksDxljJ6+gtjaXmZPCMEk/+UCz59mgDnH
   0=;
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
   d="scan'208";a="89992337"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 09:37:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 92107E743F; Mon, 30 Jan 2023 09:37:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C6DCAE743E
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 09:37:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+3mlULqdN0vsku1oiinopwhy9+1vxhgo9NP6mynnsoA=;
  b=fqRyZ8Yhv/aKsIm4QeQznJVSAKteM/Nc0DhQVNYF+qRM6+ZZqoW+IYVG
   JXXcStUnMgoiqkhYlkHJKj/mLBJn8z6uDH/dcy58P1A+xpzmHg9SmCHbP
   CONKEYPYhIt3WP3Fk5m6bWLM7sjtxgYsgcLujuniccFbz1i84U0QOnmAQ
   A=;
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="89992325"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 09:37:48 +0100
Date: Mon, 30 Jan 2023 09:37:47 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Luca Coelho <luca@coelho.fi>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>
Message-ID: <dc9d939d-e1bb-8447-e950-deacc7a3645a@inria.fr>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>   <alpine.DEB.2.22.394.2301272148570.4094@hadrien>   <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>   <808cd549-f96d-872d-a4db-30ea33095207@web.de>  
 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>  <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>   <alpine.DEB.2.22.394.2301281432120.2822@hadrien>   <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>   <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
   <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>  <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>  <alpine.DEB.2.22.394.2301292109320.2852@hadrien> <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1970319189-1675067867=:3822"
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 843
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/dc9d939d-e1bb-8447-e950-deacc7a3645a%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1970319189-1675067867=:3822
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

> Sorry, false alarm.  I was running spatch by itself on an inner
> directory (.../i915/display), but when I used find, I was using
> .../i915, so there was one more match happening there.
>
> So, it seems that the latest head _does_ work fine! And I'm gettign all
> the matches and changes that I expect.  Thanks!

Great news :)

julia

>
> I really appreciate your promptness in responding and helping with all
> this.  I will probably come back with more questions soon, when I start
> trying other rules. 🙂
>
> --
> Cheers,
> Luca.
>
--8323329-1970319189-1675067867=:3822--
