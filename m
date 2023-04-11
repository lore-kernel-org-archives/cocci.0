Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFC4C76196
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 07:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OHrTMkf5R4C4XNEzngdXIuZRhn0et7vsN9POMwfmYTs=;
  b=H33FFCej9R82i7UsOhXIw/lgAc4CiIySbqjJvNyVgFfXFLAmzu4t953T
   /9412rdrLoSAmxN93e7k8VTP3b1xCIKSWAFXR8l0dH9BMuF2gezgFovwj
   +XX5AnrCVNHMe6i3StrHFH4KqYKDDSK2S8wghhrwsHZIK0Ldf4Ct0dfqa
   I=;
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
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102355073"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 09:40:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D2272E7312; Tue, 11 Apr 2023 09:40:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8307EE72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 09:40:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OHrTMkf5R4C4XNEzngdXIuZRhn0et7vsN9POMwfmYTs=;
  b=aUC73seVZ3Vmy/RKhU7TRZL68LM5DJxHJTiwDesP1USmUhNxYeCRpWPI
   45yImImXqxSReS5GB0gY7vlQX3p1TFCqaxdTEVQlrliJWL/nuh/1dOalp
   rONm/9jirDtZAoItVcqVvyrWWUbr4L1i7cje/vHuO7XDiK6WgNy+F/zzU
   k=;
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102355044"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:40:23 +0200
Date: Tue, 11 Apr 2023 09:40:23 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org
In-Reply-To: <5defca25-d893-f61a-ec24-aa99ba39d8a7@web.de>
Message-ID: <4d2383c7-b923-31a2-2c26-7b34b3b13c7@inria.fr>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de> <1a11455f-ab57-dce0-1677-6beb8492a257@web.de> <alpine.DEB.2.22.394.2304092044020.3028@hadrien> <95caa4c1-2455-2733-ef4b-3ab07783c725@web.de> <alpine.DEB.2.22.394.2304100824510.3387@hadrien>
 <2de88997-0732-d0dd-5178-f9d42b5a3be5@web.de> <alpine.DEB.2.22.394.2304100959310.3387@hadrien> <31b51efc-afbe-ec34-255e-9df60983ec3d@web.de> <alpine.DEB.2.22.394.2304101415040.2875@hadrien> <5defca25-d893-f61a-ec24-aa99ba39d8a7@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-262426065-1681198823=:3683"
Subject: Re: [cocci] Reconsidering pointer dereferences before null pointer
 checks (with SmPL)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1026
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/4d2383c7-b923-31a2-2c26-7b34b3b13c7%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-262426065-1681198823=:3683
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 11 Apr 2023, Markus Elfring wrote:

> >>>> https://stackoverflow.com/questions/25725286/does-taking-address-of-member-variable-through-a-null-pointer-yield-undefined-be
> >>>> https://en.cppreference.com/w/c/language/behavior
> >>>
> >>> The statement:
> >>>
> >>> "... &((*ptr).second) which dereferences an object instance pointer"
> >>>
> >>> is not correct.  &((*ptr).second) does not dereference *ptr any more than
> >>> &x deferences x.  The semantics of & doesn't work like that.
> >>
> >> Does the usage of the operator “member access through pointer” (arrow) mean also
> >> a dereference in comparison to the asterisk operator in the C programming language?
> >
> > Not when there is a & in front.  you can just look at the generated
> > assembly code to see that.  The goal of & is to take the address of
> > something, not to evaluate the thing.
>
> Would you like to take another look at recent responses by David Svoboda?
> https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+null+pointers?focusedCommentId=405504153#comment-405504153

His previous comment says that the standard doesn't mention &a->b so it is
a problem.  He is surely more of an expert on the C standard than I am.

julia
--8323329-262426065-1681198823=:3683--
