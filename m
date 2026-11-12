Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6588606A33D
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=Wp9qAgFT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ntiB7iY8WPIQuHUVLhpqnT55xO+APLhDPR4cdcOnCfQ=;
  b=Wp9qAgFTR+bPGD+UPiTisw/4tKxr8uN+In/QrL8xzOuMtBqM5wZiQe05
   E+1Ng7k0CfVDc+s2ct1AttyWwfrSgflq+yAnpoRTnNz+35afB1ePpNB/M
   bZ84DjXlx8UIRuLFJL7de9vaCO6OkRd5mV39HTwfDx1XGiKqlpgdg85MW
   g=;
X-CSE-ConnectionGUID: xFGg5WekQIOhWkC9bmmu3w==
X-CSE-MsgGUID: iSYBu237SnOgRJMYm8azVg==
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
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305109619"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 15:43:52 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6167F81C26; Thu, 12 Nov 2026 15:43:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2C88D81BD8
	for <cocci@sympa.inria.fr>; Thu, 12 Nov 2026 15:43:50 +0100 (CET)
X-CSE-ConnectionGUID: crUQbRP2T3epLb081iYCxw==
X-CSE-MsgGUID: 0ZHa8EOFQAyK7nwK3updUQ==
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="162475824"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 15:43:50 +0100
Date: Thu, 12 Nov 2026 15:43:49 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: picca <picca@debian.org>
cc: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
In-Reply-To: <28c028e839449a1bc8236acc9707cb32@debian.org>
Message-ID: <a8689dda-5e4b-10aa-7cd5-40fdb7a811ba@inria.fr>
References: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org> <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr> <45e0468b84f19a5d75ea99fb434113c0@debian.org> <0faa3236-0ab2-45d3-953e-6168ce6c8d76@inria.fr> <0e99b58f1f63d6ff89889c6f132d4e2e@debian.org>
 <e94be607-8aeb-493b-8dec-8415e05551b1@inria.fr> <28c028e839449a1bc8236acc9707cb32@debian.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-725850133-1794494629=:3964"
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3800
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/mph8YQaHlI7kHKoDSVf9lw>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-725850133-1794494629=:3964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 12 Nov 2026, picca wrote:

> Le 2026-11-12 13:29, Victor Gambier a écrit :
> > Thank you. I cannot reproduce the error. Could you send me the file
> > "hkl/ccan/array_size/array_size.h", as well as the output of `spatch
> > --version`?
> >
> > Victor
> >
>
> If I rename the INLINE global variable into -> inlines, the error goes away.
>
> capital letters issue ?

I doubt it.  But try what I suggested with standard.h

julia
--8323329-725850133-1794494629=:3964--
