Return-Path: <SRS0=EuJX=WI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30C7C31E40
	for <cocci@archiver.kernel.org>; Mon, 12 Aug 2019 06:12:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DFCD2087B
	for <cocci@archiver.kernel.org>; Mon, 12 Aug 2019 06:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFCD2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7C6Bp0S022574;
	Mon, 12 Aug 2019 08:11:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1BF2E77AA;
	Mon, 12 Aug 2019 08:11:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9ADD27788
 for <cocci@systeme.lip6.fr>; Fri,  9 Aug 2019 15:43:50 +0200 (CEST)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x79DhoOZ017084
 for <cocci@systeme.lip6.fr>; Fri, 9 Aug 2019 15:43:50 +0200 (CEST)
Received: by mail-wr1-f67.google.com with SMTP id r3so4555739wrt.3
 for <cocci@systeme.lip6.fr>; Fri, 09 Aug 2019 06:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SVXw2/bA5C08+BykjuTS3dhz6TKyxWMjOdIKpXnFiF0=;
 b=VUWml0s/WNk96Zeh/l4zfEuL7W32DpT+CX9frcrLLnY8ZGjyn2lRbrSyXK4bRVdX04
 7oWeuoKl6Mo3CBs101WiYkydno4Le8J3Afn0Njgzqm3uU3qs+CWek09JRD6YByxKVKBS
 fpTRaeB1eh2tkdzEyH+Lgy6I7dEOPqlfioPRHP8ZUiU4eO/BObkuhK2bunucbmeZuAPq
 iKG4Fl521IldP8m3ZHcl/wJzJPvTFMmCw0y7KFhaiWwabg3YW2cw0Kv5qG3gMnhINQkK
 QxRgCLERjjUObFnWJDzSE8g6tV5J2eUbxQ4lC3pVGyQGmdgzR6GAu4exzUjGKl1t5tBl
 eT0A==
X-Gm-Message-State: APjAAAW1Gs9salCxfFtxD7UZHfjR4+jsm5lQL+l9vdJqzkOWP9WH96zo
 F3l+8bxDv//O0K84M7X/uNM+01BC6oQ=
X-Google-Smtp-Source: APXvYqzgfODOd8I82ICcOo3N3RU4p19HM2GuesacfNF1Br8xggXKcJZpItkDTk8yUNwJ/N/88Pfi3Q==
X-Received: by 2002:a5d:460a:: with SMTP id t10mr23215213wrq.83.1565358230117; 
 Fri, 09 Aug 2019 06:43:50 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru.
 [188.32.48.208])
 by smtp.gmail.com with ESMTPSA id z1sm98784974wrp.51.2019.08.09.06.43.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 06:43:49 -0700 (PDT)
To: Jens Axboe <axboe@kernel.dk>, alex.popov@linux.com,
        Jann Horn <jannh@google.com>
References: <20190326220348.61172-1-jannh@google.com>
 <9ced7a06-5048-ad1a-3428-c8f943f7469c@linux.com>
 <b324719d-4cb4-89c9-ed00-2e0cd85ee375@kernel.dk>
From: Denis Efremov <efremov@linux.com>
Message-ID: <b509abcf-224b-7bfd-a792-dd8579dbcca9@linux.com>
Date: Fri, 9 Aug 2019 16:43:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b324719d-4cb4-89c9-ed00-2e0cd85ee375@kernel.dk>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 12 Aug 2019 08:11:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 09 Aug 2019 15:43:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 12 Aug 2019 08:11:46 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>,
        Mukesh Ojha <mojha@codeaurora.org>, Jiri Kosina <jikos@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] floppy: fix usercopy direction
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

>> So I add a new floppy maintainer Denis Efremov to CC.
> 
> Looks like it got lost indeed, I will just apply this one directly for
> 5.4.
> 

Thank you!

Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
