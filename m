Return-Path: <SRS0=PfnL=TW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB6CC282CE
	for <cocci@archiver.kernel.org>; Wed, 22 May 2019 11:29:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A7A217D4
	for <cocci@archiver.kernel.org>; Wed, 22 May 2019 11:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="ax6SRUf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A7A217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4MBSte4010963;
	Wed, 22 May 2019 13:28:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4A942774B;
	Wed, 22 May 2019 13:28:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E386F7747
 for <cocci@systeme.lip6.fr>; Wed, 22 May 2019 13:28:53 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:42c] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4MBSr1b006482
 for <cocci@systeme.lip6.fr>; Wed, 22 May 2019 13:28:53 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id s17so1883807wru.3
 for <cocci@systeme.lip6.fr>; Wed, 22 May 2019 04:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=OBDkjlSEcB8/fudQZBGF2yQf1NNjOq0HZ34YmN/V95U=;
 b=ax6SRUf9pemkaEHbnZAqGhKF2iH7FY/HY6foVS9FW5WDfCz39+kUDOQ+eul62pvqj6
 g9/wfmJKV8BwXX1I8t+zFlAHHGK9cSvh7d7VcGTSNV8qJtKzGHGZy71D2imQw5tuVGp9
 OLDfYp/1HRz5CiRX5l7T0ybdfVrN7D0sZvZT1qNVOR88ZcCmNT2qVkyV1/7TCIhPEQAy
 n3jRuQl3X0caOQ3ZbS6VHX86hEQ3PHihQwk0lFkQPnXwO8ixx/yQjEbeNez5veJoZQ1j
 z8tMUmjxOvOYGUIBBUTZ5tXlC3veQffYI+DNIfl7ZHmTOB89DHMxCruuomitOIFkY7FU
 XpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=OBDkjlSEcB8/fudQZBGF2yQf1NNjOq0HZ34YmN/V95U=;
 b=D0+aDf8gfaZd/COtBq7uPROf+ozw+CEerXO/EYLMgUXIiUCs5XRcaHa3NluPKAtTrQ
 x2KRRmFhb8s4kWLHBHlQTckVrb8cW5fSGvZ8GqkfUQrXwqI7vGmHU9c4/XponE2afyCw
 Tfan8JTZGbFQUVRJMRjG8GdE5ZobxrOJcEq0+BDBDJoBayMyC0DCTahGQMZS8sNq1/v/
 HjZfzaS0jWnOhb70LzIobyhUFqtFIijIrfMoqNtN6QZazOwAvJcnSrPdp8OeWADu23mT
 rtn5uI+U2sDBO6rVBVkxP3URQ3eU9Ewm4TxqcCXEXpPrXQHMhibUSh5DBjj1oQQyS033
 w6cQ==
X-Gm-Message-State: APjAAAUOgZ2Wu14TJw6XhHh6dUq4YTU1sXmezrJJDD8XLfvkBZyaQupB
 DYXK0Epxk4JT77Hj48TXRjrKGmjLFBI=
X-Google-Smtp-Source: APXvYqy3r7ggChKX2/ga7z3Zit90s4JMqmJZ0c7ZzVEJWcgeOkwSsgT5ie4OkeobNwtlvuxWXSstSw==
X-Received: by 2002:adf:eb91:: with SMTP id t17mr35862216wrn.203.1558524533049; 
 Wed, 22 May 2019 04:28:53 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:302b:5254:7ca1:efe0?
 ([2001:858:107:1:302b:5254:7ca1:efe0])
 by smtp.gmail.com with ESMTPSA id j28sm46304923wrd.64.2019.05.22.04.28.52
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 May 2019 04:28:52 -0700 (PDT)
To: cocci@systeme.lip6.fr
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <86fdc128-e077-58d1-2170-912937317ab1@linbit.com>
Date: Wed, 22 May 2019 13:28:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 22 May 2019 13:28:55 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 22 May 2019 13:28:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Does coccinelle support non-standard C?
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

Hi,

Consider the following snippet of C:


#define f() ({ puts("hello"); 0; })
int main()
{
     printf("%d\n", f());
}


It uses an expression statement in the definition of `f`, which is a gcc 
extension.

Now let's try to write a semantic patch to generate something like this:


@@
@@
- cocci_replace_this()
+ ({ puts("hello"); 0; })


With the C code as:


#define f() cocci_replace_this()
int main()
{
     printf("%d\n", f());
}


This prompts the following error message from spatch:


$ spatch --sp-file test.cocci test.c
init_defs_builtins: /usr/lib/coccinelle/standard.h
32 33
Fatal error: exception Failure("plus: parse error: \n = File 
\"test.cocci\", line 4, column 3,  charpos = 32\n    around = '{', whole 
content = + ({ puts(\"hello\"); 0; })\n")


Now here's my question: this obviously implies that coccinelle doesn't 
support expression statements (or any other non-standard C for that 
matter). Can I still somehow tell spatch to just replace it with this 
string of text instead of trying to parse it as C?

Thanks.

--
Regards,
Christoph
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
