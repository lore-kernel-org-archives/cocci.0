Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BF1C433F5
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=1MVvgQxnDPK4a2+A9y4KANXK3lm+DXo1qyVC24Es+OI=;
  b=ZianETw48FO4w+tkjbmb0zAT759TAvOEx9bfVYBi5Q3qLBxx8SWxIpxh
   aLtu5UKL+Tsr8vWGD5WX0sGHmxJNmUvxe1veFRqTW3n+/uM7Cq4bb9bXm
   dlT2u2ruLT7e1v/U9Q1LLD35M1XBihaYA4bJgM2dYgmWKpYZ7uIdHt2c3
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25870145"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 18:22:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9602EE006C; Sun, 13 Mar 2022 18:22:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F1F0CE0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 18:22:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1MVvgQxnDPK4a2+A9y4KANXK3lm+DXo1qyVC24Es+OI=;
  b=HrtqCJ4EVLIwEqMSqYVFGLl8Cr0JtfspQywVWUAtZf7cOxY0ZhtBDig1
   AWb6176U7WPs4+oLmE2Ep2rte03G+1eMRTj3geq9mbfb/4Cu6WJPFpEV5
   qrSS8Dlp2sCh3gzMAnpOttDasRalIhy5Z+7CFxd93x212RjEJp6AwwmBb
   E=;
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="8405052"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 18:22:10 +0100
Date: Sun, 13 Mar 2022 18:22:10 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
In-Reply-To: <c415341b-70c4-2bc7-b067-39c273ace958@web.de>
Message-ID: <alpine.DEB.2.22.394.2203131821210.18925@hadrien>
References: <818d2b72-e28a-ba5e-661c-cba9fe9914ca@web.de> <70ad3def-a4f-14b4-cb70-acfe4a516d9b@ewheeler.net> <c415341b-70c4-2bc7-b067-39c273ace958@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-300299687-1647192130=:18925"
Subject: Re: [cocci] Checking the isomorphism =?UTF-8?Q?=E2=80=9Cptr=5Fto?=
 =?UTF-8?Q?=5Farray=E2=80=9D?=
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 221
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203131821210.18925%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-300299687-1647192130=:18925
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 13 Mar 2022, Markus Elfring wrote:

>
> > Here are some other equivalent transforms I can think of for E1->fld where
> > E2 == 0.
> …
> > E1->fld = (E1++)->fld  // but not ++E1
>
>
> I find that this idea does not refer to an equivalent transformation for such an expression
> because increment and decrement operators modify their corresponding object.
>
>
> I would expect that the object should be kept unmodified under all circumstances
> and independent from special values in this use case.
> (Such a transformation might look interesting if you would like to take dynamic constraints
> better into account accordingly.)
>
>
> Thus I propose to delete the specification “ptr_to_array” from the file “standard.iso”
> so that only safe source code searches and adjustments will be performed.

Te idea of an isomorphism is that one may related X and Y if transforming
one means that one would likely want to transform the other too.  It
doesn't mean that X and Y are semantically equivalent.

julia
--8323329-300299687-1647192130=:18925--
