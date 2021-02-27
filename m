Return-Path: <SRS0=+EIx=H5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7F3C433DB
	for <cocci@archiver.kernel.org>; Sat, 27 Feb 2021 09:07:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B1560C40
	for <cocci@archiver.kernel.org>; Sat, 27 Feb 2021 09:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B1560C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11R97V41020183;
	Sat, 27 Feb 2021 10:07:31 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8578B760C;
	Sat, 27 Feb 2021 10:07:31 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1028A3E64
 for <cocci@systeme.lip6.fr>; Sat, 27 Feb 2021 10:03:27 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:231])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11R93OQY016178
 for <cocci@systeme.lip6.fr>; Sat, 27 Feb 2021 10:03:25 +0100 (CET)
Received: by mail-lj1-x231.google.com with SMTP id m11so12510549lji.10
 for <cocci@systeme.lip6.fr>; Sat, 27 Feb 2021 01:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=718vQs0Cw0cUlmBpD7vfExbM3glIkb0aZPz2GDJPsKs=;
 b=Up0/D6e1BB36925rXJ8DzflX06vROaiJ0fM1cP3q+xRiB1sSLC7AwAcTcgabsMgxRc
 tjTMK2rF0e7X/ry5fH+GuujMLSNaXJWR16Czc6RMx5Xuz328fJUglFt5kceV8oO0OXwk
 TsQEvzTeq45tI59rRr+eIdSTQkfcnlPtbramCNflRPF7W4d3E4zeiJDotn7EjCnLp4UE
 3XShQWO+p9QsVDW8Js6hhV3t48i0YktZdFZOCRE1aV1NrBs0Shh0fsN6hDTvzH36RkHP
 tiQEMPH+CA+W/AG9b/BqW5rTgDtPCMkJDJaljyuqT/H43EOhbJKV/iDVcZeNtWUvSuj7
 BPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=718vQs0Cw0cUlmBpD7vfExbM3glIkb0aZPz2GDJPsKs=;
 b=VbpTZFDg7Qg8XAKy2zpX534msHws+wUn6O2davyEFneNpaS+lavGeC0Rn+jNghf8rP
 VjfUOQdWeJxfXfvVgc/6r7gKPbFxUFRmINa2CgaSsmMTV7b0r3bDPSFWlU0RM38BNrVD
 Y3lWrzm0yThTXDSWh/fNXbIKONo+1Nx9KpGU04stoV6HYUN8d28lUrQYFEFJxuJmo0B/
 dr6PsLIEj5SfYOOhYDdnMGz1ORkwRecAVnlsghgelx5etiyyK09XGN92bFLyvqtmzlD8
 lVPeQ9wOMyei1pqhguYyrR0+SMqKYVkqX3mjURTfuOVD1QXNWQp0jn0wqqv4EoYdN7gm
 Zfow==
X-Gm-Message-State: AOAM53072Cbrtfje6iyODRXqw+bPoNUsCF589Bzj1bZmEZPezAGARvHF
 q1n1xzcH8bkZAqrHQ5S8NsUh5Qby/sXECw==
X-Google-Smtp-Source: ABdhPJxHwXN968W7zjiIgFt8Z976GRxECjvT8sjVwnApDIbc/vC5e1aeryt7yhAlSJ1fN4J/1Yf8vA==
X-Received: by 2002:a2e:9b16:: with SMTP id u22mr1876315lji.184.1614416604238; 
 Sat, 27 Feb 2021 01:03:24 -0800 (PST)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id v22sm1629487lfd.155.2021.02.27.01.03.23
 for <cocci@systeme.lip6.fr>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Feb 2021 01:03:23 -0800 (PST)
To: cocci@systeme.lip6.fr
References: <alpine.DEB.2.22.394.2102270905410.2926@hadrien>
From: Denis Efremov <yefremov.denis@gmail.com>
Message-ID: <47b8a2cd-ff8a-ac8c-a9b1-015488bbc959@gmail.com>
Date: Sat, 27 Feb 2021 12:03:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2102270905410.2926@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 27 Feb 2021 10:07:32 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 27 Feb 2021 10:03:25 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sat, 27 Feb 2021 10:07:29 +0100
Subject: Re: [Cocci] release of version 1.1.0
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

Hi,

Great news!

Could you please create release tag on GitHub?
This will allow me to add this version to tests and add new opam package version.
Currently, I use these versions for tests:
https://github.com/evdenis/cvehound/blob/master/.github/workflows/test.yml#L25

BTW, is there 1.0.9 version? I see that fedora provides 1.0.9 version,
but there is not release tag for it and there is no opam package for it.

Thanks,
Denis

On 2/27/21 11:11 AM, Julia Lawall wrote:
> A new version 1.1.0 has been released.  The most interesting change is the
> ability to put spatch command line options in a .cocci file, for example:
> 
> #spatch --very-quiet -j 8 --recursive-includes --include-headers-for-types
> 
> Other specific improvements are an improved handling of attributes and a
> more efficient treatment of header files (all thanks to Jaskaran Singh).
> 
> Various other small issues have been addressed.
> 
> All of these changes have already been available on github.
> 
> julia
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
