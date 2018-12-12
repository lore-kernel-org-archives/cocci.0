Return-Path: <SRS0=XveF=OV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4987C65BAF
	for <cocci@archiver.kernel.org>; Wed, 12 Dec 2018 16:47:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B97C2084E
	for <cocci@archiver.kernel.org>; Wed, 12 Dec 2018 16:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZf80CZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B97C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBCGl4n2021149
          ; Wed, 12 Dec 2018 17:47:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 431DE76AB;
	Wed, 12 Dec 2018 17:47:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CF6D060D7
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 17:47:00 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:52f] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBCGkxTP006704
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 17:47:00 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-pg1-x52f.google.com with SMTP id s198so8589119pgs.2
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 08:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BKexHWBSPBTwgHQ3TVsh4NUrQIerF2gMww+s2Yt8PRc=;
 b=DZf80CZY3ZSg8MNKSWUEb2WZm+H9h90sfk1FpqpNsM9jvL9OSwpO2cSmU1ElPDzJGv
 7wompIKWprPG5pktbAXEX4qSlzwdXxAC6PxfEYCXz8Ro70FoJ39Pn9UdvG4wsWExjAHs
 pBhsy9Dz3kTxBquXsYV2+t/O2SLeAANacR0MFMedeyDU7Hf0w32nbkJzrukW3UlGy3tn
 YMK7kvr2OQFsiBeYMgEc5Ap9pqZgL6RNd/FRA3EqycCZLvqU/WOtyrq3zsvlDW8b27qd
 AM6Cu6YvjLNY0WqbhEXXHSpFXCqFeTJ/4iUaJQLQCwyxGMdQeK6P7f63KnYzzirUIR3y
 E1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BKexHWBSPBTwgHQ3TVsh4NUrQIerF2gMww+s2Yt8PRc=;
 b=T1lyRTZ0J+b3AgcAO+PAXd1LoqmcWYOZoBki7z8VlQB3pIeBtFK/uSYEn3m781IcmW
 2SpCqaEOxIIaFT1QznFiuRw6+UqfkVzsfeRnHkTlT3Mqtyemi5Eaglcmy2PnXmsngAsy
 ElpfeBRnOm9hSfVctKrBU49lMVNgP1BVC19/QT+ZGXJaEidzVJiyOpNEAGvhxcpdyvX9
 rqmdH+GugBxV/Pp0cpaKEyq3HhFQbwGmQc41n/J0R7JBYSLvyzCC7kXFBPEoC+lo9rlJ
 SYPnNayij5DTMrie6cxt7P0wQjWuLxWVyzndWKgvFZagHjB/LIymMf6LmYxhKPsLQrzV
 XXfw==
X-Gm-Message-State: AA+aEWYzIY6XWhjzpigeI6Zp8vCKBTs3RMxFNeUZZExlmMZgfg2Jk77e
 hQI2hNqzoCZcREPgyAvGjPI=
X-Google-Smtp-Source: AFSGD/XE0M1tivgWU5+fyQCrHj8ldJLjuBLljhTwYGnI3029F91sD+L3/43flbcpk/9Ta3elU22ghg==
X-Received: by 2002:a62:14d1:: with SMTP id 200mr21151444pfu.103.1544633219150; 
 Wed, 12 Dec 2018 08:46:59 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
 by smtp.gmail.com with ESMTPSA id x26sm22242652pfn.50.2018.12.12.08.46.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 08:46:58 -0800 (PST)
Date: Wed, 12 Dec 2018 22:16:52 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>, yamada.masahiro@socionext.com
Message-ID: <20181212164651.GA12081@himanshu-Vostro-3559>
References: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 12 Dec 2018 17:47:04 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 12 Dec 2018 17:47:00 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 0/2] scripts: coccinelle: Improve boolinit
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

+Cc Masahiro Yamada

On Wed, Dec 12, 2018 at 12:55:55PM +0100, Julia Lawall wrote:
> Reduce the scope of the rule and improve the warning messages.
> 
> julia (2):
>   scripts: coccinelle: only suggest true/false in files that already use
>     them
>   scripts: coccinelle: Correct warning message
> 
>  scripts/coccinelle/misc/boolinit.cocci | 43 +++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> -- 
> 1.9.1
> 
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
