Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C993BC4321E
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=a/tu4vjgPs+JMecKRUmMPlhBZ6HTv1/qoAwNk3q9OfU=;
  b=SSakpCXTxrg5l4mwVra0IlNxcjA/4PsRqtJYFg7ExjP05m6rsHNwe4Bi
   24lr3+mSLr1wNPPGLX385nHlxPdMUNqJDlzyu3oJwfl3ThTrE+vkamK3V
   FDkqCpm+ksSnDxhb8icoltiLFo3xX04zhPvvVQCIyzTjimETBxsAONKXO
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
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81595904"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 15:02:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0A193E0235; Sun,  4 Dec 2022 15:02:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B7A87E013A
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 15:02:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=a/tu4vjgPs+JMecKRUmMPlhBZ6HTv1/qoAwNk3q9OfU=;
  b=Y+D827FSXVQCtfE2wc8fxLWuNCOGZMOB7W4gdYslapkgujXCr+Peb+Kq
   sZ7Y4kvl1CpErFG8Y6iG5VkiF1sDlCX742X4fU4aMH+Wq1EtFTRg2iCGY
   Y3P1kJrhBFChkCGWvs4y5ZOgoJPwX2ztfRwjc3uIVXX/m863iY/krGQ/L
   g=;
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81595903"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 15:02:39 +0100
Date: Sun, 4 Dec 2022 15:02:39 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Derek M Jones <derek@knosof.co.uk>
cc: cocci@inria.fr
In-Reply-To: <414c04de-1014-d41d-dfb6-774a8666f22e@knosof.co.uk>
Message-ID: <alpine.DEB.2.22.394.2212041501550.3337@hadrien>
References: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk> <alpine.DEB.2.22.394.2212040832050.3337@hadrien> <b404ba8b-df56-1f22-c0c4-a3d3be6aea30@web.de> <414c04de-1014-d41d-dfb6-774a8666f22e@knosof.co.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Clarification for SmPL search techniques
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 769
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/alpine.DEB.2.22.394.2212041501550.3337%40hadrien>



On Sun, 4 Dec 2022, Derek M Jones wrote:

> Markus,
>
> > > > I' having the usual problem that occurs when using Coccinelle
> > > > after a long time away, I cannot find the example I need
> >
> > Would you get any further development ideas from information in mailing list
> > archives
> > or issue trackers?>
>
> The problem is that a lot of information is duplicated.
>
> I'm probably going to be using Coccinelle a lot next year,
> and will write a verbose cheat sheet of ideas (as much for
> me as anyone else).
>
> I think a lot more people would use Coccinelle if it had
> more documentation.

If you write something that you think others would find helpful, feel free
to send it along, and we can add it to the web page.

thanks,
julia
