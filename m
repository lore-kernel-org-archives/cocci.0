Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FAAC7EE2A
	for <cocci@archiver.kernel.org>; Tue,  6 Jun 2023 16:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=fYiZckSCwgofo4VnlN0GAvzRFz0vWdqX4BsH4hOQ7xA=;
  b=t7fMmrmZHHaVTfL5z6foUDHyN8LTaqbt3y362DKKTh1MdUMxtoxzW29k
   tTOf0q3EJ867RRgWnt4LcUx70MghUEVWGJKiEKzLJiSsuuWKPwwuTrj6F
   NUD3loy/5UN8zC904teTDgnj4RVNyycZ7sCj3AfvDa6FJUoy2dK1a0a5P
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.00,221,1681164000"; 
   d="scan'208";a="111557141"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Jun 2023 18:23:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 04255E0CCC; Tue,  6 Jun 2023 18:23:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 222E7E0094
	for <cocci@sympa.inria.fr>; Tue,  6 Jun 2023 18:23:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fYiZckSCwgofo4VnlN0GAvzRFz0vWdqX4BsH4hOQ7xA=;
  b=c5sOaEbAYIWVfXHh65bTtQLLDASWC6iCs/dPKG+j5XQc4eEUSVgoI4cN
   6+vMUCTYrH+7iS3hcp5g+TptMvJJKfD9uGaYA0/vxgpeKfAzPW+AoPMjR
   zzUB5e6U6WzyhQDq5v+hVWH584zPoT/3RFrOc/WcbReWaMYRHOfrYDrzW
   I=;
X-IronPort-AV: E=Sophos;i="6.00,221,1681164000"; 
   d="scan'208";a="111557137"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 18:23:12 +0200
Date: Tue, 6 Jun 2023 18:23:12 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Yann Droneaud <yann@droneaud.fr>
cc: cocci@inria.fr
In-Reply-To: <5ac0affb-f517-7caa-d622-3b11acc96c7d@droneaud.fr>
Message-ID: <a3acae2a-efd7-9225-556d-f8f636c22d17@inria.fr>
References: <5ac0affb-f517-7caa-d622-3b11acc96c7d@droneaud.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Matching the size of an array
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1170
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/a3acae2a-efd7-9225-556d-f8f636c22d17%40inria.fr>



On Tue, 6 Jun 2023, Yann Droneaud wrote:

> Hi,
>
> I've managed to use coccinelle to replace something like:
>
> char array[123]
>
> snprintf(array, 123, ...);
>
> with:
>
> #define SNPRINTF(array, fmt, ...) snprintf(array, sizeof(array), fmt, ##
> __VA_ARGS__)
>
> char array[123];
>
> SNPRINTF(array, ...)
>
> The difficult part for me was to figure how to match array and size within
> structures, part of typedef or not, anonymous or not, accessed through pointer
> or not.
>
> And I'm not proud of SmPL I wrote. See the attached monster.
>
> I'm sure I've missed some ways to use simpler constructs.
>
> The example can be found here, with the test case:
>
> https://gitlab.com/ydroneaud/snprintf.cocci/
>
> I hope someone could give some hints to simplify my mess.

I thought it looked basically ok.

Not putting a semicolon on line 37 (in_struct rule) was a good choice.

julia
