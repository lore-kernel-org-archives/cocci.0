Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BEBC04A95
	for <cocci@archiver.kernel.org>; Fri, 23 Sep 2022 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=W924Q08YRfkc/BK7mpoCqLP0ZrNRF4hS2uWrF5dSqQk=;
  b=lCnEmMoihT9fvAl96uS9LHz8KYWg/rShKYNAoG3ihFxUH0kjifIFBV99
   tPG8uXgHo8cFbkWl1CrNoCbNY/Hs5opVr9WdIF9KgHpvgi/o1dB+fv2qZ
   7H4foybb8wTc6bmoHgxc0BxtgbTOdJ/iRm2iRs7Ut2CWjz34waXWSbypq
   0=;
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
X-IronPort-AV: E=Sophos;i="5.93,340,1654552800"; 
   d="scan'208";a="54293492"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Sep 2022 21:27:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 83F55E0091; Fri, 23 Sep 2022 21:27:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 33743E0090
	for <cocci@sympa.inria.fr>; Fri, 23 Sep 2022 21:27:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W924Q08YRfkc/BK7mpoCqLP0ZrNRF4hS2uWrF5dSqQk=;
  b=pLVA8QmRhBYstTudi2Gjouriym6jaStiF67ErE/4Bm4y/zAo02QKA4PV
   maewr/QLcryAROYoehKfXikPbc1Y7qpDXYPFInJ76R5lN/mALOUslBIXF
   HUZ2Gi4iEcNLL6WJff0HqMUEa/7JsTCV7TuZ1AZZ0Ybx6xm9jAGtiBKeK
   8=;
X-IronPort-AV: E=Sophos;i="5.93,340,1654552800"; 
   d="scan'208";a="54293489"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 21:27:35 +0200
Date: Fri, 23 Sep 2022 21:27:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
In-Reply-To: <2a8b2d3c-26cf-3aab-34b3-1ba402740111@web.de>
Message-ID: <alpine.DEB.2.22.394.2209232125480.2720@hadrien>
References: <20220922115535.44132-1-yuancan@huawei.com> <20220922115535.44132-2-yuancan@huawei.com> <3351dd3d-f55a-10b0-6b35-d5206570e687@web.de> <2274a1a9-4b13-7677-9cf7-55ea960d8be@inria.fr> <6a0600c7-dcdd-f37d-9a6d-cc734cf88dd1@web.de>
 <54938aa-3629-2bc2-edc-cc1b3246866@inria.fr> <2a8b2d3c-26cf-3aab-34b3-1ba402740111@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1190244421-1663961255=:2720"
Subject: Re: [cocci] [v3 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 579
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209232125480.2720%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1190244421-1663961255=:2720
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 23 Sep 2022, Markus Elfring wrote:

> >> # How do you think about the handling of multiple members within data structures?
> > There should be no problem with this.
>
>
> Would it be relevant to use the SmPL construct “<+... … ...+>”?

Not in a structure definition.

>
>
>
> >> # How much does it matter here that curly brackets are used for a proposed SmPL constraint?
> > I have no idea what "How much does it matter" mean.  {} are used because
> > that's how struct types are declared.
>
>
> Please take another look at mentioned implementation details for
> the clarification of such communication difficulties.
>
> A)
> position p != {r2.p};
>
> B)
> position p != find_member.p;

OK, both are fine.  If there are multiple positions that p should be
different from then the {} would be required.

>
>
> >> I got another development concern for the presented algorithm.
> >> Why is a data initialisation function call searched in the first SmPL rule at all?
> > Because he wants to find the fields for which mutex_init is already called
> > and to not report messages for them.  That is the whole point of the
> > semantic patch.
>
>
> How do you think about an opposite source code search order?
>
> Would you like to search for function calls which require initialised
> data structures before any additional source code analysis?

It doesn't make much sense to have a mutex without initializing it.

julia
--8323329-1190244421-1663961255=:2720--
