Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B4CCCF9F0
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ZBM496W0H808A/sxrZpKWnijC/g2m+6y7yc2jQ+jtWM=;
  b=N3+sEUnKteQXqLJQJG/Qeg8NMvtN0hG6jD9qqPWwR0luoEG+E8UbPKCs
   z3yX3w7sAv5CUo2LHo9pcPvwb/h7vNV6dMH+qK+CeIETQAKzr9jRHeqE/
   awBFJXblkYcJbR056tDhvl9zDtk+RDTFp9j2ySfHDaRLMQtculLiotH5y
   4=;
X-CSE-ConnectionGUID: pLEOXB17SD6Q+WVXZys6GA==
X-CSE-MsgGUID: 5XwCg83HQxyM5/Wx9LVDxg==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246832443"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 11:32:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E55A8E0B0D; Thu, 30 Oct 2025 11:32:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 05EA3E0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 11:32:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ZBM496W0H808A/sxrZpKWnijC/g2m+6y7yc2jQ+jtWM=;
  b=oFGYhfCntwSlqhl+lS4g0Y71grRFgna6mpTl3MOxvySgGzSonPIDQ5ty
   zyT9h+vbyWrCekWkAb05Mhaud+OtB6Fi7FR8UWul2PetI0BxEE3DTNWmZ
   yO2i4XK79wuhUyYrq2hKG4JRAK8z0wq25/WApCwyxuW1HAfrIgOpHpVJ0
   8=;
X-CSE-ConnectionGUID: ueWAXUFRRIO2UcyBAq2KIg==
X-CSE-MsgGUID: bOojJxBISzOfg1InzIRX9Q==
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129484394"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 11:32:02 +0100
Date: Thu, 30 Oct 2025 11:32:01 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <d227e982-d69d-45b7-9388-9082f86af69c@web.de>
Message-ID: <6faae122-fddb-34cb-68fc-5f4b62d7e16@inria.fr>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de> <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr> <62441255-45fc-4edb-a8e5-c208b36ca2c2@web.de> <53e91f9f-bfe5-5c57-157c-fc456bd430ca@inria.fr> <d227e982-d69d-45b7-9388-9082f86af69c@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1271298350-1761820302=:11598"
Content-ID: <b3dd7bd5-3cfe-16ab-a8f8-cea6d32713b@inria.fr>
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3118
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/6faae122-fddb-34cb-68fc-5f4b62d7e16%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1271298350-1761820302=:11598
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <fed1875-fe5-1bbc-81f1-eb68a9c7e35c@inria.fr>



On Thu, 30 Oct 2025, Markus Elfring wrote:

> …> I think you would get a more satisfactory result by just removing all of
> > the code and adding it back. Then Coccinelle would take charge of laying
> > out the whole thing.
> …
>
> See also once more:
>
> >> Another SmPL script example might become helpful.
> >>
> >> @replacement2@
> >> expression object, size, source, target;
> >> @@
> >>  target =
> >> -         object; memcpy(target, source, size)
> >> +         memcpy(object, source, size)
> >>  ;

I said to remove everything.  target = also.

julia

> >>
> >>
> >> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment2.cocci arch/arm64/kvm/arm.c
> …>> real    0m0,626s
> >> user    0m0,588s
> >> sys     0m0,037s
>
>
> Regards,
> Markus
>
--8323329-1271298350-1761820302=:11598--
