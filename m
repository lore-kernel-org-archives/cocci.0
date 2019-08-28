Return-Path: <SRS0=Utcs=WY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B520C3A5A1
	for <cocci@archiver.kernel.org>; Wed, 28 Aug 2019 12:42:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE342173E
	for <cocci@archiver.kernel.org>; Wed, 28 Aug 2019 12:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE342173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7SCflr5025327;
	Wed, 28 Aug 2019 14:41:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 26053778B;
	Wed, 28 Aug 2019 14:41:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AA14174B3
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 14:41:45 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7SCfjIn005735
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 14:41:45 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id x19so2818203eda.12
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 05:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XQb3z9P4gf099Mugft8AnZzlB0sXTeRvVgkGP0skJyk=;
 b=OYrAekqDgEB+oAu2fSFuHywDtug8MH12UQneWsDV5Cvuw44jzl1WTlSyc90qQvTl+m
 UW/6PWX1mu95IBj65rdDRGwh0wGE8Syw4MpfuGwt88pFy7ynQ3V6nPzQJFM+/QrkpbSp
 q8Ovgpm4VlY0vXXYo5i0WcRW7eGhm42xBvPKOAQtcGflp495U3R8EXzGJTxG7IPHOsdr
 u2fUCJC3oNEDJuFGPuR5rBzTRgKMw8kgqdpa3UXsJlW0yErdwCjugfQJ7VgcLFhKPss5
 kYwDql62Ms76ia4uM8Wh3tIIg+H05kmizqmSo0nAx8lQuHnPnvX3pBYI36lCIGIuLL/a
 GW9g==
X-Gm-Message-State: APjAAAV2bTZpyV3razgNtATMuCuYD6nMB4BEP4xBOzS+3NASYi8adfOm
 /rabPn8HbP56Gmw+5rjqWEM=
X-Google-Smtp-Source: APXvYqz57QeeTvorHo5cXarpWRCeQpcGtAf1c3aKwtJlruwTu/+crGW/L46mB112EyJC75bvpTlxgw==
X-Received: by 2002:a50:fd10:: with SMTP id i16mr3650722eds.97.1566996105050; 
 Wed, 28 Aug 2019 05:41:45 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
 by smtp.gmail.com with ESMTPSA id 59sm440043edg.44.2019.08.28.05.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2019 05:41:44 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
 <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
 <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
From: Denis Efremov <efremov@linux.com>
Message-ID: <496b3d09-47a2-3836-2899-d964267993d3@linux.com>
Date: Wed, 28 Aug 2019 15:41:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 28 Aug 2019 14:41:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 28 Aug 2019 14:41:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: coccinelle: check for !(un)?likely
	usage
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
Reply-To: efremov@linux.com
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


> 
> As a human I am confused. Is !likely(x) equivalent to x or !x?
> 
> Julia
> 

As far as I could understand it:

# define likely(x)	__builtin_expect(!!(x), 1)

!likely(x)
!__builtin_expect(!!(x), 1)
!((!!(x)) == 1)
(!!(x)) != 1, since !! could result in 0 or 1
(!!(x)) == 0
!(!!(x))
!!!(x)
!(x)

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
