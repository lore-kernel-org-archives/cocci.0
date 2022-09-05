Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86577ECAAD5
	for <cocci@archiver.kernel.org>; Mon,  5 Sep 2022 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=FyGUT/q0o+wfiuIyAgSqsn3T1o17mX4auqQ4bKHbOq0=;
  b=XkeZftSl3WeW4Pn4D8bxOaBKx2xsE0iqCRoQlR/hlScwUpE0o0s/1Az6
   Rp8LQknCWIw5QFnBEArXEo44Hr0yAl1zAQ/4trgwePINL+RFutOXyvxyb
   LRdhlDq8S6lsJ/KKCmRTgD5UgPuHFvqJE43sucEmJHOxX1J+sN5fFuuc5
   k=;
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
X-IronPort-AV: E=Sophos;i="5.93,291,1654552800"; 
   d="scan'208";a="51343026"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2022 14:51:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9A560E779C; Mon,  5 Sep 2022 14:51:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5E048E015F
	for <cocci@sympa.inria.fr>; Mon,  5 Sep 2022 14:51:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FyGUT/q0o+wfiuIyAgSqsn3T1o17mX4auqQ4bKHbOq0=;
  b=fL4hFpA57129R0Bi11JjYfroPoZPlMoxpRtXzPMDQz3dCxRI+QTlKo8d
   CFxTwBcdK9mjFpJN1/2+Rh5MGFETdU9K7TPHxQh5zmK36RZhHVXENkxLm
   pXjfcpwE1gaYQ7O6OzK+Wlb1MVRXvS3JA5rJZzfx9MQGINz3NHlhD9ZjK
   c=;
X-IronPort-AV: E=Sophos;i="5.93,291,1654552800"; 
   d="scan'208";a="22881387"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 14:51:56 +0200
Date: Mon, 5 Sep 2022 14:51:55 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jan Tojnar <jtojnar@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAFGSp1umoczUe4npSesAUOLgSq=9VkvLUOV3x1hSvSajqQkGfw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2209051445570.2731@hadrien>
References: <alpine.DEB.2.22.394.2209050952300.2731@hadrien> <20220905090915.3569051-1-jtojnar@gmail.com> <alpine.DEB.2.22.394.2209051246490.2731@hadrien> <CAFGSp1ud+X_xHa4zwhwPEzOvoC+4zwmONLi5HCQn76WHzfwoHQ@mail.gmail.com> <alpine.DEB.2.22.394.2209051427090.2731@hadrien>
 <CAFGSp1umoczUe4npSesAUOLgSq=9VkvLUOV3x1hSvSajqQkGfw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 543
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209051445570.2731%40hadrien>



On Mon, 5 Sep 2022, Jan Tojnar wrote:

> On Mon, 5 Sept 2022 at 14:29, Julia Lawall <julia.lawall@inria.fr> wrote:
> > Furthermore, the original use of Coccinelle was to create a patch, not to
> > update the file.  One can update the file using the patch afterwards, if
> > the result is satisfactory.
>
> Right, that was what I was doing as well. The spatch command succeeded
> and the patch looked fine at a glance. Only later, I noticed that the Python
> script failed on some files and the resulting patch was incomplete.
>
> So my motivation for this patch submission is avoiding this situation
> in the future,
> by always returning with exit status and not producing any patches/changes
> when some file fails, unless user explicitly requests the partial result
> with --keep-going flag.

But Coccinelle is not so fast.  It would be unfortunate to run it for
several hours on something complex, have it fail in one case, and get no
feedback at all.

I think you want some python function that aborts in a more aggressive
way, not to have that be the default behavior.

Most of the time when Coccinelle doesn't do what you want, it is because
the semantic patch is doing something, but it is just designed in the
wrong way.  Not because of something that Coccinelle will perceive as an
error.  So I think that an exit error status is of limited usefulness.
But it could happen that some script code is written badly, such that some
input values cause a crash.  I'm not sure at all that that means that one
doesn't want to see any information about all of the other cases where the
semantic patch applied.

Maybe a --crash-on-script-failure option would be reasonable.

julia
