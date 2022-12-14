Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DD2C4332F
	for <cocci@archiver.kernel.org>; Wed, 14 Dec 2022 20:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=yAJ+KBideAmcVq3hbJTbN7tL14yiARwXw2znMET9XRg=;
  b=PGcPNJ13V2xTlZ4kg0sJaTVaCMCuhiC2plynkF6s0Sb9gLQhs7ph9fjx
   ane1CUF6j0FPRZdKqnfC6gK4PD7kBhTR7nTU1pnkI7Myf0w0fLy5bIacy
   FBbpfw9g40viVCPgExswuZQScl3qtbHvpt21+1Vn1AT06A9eh/V4fy21E
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
X-IronPort-AV: E=Sophos;i="5.96,245,1665439200"; 
   d="scan'208";a="83453138"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Dec 2022 21:46:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E03BDE0138; Wed, 14 Dec 2022 21:46:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7EF5DE0128
	for <cocci@sympa.inria.fr>; Wed, 14 Dec 2022 21:46:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yAJ+KBideAmcVq3hbJTbN7tL14yiARwXw2znMET9XRg=;
  b=rH0EBp+Tnt9X76QcwOJJYTwSvt05dyEu5XM0PGmdeuqixk0eSbxN2nzH
   mjmLAx9AQ+hJ9L21mTUrAWhmO9sUIpt3Fg35SbpuKvW3NTjC/wDWlTiOe
   tYVRCkB6azF/IOojugTgF3BXMpa9z9dITFYJ2mGNaQBFKC0ZxfcF4Vgw0
   M=;
X-IronPort-AV: E=Sophos;i="5.96,245,1665439200"; 
   d="scan'208";a="42672488"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 21:46:44 +0100
Date: Wed, 14 Dec 2022 21:46:42 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Andrzej Hajda <andrzej.hajda@intel.com>
cc: cocci@inria.fr
In-Reply-To: <c2cb22fd-81aa-a27b-7ac7-77ee8bf74e11@intel.com>
Message-ID: <alpine.DEB.2.22.394.2212142146140.2928@hadrien>
References: <c2cb22fd-81aa-a27b-7ac7-77ee8bf74e11@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1817764018-1671050803=:2928"
Subject: Re: [cocci] Another space oddity
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 778
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/alpine.DEB.2.22.394.2212142146140.2928%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1817764018-1671050803=:2928
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 14 Dec 2022, Andrzej Hajda wrote:

> Hi,
>
> I have found another strange space/newline behavior when changing iterator
> loops:
> Following script:
> @@
> iterator name for0;
> @@
>         for0()
> -       {
>                 0;
> -       }
>
> @@
> iterator name for0;
> @@
>         for0()
> -               { 1; }
> +               1;
>
> @@
> iterator name for0;
> @@
> -       for0() { 2; }
> +       for0() 2;
> -----------
> On file:
> int f() {
>         for0() {
>                 0;
>         }
>
>         for0() {
>                 1;
>         }
>
>         for0() {
>                 2;
>         }
> }
> Produces output:
> int f() {
>         for0()
>
>                 0;
>
>         for0() 1;
>
>         for0 ()
>                 2;
> }
> ---
> Ie. in cases:
> 0 - it adds extra line,
> 1 - removes existing line,
> 2 - produces correct output, but modifies iterator header (I would like to
> avoid, extra space between for0 and '('.
>
> I would expect 0 and 1 produce correct indentation in 0 and 1, is it possible
> to fix it?

Thanks for the report and the nice small examples.  I will look into it.

julia
--8323329-1817764018-1671050803=:2928--
