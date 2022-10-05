Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97F2C433F5
	for <cocci@archiver.kernel.org>; Wed,  5 Oct 2022 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3OyWelOStA5UD+n7JTNXTrqLaHBr16O8ITSuOZwsVyY=;
  b=OWPDyXQnmW98es6YFmWrQGzs1scFIBlkrOUO2u4ZfNe264sFY5j9uIYO
   gTZXBp+UnA+OAKNV8SkFjaqlpM4ZEUfrbDea5VCPJGsmzlg3BxtbDVWv/
   4oxXAx7aqmg1imiN3kewViJOUpOR8jdJ0zcmVANPRrccf51/Pwd/ZQDei
   8=;
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
X-IronPort-AV: E=Sophos;i="5.95,159,1661810400"; 
   d="scan'208";a="56086772"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Oct 2022 12:25:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CD13FE0076; Wed,  5 Oct 2022 12:25:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A5BF1E0076
	for <cocci@sympa.inria.fr>; Wed,  5 Oct 2022 12:25:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3OyWelOStA5UD+n7JTNXTrqLaHBr16O8ITSuOZwsVyY=;
  b=gQO1pTzWw/n1Cta8FAfII+6upOpsYhrFPHWPZnwWV+iyfWKlFpuHvxrm
   oZQQ1GSDU1br5XpI+1kQHbj/CLiR9yAoiMx6LWwCpnNBnAm9+esMf2Cqq
   f6cBm0ir95fw7i58phrJL0dHC8+SDqeoIkXK/xmPesZzajHYmiXrWWpi9
   U=;
X-IronPort-AV: E=Sophos;i="5.95,159,1661810400"; 
   d="scan'208";a="25536549"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 12:25:29 +0200
Date: Wed, 5 Oct 2022 12:25:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
cc: cocci@inria.fr
In-Reply-To: <b5d97968-b1c6-191d-e4c0-662416e8bb90@linbit.com>
Message-ID: <alpine.DEB.2.22.394.2210051224210.2949@hadrien>
References: <b5d97968-b1c6-191d-e4c0-662416e8bb90@linbit.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-573990761-1664965529=:2949"
Subject: Re: [cocci] Matching against struct_group()
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 616
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210051224210.2949%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-573990761-1664965529=:2949
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 4 Oct 2022, Christoph Böhmwalder wrote:

> Hi all,
>
> say I would like to replace an instance of the struct_group macro in the
> Linux kernel:
>
> 	struct_group(algs,
> 		char verify_alg[SHARED_SECRET_MAX];
> 		char csums_alg[SHARED_SECRET_MAX];
> 	);
>
> I'm guessing this is not supported by coccinelle because of the
> "unusual" syntax? I tried specifying struct_group as a "declarer", but
> that did not work (which does not surprise me because it's not really a
> declarer anyway).
>
> Is there any way I can still make this match?

What is it about this struct_group that makes you want to match it?  That
is, would your semantic patch involve something about the second argument,
with the declarations?

julia
--8323329-573990761-1664965529=:2949--
