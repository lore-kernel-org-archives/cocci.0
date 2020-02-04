Return-Path: <SRS0=4B11=3Y=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45817C35247
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 15:26:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE38620730
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 15:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yaerobi-com.20150623.gappssmtp.com header.i=@yaerobi-com.20150623.gappssmtp.com header.b="SycElHll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE38620730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=yaerobi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 014FQ92V012486;
	Tue, 4 Feb 2020 16:26:09 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EA24177EC;
	Tue,  4 Feb 2020 16:26:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1396277E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Feb 2020 16:26:07 +0100 (CET)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:842])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 014FPxcs028733
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 4 Feb 2020 16:25:59 +0100 (CET)
Received: by mail-qt1-x842.google.com with SMTP id d9so14554583qte.12
 for <cocci@systeme.lip6.fr>; Tue, 04 Feb 2020 07:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yaerobi-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=BYmOPlNiblSmRpiPv2rXo+hSS8/67973Sr67YHKnzeM=;
 b=SycElHllS1MGUv3/zV2/T9nzIk82D2w5Cvn2Pttg/M0kf46jT7B/nHbN8lku7aJSvo
 qRHJfWz7rHlwJDIOKDmzxvzuD+7LNv64OKWtQ0L3dDiU601QALThFkMkioLdNwXVagCm
 q5m7igxjiYX4SrD+UQzlX5x+ze2/DZYpnnFmCO0UcVqOkqBSMvrQf16oEvIYWPw+ehlO
 ZAIJkaJfmwK5lfa/Ai+1QTVuqkRMwJb6K6RPvLhNxOGSumtE/73kvt87pneW8QN3GYdW
 NGqLEFd69ZhsQCtAQ+tTwF8I9tP5nctFSUlDClSL3i9/0QOQxKCoupksfUHTBU9Mev4P
 HJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=BYmOPlNiblSmRpiPv2rXo+hSS8/67973Sr67YHKnzeM=;
 b=XC6E5BCiVf96tM8gV0Qo9x+LhOnSM4QI9bBaPdwMxJAM4LG/vHvzcMQXjuLIPExJM2
 3uWPsTZggRDY6FG6HqeJk5mvAS6WCwyje6GfKU2JS96rBCcOeywe8uKaH8lEfv3fRvQW
 Ql417YnU13BJBMhOpHnwg4Q/wd3ETtAxAXkyWX1PQK0V1K0fnzoPMQ/uwGHlBzTK8REJ
 qHgC6PGSLaJhBVQEPO3zHvTmy5xaGWphj2/TIYMAbALb6ZBILgFr02r6K2PcTL4vdfc9
 NRkehMZ9V0/EHM2diy1hs+5YtptIWR+ECtarKPF14pRP43XFX/TGlHMOlWcoyR/2Kfh6
 ejyQ==
X-Gm-Message-State: APjAAAUy7P9OXxMuS2HT5eBOP8E3n0dENsx4ALUeuC17VCMxjaQU7EYa
 gRb3aLC2KdHAU08wzNfPPTXHoH8YOVY=
X-Google-Smtp-Source: APXvYqx/vJG/5vMqsAfx/eWKx3r0Vvw+Vvsy4Kbl2WU6jSldUgUuUEddE060LulO3QFloP4GThh18w==
X-Received: by 2002:ac8:7415:: with SMTP id p21mr16546827qtq.122.1580829958635; 
 Tue, 04 Feb 2020 07:25:58 -0800 (PST)
Received: from [192.168.0.104] ([181.93.114.99])
 by smtp.gmail.com with ESMTPSA id l184sm11100112qkc.107.2020.02.04.07.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 07:25:58 -0800 (PST)
To: Julia Lawall <julia.lawall@inria.fr>
References: <786d2ea9-621f-bcc4-b626-aed6454784e2@yaerobi.com>
 <alpine.DEB.2.21.2002041556540.3345@hadrien>
From: eamanu <eamanu@yaerobi.com>
Message-ID: <909d202d-9a8a-d010-107b-80c07febcb0f@yaerobi.com>
Date: Tue, 4 Feb 2020 12:25:55 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002041556540.3345@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 16:26:09 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 04 Feb 2020 16:26:00 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle depends on unmaintained pygtk
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

Hi!

On 04/02/2020 11:59, Julia Lawall wrote:
> On Tue, 4 Feb 2020, eamanu wrote:
>
>> Hi everybody,
>>
>> Sorry if this issues is duplicated, I am new in the mailing list
>> and in a very quickly searching I didn't found about this issue.
>>
>> I am working on Coccinelle package on Debian
> Thanks!
>
>> and currently
>> exist the next bug [1].
>>
>> There is any plan to port to use GObject Instrospection?
>>
>> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=885267
> I think we should just drop the code that depends on it.  It was added for
> a MS thesis more than 10 years ago, and I don't think anyone has used it
> since.
>
> I will look into it.

Great, if you need help, I can help :-)

I will wait for any news. Thanks

eamanu
>
> julia

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
