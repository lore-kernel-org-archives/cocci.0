Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE6FC32771
	for <cocci@archiver.kernel.org>; Fri, 19 Aug 2022 09:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=LBFsEh5DGQ7lkEUeIaq954Ge9DMxpsvqUOpAnqeK8J4=;
  b=msB9qqVqgNP+ICuliaEJ98gL2W1UwnMOKu1pqTCYBkwMawVgaSFbp7Iw
   yIBav0m5KIU5hCFDV9g+3nPzUlhyYmthgLskLVWaHQWbypAA/VKRFgXkV
   HKMZjigAH4Hswqo19G9MLF9t4Z0HkVSQQ9sQ8XQeNLQqI3JFcePMiPz3l
   U=;
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
X-IronPort-AV: E=Sophos;i="5.93,247,1654552800"; 
   d="scan'208";a="49209997"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Aug 2022 11:58:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1B155E0AC3; Fri, 19 Aug 2022 11:58:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AC127E0247
	for <cocci@sympa.inria.fr>; Fri, 19 Aug 2022 11:57:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LBFsEh5DGQ7lkEUeIaq954Ge9DMxpsvqUOpAnqeK8J4=;
  b=BJNK9GOPxsyEw6BysurqT2SVMywoVcluLM8pVF9u9zLRM3uT7e76Ji+z
   Q8wXJtu30KP4XZpT+wPU26WVC09U2EnUNGm+iyu3jgvXnCXVzhwZFfuef
   2ZA6+BGsMtq2Ehy5a1psIXB2x988jN/Kaso8hwW1DNuQQ6sAW03AaM2fo
   s=;
X-IronPort-AV: E=Sophos;i="5.93,247,1654552800"; 
   d="scan'208";a="21675210"
Received: from 16.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.16])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 11:57:56 +0200
Date: Fri, 19 Aug 2022 11:57:55 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jakob Koschel <jkl820.git@gmail.com>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <17A83354-2406-47E5-94EE-4955E09819DA@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2208191156210.2971@hadrien>
References: <20220816085416.1542114-1-jkl820.git@gmail.com> <alpine.DEB.2.22.394.2208161337001.2561@hadrien> <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com> <alpine.DEB.2.22.394.2208162306410.2625@hadrien> <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien> <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de> <88152C77-84AD-4515-A403-71F827180FD9@gmail.com> <cf4058d8-13ca-0637-fe0c-d9d8582c5673@web.de> <17A83354-2406-47E5-94EE-4955E09819DA@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 521
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/alpine.DEB.2.22.394.2208191156210.2971%40hadrien>

> I've found this [Link], suggesting to use '--file-groups' or '--kbuild-info' to
> o analysis across multiple files. I've managed to get '--file-groups' working
> on a small example but it will get challenging to do on the entire kernel.
> The '--kbuild-info' option *looks* outdated at least I couldn't find an easy way to get
> it running on the kernel.

--file-groups is a better option.

The other option is to use iteration, and collect information on one
iteration and use it on the next one.  That would give a completely global
analysis that might not scale.  You can see an example in
demos/iteration.cocci

julia
