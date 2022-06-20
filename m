Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2444FC433EF
	for <cocci@archiver.kernel.org>; Mon, 20 Jun 2022 10:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=e2ZPqPK0glNcKMnxiuqKgkvx7n0rClWVWBlgWbKNLH8=;
  b=lPo7ca/GScqQ8LtBj+Wc7TaSBz4SlroVBu6cFq3S/WYq1QnSgUO7OiNY
   KeVSN3+j9B5OPMSSgwCS4vvylwsYHymIo9flBP/jZCb9LJlSAASCKVwxm
   +9+8jXvaurF92nztNphkHtQlZ/Jyzx7A+hfuK5yxblnU/yDwzzvg3kbR+
   s=;
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
X-IronPort-AV: E=Sophos;i="5.92,306,1650924000"; 
   d="scan'208";a="41925149"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jun 2022 12:59:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 14F2CE033C; Mon, 20 Jun 2022 12:59:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5B33AE0094
	for <cocci@sympa.inria.fr>; Mon, 20 Jun 2022 12:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e2ZPqPK0glNcKMnxiuqKgkvx7n0rClWVWBlgWbKNLH8=;
  b=nFgOg1pO4HhSEWhlzMLQWbg7ZMDWtnSc61nSK3IjNmvm3p/0uDiLBEx9
   nzR0EP4ntxVk8CtB9ncWYiXws7H55gVe974MIQHK57CHAw2zVeKxQdt/h
   WB2LzNatNStJk8WG3If1yN3OirC3WqKY1eoN6fTdgfqzzz7XAWmT+Ehew
   g=;
X-IronPort-AV: E=Sophos;i="5.92,306,1650924000"; 
   d="scan'208";a="41925148"
Received: from 71-51-190-12.chvl.centurylink.net (HELO hadrien.PK5001Z) ([71.51.190.12])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 12:59:00 +0200
Date: Mon, 20 Jun 2022 06:58:53 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
cc: cocci@inria.fr
In-Reply-To: <973ae278-3319-94df-4215-d11dac3b3334@linbit.com>
Message-ID: <alpine.DEB.2.22.394.2206200658250.2263@hadrien>
References: <973ae278-3319-94df-4215-d11dac3b3334@linbit.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-206567945-1655722741=:2263"
Subject: Re: [cocci] Matching either declaration or assignment
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 447
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206200658250.2263%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-206567945-1655722741=:2263
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 20 Jun 2022, Christoph Böhmwalder wrote:

> Hi,
>
> I have two places where I want to run a similar transformation:
>
> 	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
> 			REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
>
> and (in a different function):
>
> 	struct bio *bio;
> 	...
> 	bio = bio_alloc(device->ldev->backing_bdev, nr_pages, peer_req->opf,
> GFP_NOIO);
>
>
> So basically, in one variant the assignment is done in combination with
> the declaration, while in the other case the assignment is separate from
> the declaration.
>
> I would now like to match both variants with a semantic patch, capturing
> "bio" either way. This is what I have intuitively tried:
>
> @@
> local idexpression struct bio *b;
> expression bdev, opf, gfp_mask, nr_vecs;
> @@
> b =
> - bio_alloc(bdev, nr_vecs, opf, gfp_mask)
> + bio_alloc(gfp_mask, nr_vecs)
> ;
>
> But it only matches the separate assignment.
>
> On the other hand, this:
>
> @@
> identifier b;
> expression bdev, opf, gfp_mask, nr_vecs;
> @@
> struct bio *b =
> - bio_alloc(bdev, nr_vecs, opf, gfp_mask)
> + bio_alloc(gfp_mask, nr_vecs)
> ;
>
> Only matches the combined declaration/assignment.
>
> Is there a way to match both with the same rule?

Yes, just make the first rule, but drop the semicolon.

julia

>
> --
> Christoph Böhmwalder
> LINBIT | Keeping the Digital World Running
> DRBD HA —  Disaster Recovery — Software defined Storage
>
--8323329-206567945-1655722741=:2263--
