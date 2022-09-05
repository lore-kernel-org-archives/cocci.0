Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF41ECAAD5
	for <cocci@archiver.kernel.org>; Mon,  5 Sep 2022 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=pJAK2sGFKwxGp6Xvp7Xwhl82abOJfJbN9dRMJe2JNI8=;
  b=Hi5chM9zOxWg683ZIZ1r1AgM49MEEfZAI/L6iy4XUp6m9Q2uJQAF0O6F
   usCWzkwtbCnDsJbJtIdvIOm6kaQ30rOVuBNpBOc5Nqcby2NtwolkZ3CKk
   uxDXbhLTeVK65mQUQGqmiWVnBtZfR61mruXN45gY56e3mI2/uBqjoYWYi
   A=;
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
   d="scan'208";a="51389218"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2022 18:03:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8ADB3E779D; Mon,  5 Sep 2022 18:03:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B4AECE015F
	for <cocci@sympa.inria.fr>; Mon,  5 Sep 2022 18:03:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pJAK2sGFKwxGp6Xvp7Xwhl82abOJfJbN9dRMJe2JNI8=;
  b=SHOhmAQJO1C8g4rqFOvd8dv/IAI/72VCS+vcS8XmIMOcxjLxhbdZWpao
   xVJ3fKgPBgZ6sqNwmVjqKU7M/8Ak8udfq8iv3WZoNmt/Of2GDM2NgIab/
   g+j/TGJzcRM4KQxKHzZfacnp+fuFpBhRTpAt8SnVxJGUszktqhTvJKG4/
   w=;
X-IronPort-AV: E=Sophos;i="5.93,291,1654552800"; 
   d="scan'208";a="51389208"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 18:03:38 +0200
Date: Mon, 5 Sep 2022 18:03:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jan Tojnar <jtojnar@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAFGSp1vuGyiT86c7vq9MmYWaP06vRLo4OLQTREpHK_fw8vfEyg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2209051757150.2731@hadrien>
References: <alpine.DEB.2.22.394.2209050952300.2731@hadrien> <20220905090915.3569051-1-jtojnar@gmail.com> <alpine.DEB.2.22.394.2209051246490.2731@hadrien> <CAFGSp1ud+X_xHa4zwhwPEzOvoC+4zwmONLi5HCQn76WHzfwoHQ@mail.gmail.com> <alpine.DEB.2.22.394.2209051427090.2731@hadrien>
 <CAFGSp1umoczUe4npSesAUOLgSq=9VkvLUOV3x1hSvSajqQkGfw@mail.gmail.com> <alpine.DEB.2.22.394.2209051445570.2731@hadrien> <CAFGSp1vuGyiT86c7vq9MmYWaP06vRLo4OLQTREpHK_fw8vfEyg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 545
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209051757150.2731%40hadrien>

The proposed behavior seems basically ok.  It seems to have no impact if
one is not writing things to files.

But I wonder why not just check for !patching_failed before calling
generate_outfiles, and then putting the choice of exit status after the
whole "Main results analysis" block?

I don't think that the keep going flag is a good idea.  It makes it sound
like that, without it, as soon as spatch fails on one file, it aborts
completely.

The correct patching_failed value is indeed not seen in the case of parmap
because modifications are not propagated back to the caller.  One has to
add the value to the result.

julia
