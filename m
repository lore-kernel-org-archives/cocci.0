Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AB9C54EE9
	for <cocci@archiver.kernel.org>; Thu, 22 Sep 2022 12:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lPloPoZbJjPIgb5mArkM29FxJyDIFGPUMK34rQ1f3EU=;
  b=cGP6voBZWX7tbufLPBmYqWAzx5243cfB0O/Q+9OUoIrkq6/yyoOtkWRc
   KtlMR3zs53po0GYBgr0CPu84xpTN6+CuQnL8j6PqIDJckb5cKepadPouR
   pBKE2sHm50sJU/didAnTu8xVD077Lf00mVWnyveuY6W44e7uUwKgmia/Z
   E=;
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
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="54036319"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2022 14:27:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 06041E0235; Thu, 22 Sep 2022 14:27:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 26335E0090
	for <cocci@sympa.inria.fr>; Thu, 22 Sep 2022 14:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lPloPoZbJjPIgb5mArkM29FxJyDIFGPUMK34rQ1f3EU=;
  b=Wiipb0ePkikHeaNMl5Xhz7wVgpGvtIqrARmvuBvJ285m/xwal610TPaF
   pKef0atjqRK3WQ7X51CXY5f4ipoR1C98r10xPNL/QgMyJmbXvdAdu77HY
   FYD4DXKDr5GFMBJ/vAKlKtRYlKVtCFRI6YzLUoWXuN2KxkAAWE9J2m2nT
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="24408251"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:27:25 +0200
Date: Thu, 22 Sep 2022 14:27:24 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Yuan Can <yuancan@huawei.com>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
In-Reply-To: <1a6f854f-cf97-3f69-a897-cf92328de986@huawei.com>
Message-ID: <4e1f7b6-5c3f-6973-fdd8-6d294a841d26@inria.fr>
References: <20220920025820.105924-1-yuancan@huawei.com> <0896e030-5060-08e7-d0de-c63d77c9ef27@web.de> <alpine.DEB.2.22.394.2209202211430.2740@hadrien> <92f6a7e6-cfbb-ee05-bbdd-dfa4c9abad4f@web.de> <1a6f854f-cf97-3f69-a897-cf92328de986@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-896390314-1663849644=:3846"
Subject: Re: [cocci] [v2 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 566
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/4e1f7b6-5c3f-6973-fdd8-6d294a841d26%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-896390314-1663849644=:3846
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 22 Sep 2022, Yuan Can wrote:

>
> 在 2022/9/21 4:24, Markus Elfring 写道:
> > > > > +@r3@
> > > > > +identifier s, fld;
> > > > > +position p != {r2.p};
> > > > Why do you think that such a SmPL constraint would be required?
> > > >
> > > >
> > > > > +@@
> > > > > +
> > > > > +struct s {
> > > > > +  ...
> > > > > +  struct mutex fld@p;
> > > > > +  ...
> > > > > +};
> > > > Why would the source code search repetition matter here?
> > > He is searching for a structure that is different from the ones matched
> > > previously.
> > How many mutexes (or spin locks) should be initialised before further data
> > processing can be safely performed with corresponding structures?
>
> In my opinion, every mutexes and spin locks needs to be initialised before
> use.

I think that the concern is that you require that some spinlock is
initialized in the file before you are able to find one that is not.  It
could be good to check this with an artificial test case.

julia
--8323329-896390314-1663849644=:3846--
