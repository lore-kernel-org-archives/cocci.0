Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D9B606A323
	for <cocci@archiver.kernel.org>; Mon, 16 Nov 2026 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=KhmKHcpG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:cc:reply-to:in-reply-to:
   references:message-id:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=89X2fT92Nb3H7uyqnQQkN/JLckuu5u+xxHv/GX+4YAs=;
  b=KhmKHcpG2R4FqheNJFaCVzoatIkfcBdR5YTem/gKTlFP6lmcqmwOQ6V4
   Iq+WW4oUDKeqweKvTGAYU+QBeC3U1rf8qj3RY4Cc6HjWWCXevxZ1ZnmPS
   4TKLfEeTToNlpqdaaCNqQPFa6rrrS8oZHXNxfpsIey/vQxIynuFO07Q2S
   k=;
X-CSE-ConnectionGUID: NDuV+se8Ss+7CQc+dKj2oA==
X-CSE-MsgGUID: Na1Pi4uMRXK4p85oSG6OZA==
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
   d="scan'208";a="305644070"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2026 15:45:23 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E24B481C17; Mon, 16 Nov 2026 15:45:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AA68181FC6
	for <cocci@sympa.inria.fr>; Mon, 16 Nov 2026 15:45:17 +0100 (CET)
X-CSE-ConnectionGUID: z6BCcLiJQDaXJ5dZo9pkUQ==
X-CSE-MsgGUID: zOjStzj0QkGhfk75UwXDWw==
IronPort-SDR: 6afb16e9_VTQUzJHHO6kUOnj1ceOpQfZJ4aAwopr73SEGLtFC0rge8hQ
 ltBMwCHbAO7shmH2U1tzx0P6XH/W++Y4Cbuox8A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FyAQCFFvtqjgQqG9RaglmBblOBBVQUMgcIhSGIeoh9n?=
 =?us-ascii?q?iKBfg8BAwENTwIEAQEBghGCcwKOIAIfBwQFLQcOAQIEAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQEBATkFDjuGXIwaAYQAAQEBAgEjB?=
 =?us-ascii?q?AsBBUEFCwQHCRECJgICKysGGxOCZ4JOJwQDAblzfzOBAYRm2WOBH1UVgQouh?=
 =?us-ascii?q?XSCbgGKdicODYFIRYEVgnsxPogfgmoEgiKBDBuBUZYcBwceJh1bHANZLAEPR?=
 =?us-ascii?q?hMXCwcFYEVDA4EGI0sFLR03bDsXER5YGwYFEiAqQENbgRKBBV2BKyhdAQEBH?=
 =?us-ascii?q?0YtCguBdgKCUYEjXQIBSUEOB0VTCSVDEkckIggSCQETGiwKgRo1PAkmPxUMW?=
 =?us-ascii?q?wwIAxoFGiYCHwgCCwIMdCgREBMdHiQvBRomPhsKgQ4mB2Y9NwkMGQQCAToIQ?=
 =?us-ascii?q?h0SApZLXRwwW4ECfaMHonY8hCqBdIIQnWISHBeqcpkIqUWBbwQvgVx9CIIUg?=
 =?us-ascii?q?Q9PAxkPjjvSJERxAgcCBwEMAQMLhUaMVoFMAQE?=
IronPort-PHdr: A9a23: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
 qwX69gZQtyjihieI93qIfgL00d0jDk=
IronPort-Data: A9a23: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
 fE/p7AS5cw6fOWRsvFYVxXtdqFB
IronPort-HdrOrdr: A9a23:sQ+e7KtwPAY0xWnDlEDcJubm7skDUdV00zEX/kB9WHVpmwKj5q
 WTdZMgpGDJYVcqKQ0dcL+7WJVoLUmslqKdpLNhRItKPzOGhIN1QbsSi7cKoQeQYBEWJtQtqJ
 uIGpIWYLabY2SSz/yKmDVQdexQp+Vvm5rY4ds2oU0dLz2DO8lbnn1E4x6gf3GeXjMrOXMmLv
 Wh2vY=
