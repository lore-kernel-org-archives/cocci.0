Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB6606A321
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=c9EDguCw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=fnbJ3bDltc80uu0vzZWwf+nZkMI/OsDtK/oZVb673c0=;
  b=c9EDguCwinsZKCy8sy4cyk7yRPaEZ8ArNO5AqiMq9czqE0tC++uQaOVH
   +u+xPzIwjwkHFyxqf/CI8WEyqdVsxAvrOq0d7pzYmgU17YklmZoV9Aztj
   GAufEXYOMeRiCZoHUuU4x5a4BF7qpGvDNiqDqFBlfjbweWJtGfs76EE3Y
   0=;
X-CSE-ConnectionGUID: ZNh050Z1SbWZr78e7enAyQ==
X-CSE-MsgGUID: DmrbpjcJT3yANTZstFP22Q==
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
   d="scan'208";a="305112963"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 15:56:14 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 67A4181C1A; Thu, 12 Nov 2026 15:56:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0345E81C19
	for <cocci@sympa.inria.fr>; Thu, 12 Nov 2026 15:56:08 +0100 (CET)
X-CSE-ConnectionGUID: cUf209rbSQOUm8sL/UeN3g==
X-CSE-MsgGUID: Kobx/5PLTKGH2WSw6g+Wmg==
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305112897"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 15:55:54 +0100
Date: Thu, 12 Nov 2026 15:55:54 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: picca <picca@debian.org>
cc: cocci@inria.fr
In-Reply-To: <b4048ae138808c03693d43cd183c7ab8@debian.org>
Message-ID: <bdb1c24f-b629-a074-9249-af6bf6f9cd31@inria.fr>
References: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org> <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr> <b4048ae138808c03693d43cd183c7ab8@debian.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3803
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/UigCC1GF4z6J5c-gH8kOzQ>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Thu, 12 Nov 2026, picca wrote:

> > Alternatively, if it's easier, could you retry after removing the
> > following line from standard.h:
> >
> > #define INLINE inline
> >
> > That looks problematic, but I'm not sure that that definition should be
> > applied if there is not another parsing error in your code.
> >
> > julia
>
> It works without this INLINE

Thanks for the feedback, which is very helpful.

I will try to fix it.

julia

>
> -----------------------------------------------------------------------
> Finished
> -----------------------------------------------------------------------
> diff =
> --- ana_read.c
> +++ /tmp/cocci-output-2311372-3e6202-ana_read.c
> @@ -646,7 +646,7 @@ static void read_spec(Ana *ana)
>
>  		sprintf(STRING,"x title %s break",XCOLNAME);
>  		put_command(&ana->rod.menu, STRING);
> -		plotxye(x,y,e,1);
> +		plotxye(&ana->pg, &ana->rod.menu, x, y, e, 1);
>  	}
>
>  	for(i = 0; i < ncolumns; i++)
> @@ -988,7 +988,7 @@ static void read_srs(Ana *ana, int versi
>  		{
>  			sprintf(STRING,"x title %s break",XCOLNAME);
>  			put_command(&ana->rod.menu, STRING);
> -			plotxye(x,y,e,1);
> +			plotxye(&ana->pg, &ana->rod.menu, x, y, e, 1);
>  		}
>
>  		/* Get column number of y values */
>
