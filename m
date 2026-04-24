Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F59FE5202
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2026 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=TAx8zsLie9Ygn0TfWia6V6GQaBrsDPvJ8gOYVh7HNPQ=;
  b=eqrnSzMeahiiRyW8015xQ9zvqz99G7mOwXChCoah3iyXIn84Kc0H6TKE
   h1ShlW4a3CXtGxcEgrW4fXLz1Wlzno/PzU3gnXi8Mha/HIHhyryhkuFx4
   d02x0M/DiAZ/zTo4JTQnBMBjpeCBkOKFvNUpbjDZrD9f5LKfcFyTfNCNP
   g=;
X-CSE-ConnectionGUID: TUBQ51qRTValg1rv83FVAg==
X-CSE-MsgGUID: X29vWa3/RIap9eYi2oW/Ig==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,196,1770591600"; 
   d="scan'208";a="273979340"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2026 13:25:16 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 49D97816DD; Fri, 24 Apr 2026 13:25:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 64F04816D7
	for <cocci@sympa.inria.fr>; Fri, 24 Apr 2026 13:25:10 +0200 (CEST)
X-CSE-ConnectionGUID: g0f8XRoxTxqvs4bLxpnhEA==
X-CSE-MsgGUID: /rtyVVP5Rgq9u1Od9eGmsw==
X-IronPort-AV: E=Sophos;i="6.23,196,1770591600"; 
   d="scan'208";a="273979326"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 13:25:10 +0200
Date: Fri, 24 Apr 2026 13:25:10 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <366d74af-0552-4c90-9ea4-4f201f5493e8@web.de>
Message-ID: <e15b34a2-eeae-893-8b60-928e5abd963b@inria.fr>
References: <138f6f86-b875-42fd-bc00-f0ad5e1f6f6b@web.de> <f93c2682-64ef-7a25-239b-5e7e98144a6@inria.fr> <366d74af-0552-4c90-9ea4-4f201f5493e8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Planning the next software release?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3484
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/DwoS1Z8y1nKhmDkB8aqHOg>



On Fri, 24 Apr 2026, Markus Elfring wrote:

> >> With which delay will known improvements become available for general applications?
> >
> > What is a known improvement that you are concerned about?
>
> 1. We know commits which should influence software run time characteristics
>    in more desirable directions.
>
> 2. Further software dependencies triggered collateral evolution finally.
>
>
> >                                                            I think that
> > everything that is considered to be working is in the master branch and
>
> There are remaining (open) issues for further development considerations.
>
>
> > will be propagated to the next release when it is ready.
>
> In which time range will anything happen here accordingly?
>
> Which activities would eventually be picked up before?

There is a current bug that needs to be fixed.  The time range is the
total of the time for fixing that bug.

julia
