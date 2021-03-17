Return-Path: <SRS0=Sj7A=IP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7323C433E0
	for <cocci@archiver.kernel.org>; Wed, 17 Mar 2021 20:51:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F4A64E74
	for <cocci@archiver.kernel.org>; Wed, 17 Mar 2021 20:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F4A64E74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12HKptsb023911;
	Wed, 17 Mar 2021 21:51:55 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3233F77CD;
	Wed, 17 Mar 2021 21:51:55 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4307924DD
 for <cocci@systeme.lip6.fr>; Wed, 17 Mar 2021 21:51:53 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12HKpquB023000
 for <cocci@systeme.lip6.fr>; Wed, 17 Mar 2021 21:51:52 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 d8-20020a1c1d080000b029010f15546281so1847128wmd.4
 for <cocci@systeme.lip6.fr>; Wed, 17 Mar 2021 13:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KHqTGihzkCvfAf9aq/hAEymBXcX05DET6DSMVLmYdCQ=;
 b=NVtgHI5Ou0MgFzslUdtt29d+eRhedg5r6C56SeOMBJ+7h7tk2df41RV1cIYnM8iA2x
 cI7lt+ZWFZh8zWQKBCk5RmMOmRGYzagbuGb8Uey9lmWIF85TT/kS2VSou1TOJQc5ZmD6
 obdp87aPz3QvHXyecmwpq6pqj5mCiucRYF3vSxrT9kwIjaVH0/u9X8fRJLw7fDSp9Oe+
 mKR2JddRT5jCcbNU9TxdjO/v8QuV4uUPPC1w5BWzYixM8UAztOPMMhhxuJ/YadLHAxjS
 JdRsJbdeK2jTUUG8ttd7MgyKrkUO0FC55pvdAF3ooeOliUvW7YOQOD0v/wIAgh5jKSX1
 1Guw==
X-Gm-Message-State: AOAM530rdZ2s2ygcf7CArETb4BHmtm+0lTAz5q732qOj7XsqcROt1ND2
 RyLnQAXSHcbLlyhYByhfxOJZQ71tUEl+tUl2
X-Google-Smtp-Source: ABdhPJxyCaOB5XPMQT87NHObtKT+mE0Qof9kJ7HJp/+8cgroRyJ3BNPSKbNCuvSAAsLYeEvlgGJOmA==
X-Received: by 2002:a1c:6605:: with SMTP id a5mr559530wmc.85.1616014312549;
 Wed, 17 Mar 2021 13:51:52 -0700 (PDT)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id h8sm95645wrt.94.2021.03.17.13.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 13:51:52 -0700 (PDT)
To: Julia Lawall <julia.lawall@inria.fr>
References: <c62bd578-1f83-d876-d6f1-cc39513ecbd9@linux.com>
 <alpine.DEB.2.22.394.2103172131210.2981@hadrien>
From: Denis Efremov <efremov@linux.com>
Message-ID: <e905626c-f1f5-fb30-b823-8f27e0128983@linux.com>
Date: Wed, 17 Mar 2021 23:52:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2103172131210.2981@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Mar 2021 21:51:56 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Mar 2021 21:51:52 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Incorrect match with when != condition
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On 3/17/21 11:32 PM, Julia Lawall wrote:
> 
> 
> On Wed, 17 Mar 2021, Denis Efremov wrote:
> 
>> Hi,
>>
>> I'm trying to write the check to detect the absence of commit
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=51b2ee7d006a736a9126e8111d1f24e4fd0afaa6
>> in kernel. The pattern can be:
>>
>> @err exists@
>> identifier namlen, dchild, dparent, exp;
>> position p;
>> statement S;
>> @@
>>
>> compose_entry_fh(..., int namlen, ...)
>> {
>> 	...
>> 	if (namlen == 2) {
>> *		dchild =@p dget_parent(dparent);
>> 		... when != dparent == exp->ex_path.dentry
> 
> add when forall here.  There does exist a path that does not contain the
> dparent == exp->ex_path.dentry test.  That is the path that takesthe first
> goto out.

This solved the problem, thanks!
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
