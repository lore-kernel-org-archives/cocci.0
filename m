Return-Path: <SRS0=Ekfz=33=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1837C2D0B1
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:55:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8550420726
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8550420726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0176tVVV026311;
	Fri, 7 Feb 2020 07:55:31 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 75F5177EF;
	Fri,  7 Feb 2020 07:55:31 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9AA80772B
 for <cocci@systeme.lip6.fr>; Fri,  7 Feb 2020 07:53:56 +0100 (CET)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0176rqG3021898
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 7 Feb 2020 07:53:56 +0100 (CET)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EC4F1C53625961F541F2;
 Fri,  7 Feb 2020 14:53:50 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 7 Feb 2020
 14:53:42 +0800
To: Julia Lawall <julia.lawall@inria.fr>
References: <33151da0-3414-a1de-5828-58fc89d77390@huawei.com>
 <alpine.DEB.2.21.2002070746330.2281@hadrien>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <fd166c80-f6bb-ef94-bf54-e7a63835e015@huawei.com>
Date: Fri, 7 Feb 2020 14:53:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002070746330.2281@hadrien>
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Feb 2020 07:55:32 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 07 Feb 2020 07:53:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 07 Feb 2020 07:55:30 +0100
Cc: kuhn.chenqun@huawei.com, cocci@systeme.lip6.fr
Subject: Re: [Cocci] Q: does spatch understand g_autoptr/g_autofree?
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



On 2/7/2020 2:48 PM, Julia Lawall wrote:
> 
> 
> On Fri, 7 Feb 2020, Pan Nengyuan wrote:
> 
>> Hello,
>>
>> I have an example:
>>
>>     @@ expression d,p; @@
>>
>>     - g_autoptr(d) p;
>>     + g_autoptr(d) p = NULL;
>>
>> C source code:
>>
>>     void f(void)
>>     {
>>         g_autoptr(Test) *p1;
>>     }
>>
>> Then I got this error:
>> minus: parse error:
>>   File "test.cocci", line 3, column 15, charpos = 38
>>   around = 'p',
>>   whole content = - g_autoptr(d) p;
>>
>>
>> is it correct?
> 
> No, Coccinelle knows nothing about these things.  If you don't care about
> the types of these variables, you can extend standard.h to say
> 
> #define g_autoptr(x) int

OK, thanks. I will try it.

> 
> julia
> .
> 
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
