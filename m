Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE7AC00140
	for <cocci@archiver.kernel.org>; Sun, 21 Aug 2022 09:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cSjr0qJfGK0+epBcazW/VtMOxnFaU3/kDRLz8mxkJk0=;
  b=BEXcnuPf5T2FfDrKteil+2hINTgMjGCph55j9Tn6GBYgu/jXljgyWXPm
   RlQCqFuuHTd4D6qKJ9rK7tH7M1lijeDri3r73562DJ42hSBgd6u5dJzut
   6eve10LswuijfAZH5bu42Bd+/fOKMRobbm6ngRK3q392Ac7etzW8sMyPY
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
X-IronPort-AV: E=Sophos;i="5.93,252,1654552800"; 
   d="scan'208";a="49370955"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Aug 2022 11:09:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 36B52E4374; Sun, 21 Aug 2022 11:09:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 96E40E0382
	for <cocci@sympa.inria.fr>; Sun, 21 Aug 2022 11:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cSjr0qJfGK0+epBcazW/VtMOxnFaU3/kDRLz8mxkJk0=;
  b=aFRx/nwsuUKiScN/q11ZIVi/D9dSJaQz/bBk9+EhEZrq3sDVxypS1anc
   r7/eV/kfxwejmatq20RqWZ9+4Q6+MPEj9uLBwA5hiaGXFcwQA1o8OOY58
   S5fm9F+BPNUEf+2FVU+zjROxYtWOpYbPrdnrm2ga8UYMepw+XBT4JQosN
   0=;
X-IronPort-AV: E=Sophos;i="5.93,252,1654552800"; 
   d="scan'208";a="49370954"
Received: from 16.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.16])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 11:09:38 +0200
Date: Sun, 21 Aug 2022 11:09:38 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Jakob Koschel <jkl820.git@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, 
    cocci@inria.fr
In-Reply-To: <26cfb01d-0d74-1c34-ac60-664c61931f07@web.de>
Message-ID: <alpine.DEB.2.22.394.2208211108400.3263@hadrien>
References: <20220816085416.1542114-1-jkl820.git@gmail.com> <alpine.DEB.2.22.394.2208161337001.2561@hadrien> <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com> <alpine.DEB.2.22.394.2208162306410.2625@hadrien> <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien> <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de> <88152C77-84AD-4515-A403-71F827180FD9@gmail.com> <cf4058d8-13ca-0637-fe0c-d9d8582c5673@web.de> <17A83354-2406-47E5-94EE-4955E09819DA@gmail.com>
 <d9e428c2-f4d2-13bb-bf42-447a1f0ffa73@web.de> <5369B40D-9EA4-401F-A9CB-2CA1C0E3332E@gmail.com> <26cfb01d-0d74-1c34-ac60-664c61931f07@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-595246163-1661072978=:3263"
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 527
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/alpine.DEB.2.22.394.2208211108400.3263%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-595246163-1661072978=:3263
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Jakob,

Despite the bizarre way in which Markus asks the question, the ; at the
end of the comment could be a serious problem.  Could you repost your
semantic patch and test code?

thanks,
julia






On Sun, 21 Aug 2022, Markus Elfring wrote:

> > I'm not sure what you mean "link for this evolving information source". There is no
> > public information on this yet since it's an ongoing project.
>
>
> Are you looking for contributions from related research groups?
>
>
>
> >> Are you looking for better source code formatting according to semicolons?
> > I'm not exactly sure what you mean with that?
>
>
> Do you care if a bit of code which is probably relevant for the programming
> language syntax would be commented out as it was indicated by the diff fragment
> “+    // test;”?
>
>
> > I've only used adding the comment to see if the matching works correctly,
>
>
> Would other code variants (than C++-style comments) be more helpful for
> the demonstration of desirable transformation effects?
>
>
> > I'm not intending to do anything with comments in the final version.
>
>
> My software application expectations evolved into additional directions
> according to mentioned change specifications (in SmPL code).
>
> Regards,
> Markus
>
>
--8323329-595246163-1661072978=:3263--
