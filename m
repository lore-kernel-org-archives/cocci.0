Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC32606A334
	for <cocci@archiver.kernel.org>; Tue,  3 Nov 2026 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=UCRmmJWW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=e4BowQ+amK38o//s4NxPBalFr8cpFlq9Zh+O3SwU0ZI=;
  b=UCRmmJWW+h4BLBXc6UBG8jxFs9cCjIvIm1uuoRvzinEVZK4RpMtaBztl
   Nti1DUXxbge/2+3mlwvVlPDK5UQYO1q2utB+Q7Ob6gEzKTh6Uamg0gbO0
   XnSfGv0KiRxJR0griqKcSZe4RZeNFR257RBs+CBsnEP/Lzjcx4M+ekMsp
   M=;
X-CSE-ConnectionGUID: rOzXVh3nRr2UMqyyhSdNhA==
X-CSE-MsgGUID: EdQXOQQ5Q1m2i2B+ky2ZZA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,193,1787004000"; 
   d="scan'208";a="303537845"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2026 11:40:35 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A04B681E4A; Tue,  3 Nov 2026 11:40:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2D21681DB4
	for <cocci@sympa.inria.fr>; Tue,  3 Nov 2026 11:40:34 +0100 (CET)
X-CSE-ConnectionGUID: SC95fYGpQZWvGPBNN6q0gw==
X-CSE-MsgGUID: N6K//vBCRaiQC+RyUl3sHg==
X-IronPort-AV: E=Sophos;i="6.27,193,1787004000"; 
   d="scan'208";a="161600837"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 11:40:34 +0100
Date: Tue, 3 Nov 2026 11:40:33 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Kees Cook <kees@kernel.org>
cc: Joe Perches <joe@perches.com>, Greg KH <gregkh@linuxfoundation.org>, 
    linux-kernel@vger.kernel.org, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    driver-core@lists.linux.dev, Nicolas Palix <nicolas.palix@imag.fr>, 
    cocci@inria.fr
In-Reply-To: <202611021747.3BD1EB4D@keescook>
Message-ID: <491ec0d4-f85-e8c6-e59a-6c9ccc84e0@inria.fr>
References: <9b55b3e3269ef43ede64fff34f42121f7aa47979.camel@perches.com> <1a6026c4-3e19-a1a9-e637-f1842172482b@inria.fr> <E7A57F75-AB90-4B41-B942-55D65F2B65D8@kernel.org> <c47392bc-e522-19b6-a653-1e85b44cefba@inria.fr> <202611021747.3BD1EB4D@keescook>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [resend PATCH] coccinelle: Add devm_kmalloc_objs
 conversion script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3762
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/8VvjeQJsNaJyQ7dV_x0R4A>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, 2 Nov 2026, Kees Cook wrote:

> On Mon, Nov 02, 2026 at 10:09:21AM +0100, Julia Lawall wrote:
> > On Mon, 2 Nov 2026, Kees Cook wrote:
> > > On November 1, 2026 3:51:53 PM PST, Julia Lawall <julia.lawall@inria.fr> wrote:
> > > >
> > > >
> > > >On Sun, 1 Nov 2026, Joe Perches wrote:
> > > >
> > > >> Like commit bdc5071d7f7b ("coccinelle: Add kmalloc_objs conversion script")
> > > >> with commit 1c7bbaeed110 ("coccinelle: kmalloc_obj: Remove default GFP_KERNEL arg")
> > > >>
> > > >> Finds and converts sized devm_kmalloc-family of allocations into the typed
> > > >> devm_kmalloc_obj-family of allocations.
> > > >
> > > >Applied
> > >
> > > Please don't send this. I already did this. See the PR I sent for rc1:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=for-linus/v7.4-rc1/devm_kmalloc_obj
> >
> > Too late.
>
> I don't want the rules duplicated, though. It should be a single set...

I guess I can send another pull request to remove the rule I added?

julia

>
> --
> Kees Cook
>
