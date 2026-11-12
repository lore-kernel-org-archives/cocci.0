Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA3606A31C
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=Qu8GY+St
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=KINqwKB8kUw7GTWYa08A5uNPuYTgrrjAIpG1v8MdPI0=;
  b=Qu8GY+Ste2+BA67Lc9Bw4xVLU2nECdJ/zegfdRjueZ9w2yOT4jRgUsY+
   UXb++t3tD8NhjYIzjya3iw73YLt33MnqJdtRVPTqnBwRCJiB1LLavSOKZ
   bGBd7ZNcq9LsffIxqAfyb4p4cWOv6exWeSZLl9GMyz4Tc9hhyBi80Cxg2
   0=;
X-CSE-ConnectionGUID: NyY9fw4+RrS7Kt9J5kIDqw==
X-CSE-MsgGUID: k1blYmsATciX//ch1llTug==
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
   d="scan'208";a="305054560"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 11:40:30 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5B03581996; Thu, 12 Nov 2026 11:40:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9923781941
	for <cocci@sympa.inria.fr>; Thu, 12 Nov 2026 11:40:27 +0100 (CET)
X-CSE-ConnectionGUID: aLdXq4rHSGSwNzmW2GMT3Q==
X-CSE-MsgGUID: /fdo0cmpTa+3O9gg6a4/Eg==
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305054539"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 11:40:27 +0100
Date: Thu, 12 Nov 2026 11:40:27 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: picca <picca@debian.org>
cc: cocci@inria.fr
In-Reply-To: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org>
Message-ID: <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr>
References: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3791
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/JVv1wu0u1Babg2fXKkJqvw>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Thu, 12 Nov 2026, picca wrote:

> Bonjour,
>
> J'ai un fichiers qui ne parse pas,  je fini avec cette erreur
>
> bad: 	sprintf(datetime,"Date: %.2s-%.2s-%.2s time: %.2s:%.2s:%.2s",
> bad: 		&INLINE[25],&INLINE[23],&INLINE[21],&INLINE[35],&INLINE[37],
> bad: 		&INLINE[39]);
> bad: 	if (NULL != fgets(INLINE,INLLEN,infile)) {;}
> bad: 	if (NULL != fgets(INLINE,INLLEN,infile)) {;}
> bad: 	sscanf(INLINE,"%8s%f %f %f %f",dummy_name,&HMIL,&KMIL,&LMIL,&BETAIN);
> bad: 	/*
> bad: 	 * First two characters must be spaces and beta shouldn't be zero for
> bad: 	 * for correct beta read from header
> bad: 	 */
> BAD:!!!!! 	if((strstr(INLINE, "  ") != INLINE+9) || (BETAIN == 0.))
> bad: 	{
> bad: 		BETAIN = 0.;
> bad: 		has_read_beta = false;
> bad: 	}
> bad: 	else
> bad: 	{
> bad: 		has_read_beta = true;
> bad: 	}
> bad:
> bad: 	sprintf(DATATITLE,"%.40s",&INLINE[9]);
>
>
> INLINE et une variable global de type
>
> char INLINE[fix size] defini dans "ana.h".
>
> J'aimerais savoir comment regler ce probleme de parsing ?

Could you send a complete file that illustrates the problem?
The parser has a lot of heuristics, and some are quite non-local, so it's
hard to see what the problem is from an extract.

Alternatively, if it's easier, could you retry after removing the
following line from standard.h:

#define INLINE inline

That looks problematic, but I'm not sure that that definition should be
applied if there is not another parsing error in your code.

julia
