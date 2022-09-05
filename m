Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B353CECAAD3
	for <cocci@archiver.kernel.org>; Mon,  5 Sep 2022 20:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=BwKFyOl7J+fDzjFAk73n5649wJASzx3UFadFZCVo3XQ=;
  b=cHkjzMiAlJa59nt7n5ZwSbiPfKQWdpahqDUA1uWCyIWdtozFyKf8s3DE
   bVAoCRI9ChTqC9e7srSGIuo80dBweP1639tFQj0sbJIdwFWjZhjJbmL+x
   d1nb0Ua4W+QNNQQn3bfTxpIXebqMe6H4+GOe0UgorsXg+TNsWPZSL4aEE
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
X-IronPort-AV: E=Sophos;i="5.93,292,1654552800"; 
   d="scan'208";a="51410484"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2022 22:35:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7C7F9E779D; Mon,  5 Sep 2022 22:35:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C65B0E015F
	for <cocci@sympa.inria.fr>; Mon,  5 Sep 2022 22:35:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=BwKFyOl7J+fDzjFAk73n5649wJASzx3UFadFZCVo3XQ=;
  b=N67UHb28kblLHp1g0uIpP7tXIO9iceKS55SNflmB/yf3BNy3RUEwQ6iu
   snvnKZ0/6I/2Jt07BkcvVEehQk0aXj80SIYHs6QAJN9L0gQe/eDyZddJp
   Qe5ofGCtbwxD8/VH/6pgdcS3ycpsJgDnTyrvMAe41ceBu6bEqhxr8tmYn
   s=;
X-IronPort-AV: E=Sophos;i="5.93,292,1654552800"; 
   d="scan'208";a="51410483"
Received: from 152.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.152])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 22:35:30 +0200
Date: Mon, 5 Sep 2022 22:35:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jan Tojnar <jtojnar@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAFGSp1vDA7DBgmtQeYu255M_e9zQYCPVAryL15OikEz+Rf1qyQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2209052231030.3611@hadrien>
References: <alpine.DEB.2.22.394.2209050952300.2731@hadrien> <20220905090915.3569051-1-jtojnar@gmail.com> <alpine.DEB.2.22.394.2209051246490.2731@hadrien> <CAFGSp1ud+X_xHa4zwhwPEzOvoC+4zwmONLi5HCQn76WHzfwoHQ@mail.gmail.com> <alpine.DEB.2.22.394.2209051427090.2731@hadrien>
 <CAFGSp1umoczUe4npSesAUOLgSq=9VkvLUOV3x1hSvSajqQkGfw@mail.gmail.com> <alpine.DEB.2.22.394.2209051445570.2731@hadrien> <CAFGSp1vuGyiT86c7vq9MmYWaP06vRLo4OLQTREpHK_fw8vfEyg@mail.gmail.com> <alpine.DEB.2.22.394.2209052150160.3611@hadrien>
 <CAFGSp1vDA7DBgmtQeYu255M_e9zQYCPVAryL15OikEz+Rf1qyQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1446728934-1662409869=:3611"
Content-ID: <alpine.DEB.2.22.394.2209052231110.3611@hadrien>
Subject: Re: [cocci] [PATCH v2] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 548
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209052231030.3611%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1446728934-1662409869=:3611
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2209052231111.3611@hadrien>



On Mon, 5 Sep 2022, Jan Tojnar wrote:

> On Mon, 5 Sept 2022 at 21:51, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > The patch has been applied, followed by another one that dropped th e
> > --keep-trying option and that addresses the parmap issue.
>
> Thanks, that will work for us, except that you probably accidentally
> made it so that patching only happens when a failure occurs – there
> should be `not` before `patching_failed` on this line:
> https://github.com/coccinelle/coccinelle/blob/5448bb2bd03491ffec356bf7bd6ddcdbf4d36bc9/enter.ml#L1419

Oops, thanks for noticing it.  It will be fixed shortly.

>
> Additionally, it looks like you keep introducing more tab characters
> into the indentation, resulting in mixed tabs and spaces. This makes
> diffs more noisy than necessary and the code can end up displayed
> misaligned in some text editors.
>
> May I suggest adding the following .editorconfig file to the root of
> the repository? Hopefully, your editor has support for that standard
> and will use consistent formatting:
> https://editorconfig.org/#pre-installed
>
> root = true
>
> [*]
> end_of_line = lf
> insert_final_newline = true
>
> [*.{ml,mli}]
> indent_style = space
> indent_size = 2
> tab_width = 8

Not so clear what the impact of this is.  I prefer tabs to be used when
possible.

julia
--8323329-1446728934-1662409869=:3611--