X-Talos-CUID: 9a23:ner8y2Aupd9Z3hb6Ezs53mUfPsEHS1HU/FWNL32/WH5qdYTAHA==
X-Talos-MUID: 9a23:X2QJTgZ0GWj2NeBTpRjuvy1wNp9R4IuuBkNSzKgZi+W7Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,216,1787004000"; 
   d="scan'208";a="162801061"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGNUCBFdtuYe4kWyjoSEptXbK+x36docn153L?=
 =?us-ascii?q?/Kj+N4CHN3aHyY/v4/oNwAhObetJrPQMFBGoWMgiWxyb9oMrHkreXhe9?=
 =?us-ascii?q?4MVYK1RwFM2pWqIqYJntOWLKL/C1O3Y2BN0l0XNT9CV/0x5Et3Ar68P7?=
 =?us-ascii?q?KFHVAIfzMrl+gyXTMGXV6f6g=3D=3D?=
Received: from smtp4-g21.free.fr ([212.27.42.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 15:44:56 +0100
Received: from lettres.chocolatnoir.net (unknown [83.159.1.88])
	by smtp4-g21.free.fr (Postfix) with ESMTPS id C624919F57B;
	Mon, 16 Nov 2026 15:44:53 +0100 (CET)
Received: by lettres.chocolatnoir.net (Postfix, from userid 126)
	id 1BBBECE8E1F; Mon, 16 Nov 2026 15:44:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
Received: from lettres.chocolatnoir.net (localhost [IPv6:::1])
	by lettres.chocolatnoir.net (Postfix) with ESMTPA id 3B670CE1AE7;
	Mon, 16 Nov 2026 15:44:52 +0100 (CET)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Nov 2026 15:44:52 +0100
From: picca <picca@debian.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Reply-To: picca@debian.org
Mail-Reply-To: picca@debian.org
In-Reply-To: <f7e0d31a-d8a5-cdb7-9cd0-998511f1216c@inria.fr>
References: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org>
 <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr>
 <b4048ae138808c03693d43cd183c7ab8@debian.org>
 <f7e0d31a-d8a5-cdb7-9cd0-998511f1216c@inria.fr>
Message-ID: <2d228ae9f4244ff6f84d036f5c0f531f@debian.org>
X-Sender: picca@debian.org
Organization: Miaouh
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
X-Loop: cocci@inria.fr
X-Sequence: 3808
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/GYYMcQXHK3vJC66iv5FjVw>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1

Le 2026-11-13 23:07, Julia Lawall a écrit :
> The macros in standard.h get expanded before any other processing.

ok

> Some options:
> 
> * We remove the #define INLINE inline in standard.h
> I don't know if anyone is relying on this macro.

What is the purpose of standard.h ?

Maybe the default should be no standard.h at all.

> * You make your own copy of standard.h for your software.  Then you 
> would
> need to include it on the command line with --macro-file-builtins
> yourfile.h.  This is a good solution if you have eg multiple macros 
> that
> are causing problems for parsing.

Yes I have at least one macro

#define alldevs(a)                                      \
         {                                               \
                 cpgslct(pg->X_DEVICE);                  \
                 pg->PLOT_DEV=pg->X_DEVICE;              \
                 a ;                                     \
                 cpgslct(pg->PS_DEVICE);                 \
                 pg->PLOT_DEV=pg->PS_DEVICE;             \
                 a ;                                     \
         }


When I use it like this

	alldevs(cpgsci(pg->COLCURVE);
                 cpgsls(pg->LINESTYLE);

                 xcirc[0]=xpos;
                 ycirc[0]=ypos;
                 th_step=(th2-th1)/(49.0);
                 for(n=1; n<51; n++){
                         th=th1+(n-1)*th_step;
                         xcirc[n]=xpos+radius*cos(th);
                         ycirc[n]=ypos+radius*sin(th);
		}
                 xcirc[51]=xpos;
                 ycirc[51]=ypos;
                 cpgpoly(51,xcirc,ycirc);
                 );

the rules are not applyed inside alldevs.

Can I solve this issue with standards.h ?


> * There is a command line option --undefined NAME, which makes NAME be
> considered to be undefined for the purposes of evaluating ifdefs.  
> Maybe
> this could be extended to all uses of the macro name.  Then you would 
> need
> to write --undefined NAME on the command line.
> 
> Rather than adding options on the command line, you can also put them 
> in
> the semantic patch, with a line like
> 
> --undefined NAME

ok

> 
> Do any of these seem acceptable?

I like the idea to have a .h dedicated to the refactoring or to put all 
theses standards.h in the semantic patch.

Cheers

Fredric
