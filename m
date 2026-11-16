Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53262606A31C
	for <cocci@archiver.kernel.org>; Mon, 16 Nov 2026 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=NtxQuLU6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OOiASFFjF9pJ/tAM9kTFUnZbsb0jBth4K15WZzRSaek=;
  b=NtxQuLU6mwg/BETB48nXw+WvTHqAnTG9a799E9jxKfZifhKJBYzSeuEK
   Ljyso72GJkRovKb9s6IEjEcxlL4bVOHoZacCfnfWmEABsm3G3wi+Xk+1X
   VTUg5TjOQ/nFl26Cxz/+GNx8vTGrOF3MBg8Pndx36N4PllsaSpkR2Ed10
   Y=;
X-CSE-ConnectionGUID: rWJ1E6BxQ6iSAjqnFKP6OA==
X-CSE-MsgGUID: mkXWDE5DQWWWGp7dsnWt/Q==
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
X-IronPort-AV: E=Sophos;i="6.27,216,1787004000"; 
   d="scan'208";a="305648677"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2026 15:59:14 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0771A820A1; Mon, 16 Nov 2026 15:59:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2E857820A6
	for <cocci@sympa.inria.fr>; Mon, 16 Nov 2026 15:59:09 +0100 (CET)
X-CSE-ConnectionGUID: jXUMCtDNT5eQ596OF4d9rQ==
X-CSE-MsgGUID: ff36KtDfQZyUzn+U8WI4fg==
X-IronPort-AV: E=Sophos;i="6.27,216,1787004000"; 
   d="scan'208";a="305648533"
Received: from 72-255-236-003.static.imsbiz.com (HELO hadrien) ([72.255.236.3])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 15:59:07 +0100
Date: Mon, 16 Nov 2026 22:59:05 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: picca <picca@debian.org>
cc: cocci@inria.fr
In-Reply-To: <2d228ae9f4244ff6f84d036f5c0f531f@debian.org>
Message-ID: <627726ed-5ba7-1897-c95-2469da10c06b@inria.fr>
References: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org> <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr> <b4048ae138808c03693d43cd183c7ab8@debian.org> <f7e0d31a-d8a5-cdb7-9cd0-998511f1216c@inria.fr> <2d228ae9f4244ff6f84d036f5c0f531f@debian.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-834200862-1794841148=:3305"
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3809
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/Zr1lANfvJXN10vJG1GApYg>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-834200862-1794841148=:3305
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 16 Nov 2026, picca wrote:

> Le 2026-11-13 23:07, Julia Lawall a écrit :
> > The macros in standard.h get expanded before any other processing.
>
> ok
>
> > Some options:
> >
> > * We remove the #define INLINE inline in standard.h
> > I don't know if anyone is relying on this macro.
>
> What is the purpose of standard.h ?

It gives macro definitions that are expected to be useful, but in pratice
are probably mostly useful for the Linux kernel.

> Maybe the default should be no standard.h at all.
>
> > * You make your own copy of standard.h for your software.  Then you would
> > need to include it on the command line with --macro-file-builtins
> > yourfile.h.  This is a good solution if you have eg multiple macros that
> > are causing problems for parsing.
>
> Yes I have at least one macro
>
> #define alldevs(a)                                      \
>         {                                               \
>                 cpgslct(pg->X_DEVICE);                  \
>                 pg->PLOT_DEV=pg->X_DEVICE;              \
>                 a ;                                     \
>                 cpgslct(pg->PS_DEVICE);                 \
>                 pg->PLOT_DEV=pg->PS_DEVICE;             \
>                 a ;                                     \
>         }
>
>
> When I use it like this
>
> 	alldevs(cpgsci(pg->COLCURVE);
>                 cpgsls(pg->LINESTYLE);
>
>                 xcirc[0]=xpos;
>                 ycirc[0]=ypos;
>                 th_step=(th2-th1)/(49.0);
>                 for(n=1; n<51; n++){
>                         th=th1+(n-1)*th_step;
>                         xcirc[n]=xpos+radius*cos(th);
>                         ycirc[n]=ypos+radius*sin(th);
> 		}
>                 xcirc[51]=xpos;
>                 ycirc[51]=ypos;
>                 cpgpoly(51,xcirc,ycirc);
>                 );
>
> the rules are not applyed inside alldevs.
>
> Can I solve this issue with standards.h ?

No.  Once you rewrite using a macro matching can happen, but not
transformation.  I don't see a solution in this case.

julia


>
>
> > * There is a command line option --undefined NAME, which makes NAME be
> > considered to be undefined for the purposes of evaluating ifdefs.  Maybe
> > this could be extended to all uses of the macro name.  Then you would need
> > to write --undefined NAME on the command line.
> >
> > Rather than adding options on the command line, you can also put them in
> > the semantic patch, with a line like
> >
> > --undefined NAME
>
> ok
>
> >
> > Do any of these seem acceptable?
>
> I like the idea to have a .h dedicated to the refactoring or to put all theses
> standards.h in the semantic patch.
>
> Cheers
>
> Fredric
>
--8323329-834200862-1794841148=:3305--
