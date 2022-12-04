Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E82BC4321E
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 14:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=qWcLcfXmeF0qmyURBJMPH801aE1TlweX9fGBsZg8X8g=;
  b=TOnx/rEUe6ueP2m+0jF4AwtrHGuU6ZiNyUT/lTUpSeGX4xzUD92gnPQ2
   HADlZbM3usy8xgn+rw2GnSauch+YOktP99pr9Q41OExXkQsYA1dvABrqQ
   58XxIWB1SRxttWRmWNR395qDN6FA6ET/1zibE9oXkRHNA7AwC+YQM1OIM
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
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81595840"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 15:01:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8A9B5E0235; Sun,  4 Dec 2022 15:01:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 043DBE013A
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 15:01:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qWcLcfXmeF0qmyURBJMPH801aE1TlweX9fGBsZg8X8g=;
  b=l+QKRME3Zk478AMHJFZoL5KVCMyFH3mRlTEzMiz4/TzLIsFFwIV4TUCL
   eLwR1KcyP5aYose1Lx3dqlg+Ts3wSqbt2NN5DSP6BysfYVshqIjkKoNKk
   YtPNmOzT6vzmtf2jntlHG9e3SX8RRP0LzyvpBQj/lnLuhFLU6Z3ba+lMI
   U=;
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81595839"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 15:01:42 +0100
Date: Sun, 4 Dec 2022 15:01:41 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Derek M Jones <derek@knosof.co.uk>
cc: cocci@inria.fr
In-Reply-To: <4145c1bd-ae8f-fe91-9f52-676b2ea9e857@knosof.co.uk>
Message-ID: <alpine.DEB.2.22.394.2212041501270.3337@hadrien>
References: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk> <alpine.DEB.2.22.394.2212040832050.3337@hadrien> <e9d8231c-9b98-6603-4786-7b61809af4d0@knosof.co.uk> <alpine.DEB.2.22.394.2212041426120.3337@hadrien>
 <4145c1bd-ae8f-fe91-9f52-676b2ea9e857@knosof.co.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for ++ of volatile variables
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 768
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/alpine.DEB.2.22.394.2212041501270.3337%40hadrien>



On Sun, 4 Dec 2022, Derek M Jones wrote:

> Julia,
>
> > Maybe
> >
> > type t;
> > volatile t V_1;
> >
> > Not sure if it works.
>
> It works as we hoped it did :-)

Wow, thanks for letting me know :)

julia
