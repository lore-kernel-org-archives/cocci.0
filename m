Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71175C07E9D
	for <cocci@archiver.kernel.org>; Mon, 26 Sep 2022 07:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=h6GmSjP4LEd0482jrYjKv7cwzVUKKKv96E/EB7I/I2w=;
  b=N9wvk34TAi+6I6Vu+xPG6gL5JAWG3Yo4K0Y/q5TxOR/EFoOkOuzvPDdx
   05yETx/qk/3x+mPrLkdKq1JkIGJCmpsCBkjCysLBBM73VH+dVQN3HhmCu
   LttFZn1VNvuRDhj+U239BskJBGAWUkO2QJCrHry6aEO0ZhjWVM3Hxbgcf
   k=;
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
X-IronPort-AV: E=Sophos;i="5.93,345,1654552800"; 
   d="scan'208";a="54456678"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Sep 2022 09:52:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5CC6DE0090; Mon, 26 Sep 2022 09:52:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 99899E0090
	for <cocci@sympa.inria.fr>; Mon, 26 Sep 2022 09:52:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=h6GmSjP4LEd0482jrYjKv7cwzVUKKKv96E/EB7I/I2w=;
  b=DdUF5UtwRLf1zZadR2mE6Si293otYaMhAvifvtDmWy4mv5iQU/XKNiwC
   doisPe7UBVn4VgwSHyPh9E8etM36U78zDh9JstbVFx0T9lQRUMUzDicz1
   QGkFY8Sgv3N8gF5hcydE3dfGnxV48ihqZ7u3kya5eo+5HvgS+6gD09pA6
   U=;
X-IronPort-AV: E=Sophos;i="5.93,345,1654552800"; 
   d="scan'208";a="24656020"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 09:52:43 +0200
Date: Mon, 26 Sep 2022 09:52:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
In-Reply-To: <trinity-bcb29359-5c27-4c34-95f6-f5827e936702-1664177792747@3c-app-webde-bs29>
Message-ID: <159a19ca-ada6-9cb4-90b2-fdcf384b914d@inria.fr>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien> <trinity-bcb29359-5c27-4c34-95f6-f5827e936702-1664177792747@3c-app-webde-bs29>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 587
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/159a19ca-ada6-9cb4-90b2-fdcf384b914d%40inria.fr>



On Mon, 26 Sep 2022, Markus Elfring wrote:

> > @create4@
> > identifier t,f;
> > position pa;
> > typedef spinlock_t;
> > @@
> >
> > struct t {
> >    ...
> >    struct mutex f@pa[...];
> >    ...
> > }
>
> * How much does the type definition matter for the referenced data structure
>   in this SmPL rule?

No idea what this question means.

>
> * The shown source code search refers to an array as a member.
>   Can such a selection be combined with a previous filter by using
>   a corresponding SmPL disjunction?

No.  A disjunction will pick one case and match all possible matches of
this case.  Perhaps that could be improved, but that is the situation at
the moment.

> * Would the application of iteration functionality become feasible
>   for the discussed use case?

Not relevant.

julia

> Regards,
> Markus
>
