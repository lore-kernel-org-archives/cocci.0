Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E8AC433F5
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 06:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=6VSOtW8uRSASMMYXVQauN2PwQG0mWuKQk2eFJtKsPi8=;
  b=Rm8Y7kBRBcvvTPFpn7C3ftXexcRstypoz7s7SliaSZ4U8xVy19WTLwZV
   MUyIkeLpvX/vmOQsnhc423a9tpr5iHMgP/dZNG8mukncEe7X83Ql58xsr
   Ne52EqLMlsgvQzObobQHA8k7TmQObDBIoUHO+ZFbxd/ZOmNqr7dk9xXA1
   g=;
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
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="27125622"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 07:06:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EAF22E020F; Mon, 21 Mar 2022 07:06:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B4241E0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 07:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6VSOtW8uRSASMMYXVQauN2PwQG0mWuKQk2eFJtKsPi8=;
  b=iNl88/5MQLjYLZEjQsI230yIjeTS+kagz92jNObfnr4HqBr4/W4u1FMz
   wR08QOmYnEtYSh5KxK59A28qfh08ijspnu1eF5x+HB+hX7UDCEKKIrQwv
   CBhi52+KsD9/gAuOUw6obUXtHMCaLUS5Oa7RN+Btfq1xfpzuiFkyYw+ko
   I=;
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="9090229"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 07:06:43 +0100
Date: Mon, 21 Mar 2022 07:06:42 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <bc3ed55e-46e6-7ad7-9297-2eea753f24c5@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203210705550.3210@hadrien>
References: <bc3ed55e-46e6-7ad7-9297-2eea753f24c5@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] minus: parse error: around "..."
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 271
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203210705550.3210%40hadrien>



On Sun, 20 Mar 2022, Eric Wheeler wrote:

> Hello,
>
> I'm getting a strange error with this ruleset:
>
> 	@ add_diff_structures @
> 	@@
> 	+void diff_structures();
> 	void New_Frequency(...)
> 	{
> 	    ...
> 	+   diff_structures();
> 	}
> 	...
> 	void Incident_Field_Loop(...) { ... }
> 	+void diff_structures() { }
>
> same error here:
> 	@ add_diff_structures @
> 	@@
> 	...
> 	void Incident_Field_Loop(...) { ... }
> 	+void diff_structures() { }
>
>
> I was able to break it into two rules, but can I not use "..." between
> function bodies?

No.  Coccinelle works on one function at a time.  If you really want to
know if one comes after the other, then you have to record the position of
each function and compare them.

julia
