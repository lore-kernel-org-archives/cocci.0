Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D42C43334
	for <cocci@archiver.kernel.org>; Thu,  9 Jun 2022 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=pgG0eA2vc/1dAlCwvkKaeMSKAA9qNytf28HYhRuJL28=;
  b=TTZjmEjRMwgEDMpzc0wv5us5L7kNB49i+7lfGtPmuSf/ffxhfRr4ohB4
   g1Pdsi8vWz75syQ64NxWvtL+emrARbzEO+ttGvzWFykBe6CgBSjwHZLNd
   7sTPYxnRDl4TLJFJqKUDcWSBWI6cqDveiRrco1lGTik//VYI0TD5s4c95
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208";a="40269533"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Jun 2022 17:41:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 77ED4E032A; Thu,  9 Jun 2022 17:41:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 82DAAE010B
	for <cocci@sympa.inria.fr>; Thu,  9 Jun 2022 17:41:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pgG0eA2vc/1dAlCwvkKaeMSKAA9qNytf28HYhRuJL28=;
  b=rSUp77YvJ63LjttEXhuoyMEEveSbwVdbTCIAjYtP7yfjdqZ1fRymRhdc
   yrYKHCHaAWOfqbDPd0CL5/U9XoRBk84q1vT59iCQLWoDI2b+tuNMdi9KB
   waYrqBEbGu+U9nf75Ih0VSdbPwNKlJr9a+Hjnd+mJcsmTkIPwKoSASdao
   4=;
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208";a="16348258"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 17:41:15 +0200
Date: Thu, 9 Jun 2022 17:41:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: =?ISO-8859-15?Q?J=E9r=E9my_Lefaure?= <jeremy.lefaure@netatmo.com>, 
    cocci@inria.fr, kernel-janitors@vger.kernel.org, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <15a253a6-469b-9632-8c7d-983554604451@web.de>
Message-ID: <alpine.DEB.2.22.394.2206091740520.2380@hadrien>
References: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com> <415ca02b-9618-b447-6471-6bcd0e2215e8@web.de> <alpine.DEB.2.22.394.2206072138160.2960@hadrien> <15a253a6-469b-9632-8c7d-983554604451@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-267814770-1654789275=:2380"
Subject: Re: [cocci] coccinelle: ifaddr: Find address test in more complex
 conditions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 427
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206091740520.2380%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-267814770-1654789275=:2380
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 9 Jun 2022, Markus Elfring wrote:

>
> I don't really understand the above, but it made me realize that actually
> the following is sufficient:
>
> @@
> expression x;
> @@
>
> *&x || ...
>
> This forces &x to appear as a test expression.  There can be 0 or more
> occurrences of ||, so eg &x && y is also matched.
>
>
> How does this promising feedback fit to the following information from
> the software “Coccinelle 1.1.1” (OCaml 4.14.0)?
>
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> spatch --parse-cocci show_address_determination_in_checks-20220609.cocci
> …
> @display@
> expression x;
> @@
>
>
> (
> *&*x *|| *...
> |
> *&*x *!= *NULL *|| *...
> |
> *&*x *|| *...
> |
> *NULL *!= *&*x *|| *...
> )
>
>
> No grep query
>
>
> Would another transformation be needed for the omission of trailing binary operators
> (according to the shown combinations with SmPL ellipses)?

I don't know what you mean.  How about trying an example?

julia
--8323329-267814770-1654789275=:2380--
