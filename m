Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4F8C433F5
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=goQByS3ee/dySPS+mk87FkiE0E+UCoDwRpRmGfF/a2E=;
  b=c1z/wJOKJ/WtrHc1HAf83h8LcmrYd4WVmemsTuscolgarWnx2Pjy8uaS
   iN0q72eB4hLoFRow2hFRWavlyTYC4pgXFU0gpCwNtOTgOf2k21OKSTKEg
   PkqbF2pTGwwDSu0MxupS6zN9DrJSq0QI3uFPMGX+psZ3XhM3MZsZRBv1J
   4=;
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
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56681783"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 17:30:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D31FDE02CA; Sun,  9 Oct 2022 17:30:29 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 24E04E0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 17:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=goQByS3ee/dySPS+mk87FkiE0E+UCoDwRpRmGfF/a2E=;
  b=VSD/LDO5g/DuBQGYrB/WRFDCLaSaZBZgho9q7qeDPn1T/rvjoMPtsPwh
   Bn5OzQxmqCWUAWSt7pA7a0iCt1nqejV+U3eZW5nI6h+t9aWJMODRjl/uv
   8Xia1pfJumh3yV9IfcLVH5aEjumCtC1XwqwZFVQlonY//E8gqQ7n5Rgta
   o=;
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="25890634"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 17:30:26 +0200
Date: Sun, 9 Oct 2022 17:30:25 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
cc: cocci@inria.fr, keescook@chromium.org
In-Reply-To: <CAHmME9pzRtsEBFNBvX=j25D8ANUjLHoVxn0fLnFERgr6FR+VfA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210091726280.3091@hadrien>
References: <Y0LiyBxZ0pU+NOPR@zx2c4.com> <alpine.DEB.2.22.394.2210091713270.3091@hadrien> <CAHmME9q_hYvZjSHxHse2fmMrjkFON4vSVESBED3F=y3=+rh2Gw@mail.gmail.com> <CAHmME9pzRtsEBFNBvX=j25D8ANUjLHoVxn0fLnFERgr6FR+VfA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] "reachable by inconsistent control-flow paths"
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 629
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210091726280.3091%40hadrien>



On Sun, 9 Oct 2022, Jason A. Donenfeld wrote:

> On Sun, Oct 9, 2022 at 9:17 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Julia,
> >
> > On Sun, Oct 9, 2022 at 9:15 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > The meaning of the message is that Coccinelle thinks that it is possible
> > > to get to the call that you have changed without going through the u16 v
> > > declaration.
> >
> > Huh, okay. That seems like a bug then?
>
> If I remove the `#if IS_ENABLED(CONFIG_NF_CT_PROTO_GRE)` and the
> `#endif`, then it works!

Ah.  There is indeed probably a bug somewhere.

Would the following work for you?

@@
identifier get_random_u32 =~ "get_random_int|prandom_u32|get_random_u32";
typedef u16;
local idexpression u16 v;
@@
-  v = get_random_u32();
+  v = get_random_u16();

It would be faster and completely avoid the problem.

You only need "local" is you want to ensure that v is a local variable.

If you don't care at all about what form v has, you can put

u16 v;

julia
