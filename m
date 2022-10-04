Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7813DC433F5
	for <cocci@archiver.kernel.org>; Tue,  4 Oct 2022 11:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=A/+u3q0BC7eTQKQ42yD4RaTfNN9a85ckB9XI5JUri9M=;
  b=RhWyjHgCskinP98Z9VvkbkHZVqCSRrSXwG6bLNN5aqFG+Op/yL74He7q
   JPEre95BxDQ6hYIUucBSH8s+zcJLR+HJiHstkojQD6u0xERIlXzxhCrBQ
   JkP1oUkQfB2yT3n3wyh6sWc1GAlf8IN52shK/OYLz8J/cuW6rYRMsNd5T
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
X-IronPort-AV: E=Sophos;i="5.93,157,1654552800"; 
   d="scan'208";a="55889289"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Oct 2022 13:50:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4D617E028F; Tue,  4 Oct 2022 13:50:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 37276E0076
	for <cocci@sympa.inria.fr>; Tue,  4 Oct 2022 13:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=A/+u3q0BC7eTQKQ42yD4RaTfNN9a85ckB9XI5JUri9M=;
  b=Pfg1XdRFUCQsI78ac3UJH/o33ORTpTdclK+RBsNJJhrMLibVybRRA3I9
   BHBh0wLVrsUduQ0/n0f+zCOY59Ho9xIi2SY6EXZ/jNQQ1SxnhxTLS8XPk
   PVn3O857JZoxYEua4Rz0oCO35OlJyU6kuElH23HIlJTVPAyWNGm0Gh/pm
   E=;
X-IronPort-AV: E=Sophos;i="5.93,157,1654552800"; 
   d="scan'208";a="55889283"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 13:50:09 +0200
Date: Tue, 4 Oct 2022 13:50:09 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
cc: cocci@inria.fr
In-Reply-To: <b5d97968-b1c6-191d-e4c0-662416e8bb90@linbit.com>
Message-ID: <7fe73435-8fdc-fc89-6327-c0a3e245e53@inria.fr>
References: <b5d97968-b1c6-191d-e4c0-662416e8bb90@linbit.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-682023681-1664884209=:16068"
Subject: Re: [cocci] Matching against struct_group()
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 614
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/7fe73435-8fdc-fc89-6327-c0a3e245e53%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-682023681-1664884209=:16068
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 4 Oct 2022, Christoph Böhmwalder wrote:

> Hi all,
>
> say I would like to replace an instance of the struct_group macro in the
> Linux kernel:
>
> 	struct_group(algs,
> 		char verify_alg[SHARED_SECRET_MAX];
> 		char csums_alg[SHARED_SECRET_MAX];
> 	);

The corresponding C code is not parsed.  I will check whether this can be
integrated without introducing parse conflicts.

julia

>
> I'm guessing this is not supported by coccinelle because of the
> "unusual" syntax? I tried specifying struct_group as a "declarer", but
> that did not work (which does not surprise me because it's not really a
> declarer anyway).
>
> Is there any way I can still make this match?
>
> Thanks.
>
> --
> Christoph Böhmwalder
> LINBIT | Keeping the Digital World Running
> DRBD HA —  Disaster Recovery — Software defined Storage
>
--8323329-682023681-1664884209=:16068--
