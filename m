Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DB8C00140
	for <cocci@archiver.kernel.org>; Sun, 21 Aug 2022 10:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=2uHlyPTBuyJpGjD4IUXuY5OCRYqC/tdEo5wgRkH40Gk=;
  b=RrzQ53ZsXDp42IvdEh4VBxzAJSgxchGfvCW3tQs8cjUYbgpVZlVPDcY0
   5IyHtXyH2IkbfQ/eV/G91yDu+/yNlt2zh9HNMnKMqp+h0DqCwjShkyK7s
   54VWyDexNxD+f2oqxHoAJXe6s78XGV1OuCPTOKwA1E91hR5FroPcBK45F
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.93,252,1654552800"; 
   d="scan'208";a="49373477"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Aug 2022 12:01:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5E5B0E4375; Sun, 21 Aug 2022 12:01:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 59EFAE00F6
	for <cocci@sympa.inria.fr>; Sun, 21 Aug 2022 12:01:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2uHlyPTBuyJpGjD4IUXuY5OCRYqC/tdEo5wgRkH40Gk=;
  b=Mo1onN2YwkYW9uF9VHSZPnWtS8fg4ar/Jq/QVTQthO/jrjtmvs6ENYk5
   9/qjJZ9G3QsnDOpXzOkDptqj04xDuTsLpZcGdfXeMOkc5a8/e7xEvgH9Y
   BO6mQJ0zOT85ZrME2TAyPoPsyZITIOZ0D2k1Vw2Aqk5LgDSInR603VSBR
   w=;
X-IronPort-AV: E=Sophos;i="5.93,252,1654552800"; 
   d="scan'208";a="21767625"
Received: from 16.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.16])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 12:01:08 +0200
Date: Sun, 21 Aug 2022 12:01:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Jakob Koschel <jkl820.git@gmail.com>, cocci@inria.fr
In-Reply-To: <8049e567-0aca-ada9-54f2-557dc1083ee3@web.de>
Message-ID: <alpine.DEB.2.22.394.2208211200120.3263@hadrien>
References: <20220816085416.1542114-1-jkl820.git@gmail.com> <alpine.DEB.2.22.394.2208161337001.2561@hadrien> <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com> <alpine.DEB.2.22.394.2208162306410.2625@hadrien> <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien> <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de> <88152C77-84AD-4515-A403-71F827180FD9@gmail.com> <cf4058d8-13ca-0637-fe0c-d9d8582c5673@web.de> <17A83354-2406-47E5-94EE-4955E09819DA@gmail.com>
 <d9e428c2-f4d2-13bb-bf42-447a1f0ffa73@web.de> <5369B40D-9EA4-401F-A9CB-2CA1C0E3332E@gmail.com> <26cfb01d-0d74-1c34-ac60-664c61931f07@web.de> <alpine.DEB.2.22.394.2208211108400.3263@hadrien> <8049e567-0aca-ada9-54f2-557dc1083ee3@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 529
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/alpine.DEB.2.22.394.2208211200120.3263%40hadrien>



On Sun, 21 Aug 2022, Markus Elfring wrote:

> > Despite the bizarre way in which Markus asks the question,
>
>
> I find such a view also interesting.
>
>
>
> > the ; at the end of the comment could be a serious problem.
>
>
> Thanks for your wording variant about the usage of semicolons.
>
>
>
> > Could you repost your semantic patch and test code?
>
>
> I imagine that a semantic match (with the application of SmPL asterisks)
> could be also helpful for the desired understanding of the discussed
> transformation approach.

I don't see why.  I'm only concerned about why a // comment was added at
the front of a line containing real code.  Perhaps the pretty printer
treats all comments the same...

julia
