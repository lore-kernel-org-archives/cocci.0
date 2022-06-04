Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6815BC43334
	for <cocci@archiver.kernel.org>; Sat,  4 Jun 2022 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=paiQDWRNIqzdrqmQA5zex78gh2P49XTxepAnxyWSzRg=;
  b=BSKzibljWP4jp3eT0GVdUuF59yfkSOd9fotlGRlzcwixQoEHZ6RclwBy
   0ZBZOsV1AUR9aViGU6VumVXsqL7LcMdbgauIW3NgU4bkjDKB5g0TB8MaC
   QVlSP9ncd1oMVhV/dD6oLHOZ8qtOg9awoTTnO9yS9iSfay5x8XGrgnS67
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="39506264"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Jun 2022 16:51:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69894E02B4; Sat,  4 Jun 2022 16:51:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AF209E007E
	for <cocci@sympa.inria.fr>; Sat,  4 Jun 2022 16:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=paiQDWRNIqzdrqmQA5zex78gh2P49XTxepAnxyWSzRg=;
  b=ZQ9rPvjo9ceQNtqNea7lDclxiG5ubK9EjfCMW8JmGjIcbEzcdd95Kmk5
   bHgksAWyqXqG3aznvcVli3J5dToP5TGAbLYX5ERLPYuI3zeiCc+V1UIvq
   1U9Py9olDrydKiAZRrD6K+0f/YZPsfGQ8STwZZU/8HkClb4gtwdSgTn2r
   s=;
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="15925396"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 16:50:57 +0200
Date: Sat, 4 Jun 2022 16:50:56 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, 
    =?ISO-8859-15?Q?J=E9r=E9my_Lefaure?= <jeremy.lefaure@netatmo.com>, 
    cocci@inria.fr, kernel-janitors@vger.kernel.org, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <edfe8a02-82b6-aa03-b6e8-25f71e116807@web.de>
Message-ID: <alpine.DEB.2.22.394.2206041650470.2858@hadrien>
References: <AS8PR03MB7603A9FB9FA6A62438B09A3793DD9@AS8PR03MB7603.eurprd03.prod.outlook.com> <2490b8cf-4d9e-1357-6563-097264bcb01a@web.de> <alpine.DEB.2.22.394.2206041609220.2858@hadrien> <edfe8a02-82b6-aa03-b6e8-25f71e116807@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1846226568-1654354257=:2858"
Subject: Re: [cocci] coccinelle: ifaddr: Find address test in more complex
 conditions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 417
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206041650470.2858%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1846226568-1654354257=:2858
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 4 Jun 2022, Markus Elfring wrote:

> >> *if@p ( \(&x \| &x || ... \| &x && ... \) )
> >>  S1 else S2
> >>
> >>
> >> How do you think about to use such a SmPL code variant instead?
> >
> > I don't think that the &x case is needed.  There is an isomorphism for ||
> > ... that makes it cover the case where the || is not there as well.
>
>
> Do you refer to an isomorphism which is built into the Coccinelle software
> (instead of being explicitly specified in the file “standard.iso”)?

Yes, that is correct.

julia
--8323329-1846226568-1654354257=:2858--
