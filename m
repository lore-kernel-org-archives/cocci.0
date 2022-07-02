Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAB5C43334
	for <cocci@archiver.kernel.org>; Sat,  2 Jul 2022 10:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=UsZKiKV/tLyXxBQrmVe1mHzEtBIEY9Vg2bmiTIyH8FY=;
  b=A7bF6TbQW+oNx2Eqfms0b3ghvt4Nq9pqOhMXrujGUNvEAjCyDernExTU
   YTTCVzQbv4SPZpUFd4Keq0RW0ivRJ0H1u7gqSwTqygIj9C00GpEs0y5b1
   Vz/tUrQTaVe7SnQu9UMSx82S6H+IkDX69GOVZD+SgUhWOovkiUPJBsznY
   I=;
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
X-IronPort-AV: E=Sophos;i="5.92,239,1650924000"; 
   d="scan'208";a="43931350"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Jul 2022 12:21:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9027DE0092; Sat,  2 Jul 2022 12:21:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 65E0CE0092
	for <cocci@sympa.inria.fr>; Sat,  2 Jul 2022 12:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UsZKiKV/tLyXxBQrmVe1mHzEtBIEY9Vg2bmiTIyH8FY=;
  b=geIwh3hSE/rVQTdKY2/vFCnS+KiOamBoaWJz5yFi8eN0fm1Tq+dPCHRm
   /fHNc4pCkar3ewsHprnFIOr8WxzToJ9ZO/E+gfGOpw4PccQOCk98QpZbk
   jad9DeqhjLCqoBKvrsQIrMYullEtqq78nViachCCLnwkcBF9+d/7s9TGo
   c=;
X-IronPort-AV: E=Sophos;i="5.92,239,1650924000"; 
   d="scan'208";a="18363920"
Received: from 252.75.68.85.rev.sfr.net (HELO hadrien) ([85.68.75.252])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 12:21:41 +0200
Date: Sat, 2 Jul 2022 12:21:39 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: =?ISO-8859-15?Q?J=E9r=E9my_Lefaure?= <jeremy.lefaure@netatmo.com>, 
    cocci@inria.fr, kernel-janitors@vger.kernel.org, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <51130aa6-1a1b-51fb-c4b7-c0dcda1d78d1@web.de>
Message-ID: <alpine.DEB.2.22.394.2207021218550.2882@hadrien>
References: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com> <632c81ca-3d53-4ff5-505e-f8da998e47db@web.de> <alpine.DEB.2.22.394.2207011647580.4779@hadrien> <51130aa6-1a1b-51fb-c4b7-c0dcda1d78d1@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-40877702-1656757300=:2882"
Subject: Re: [cocci] [PATCH v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 477
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/alpine.DEB.2.22.394.2207021218550.2882%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-40877702-1656757300=:2882
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

It seems that your resoning is "I wish Coccinelle would work this way, so
I will suggest an "improvement" to a proposed semantic patch that actually
currently has inferior behavior as compared to the original one (but not
mention that at all in the message), and hope that the Coccinelle
developers will think that adding the functionality that you hope for is a
very important priority".  If you want a feature to be added, ask for the
feature.  But please stop confusing the discussion about semantic patches
that are proposed by other people.

julia

On Sat, 2 Jul 2022, Markus Elfring wrote:

>
> > The whole point of the proposed change is to trigger some isomorphisms.
> > I really doubt that any isomorphisms will be triggered with this suggestion.
>
>
> Such expectations are interesting for further clarification, aren't they?
>
> Will any extensions become relevant also for the handling of isomorphisms
> by the Coccinelle software?
>
> Would you like to extend the following SmPL code variant anyhow
> so that more case distinctions will be taken better into account?
>
> @display@
> statement is, es;
> expression x;
> binary operator bo;
> @@
> (
> *if (&x)
>     is
>  else
>     es
> |
> * &x bo NULL
> |
> * NULL bo &x
> |
> * !(&x)
> )
>
>
> Regards,
> Markus
>
--8323329-40877702-1656757300=:2882--
