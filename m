Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB106606A321
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=E3s/I5sF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ml0oE2zkxsYGJ5ElVjtjdziVRyeAojin+9iF0Sqx49Q=;
  b=E3s/I5sFa5WSGMuacA1oX+JAzdJym1bLdF0qiiX8wL8WRFydBjzSgneJ
   iNQ1Ei8RiaTTvuRgON2QHvr/uZY8SM69KcxDXlk3J98f5Vo6k0TySt9+b
   d9oXSai5O73K7cqkyoQwTQfpE7p5FFB/6NF+zWYVCcUtN2AapG7iL72eg
   Y=;
X-CSE-ConnectionGUID: gBVQ36sDTd6ua/DM4HhaMg==
X-CSE-MsgGUID: C64BBju4RwqcFaOs3ZdpEw==
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
   d="scan'208";a="305109804"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 15:44:36 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C392781C44; Thu, 12 Nov 2026 15:44:36 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 100308145C
	for <cocci@sympa.inria.fr>; Thu, 12 Nov 2026 15:44:34 +0100 (CET)
X-CSE-ConnectionGUID: P8yoCLctQO+dG2OliLaf0A==
X-CSE-MsgGUID: rzOYRYYMRFW+U3UL15T4Dw==
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305109787"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 15:44:34 +0100
Date: Thu, 12 Nov 2026 15:44:33 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: picca <picca@debian.org>
cc: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
In-Reply-To: <28c028e839449a1bc8236acc9707cb32@debian.org>
Message-ID: <7d6f4f-8a8e-b7f2-2b91-5176a1fbf376@inria.fr>
References: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org> <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr> <45e0468b84f19a5d75ea99fb434113c0@debian.org> <0faa3236-0ab2-45d3-953e-6168ce6c8d76@inria.fr> <0e99b58f1f63d6ff89889c6f132d4e2e@debian.org>
 <e94be607-8aeb-493b-8dec-8415e05551b1@inria.fr> <28c028e839449a1bc8236acc9707cb32@debian.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-457420516-1794494674=:3964"
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3801
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/932ZwUHIL0_3Qd5EzvN9jA>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-457420516-1794494674=:3964
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

At least try INLINES

julia
--8323329-457420516-1794494674=:3964--
