Return-Path: <SRS0=qIOj=GO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF2C433DB
	for <cocci@archiver.kernel.org>; Mon, 11 Jan 2021 20:32:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BA821BE5
	for <cocci@archiver.kernel.org>; Mon, 11 Jan 2021 20:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BA821BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10BKWP9C024072;
	Mon, 11 Jan 2021 21:32:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C56BE77B8;
	Mon, 11 Jan 2021 21:32:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 725F474B6
 for <cocci@systeme.lip6.fr>; Mon, 11 Jan 2021 21:32:24 +0100 (CET)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10BKWNtr014569
 for <cocci@systeme.lip6.fr>; Mon, 11 Jan 2021 21:32:24 +0100 (CET)
Received: by mail-lj1-f181.google.com with SMTP id n11so363706lji.5
 for <cocci@systeme.lip6.fr>; Mon, 11 Jan 2021 12:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g3/RKR0hNZqHmuxznPhG0PqvZVGH0uX2t8HFGpsMVhg=;
 b=Gv3fuckZ1mgVTq8qhlmSTtN93WdoHAit36blLaamLE9L9INTxIfK1hR4t7XL9OZhfe
 wD/gmwPGiuYyE6OZO0X90miFtICYPMkmKr3vjVPaHW6kAS8kEUy/Le58W2EPbepO3282
 nuaAI7U8ZAGUqegHoIWGs46LDvmCvBc5JPHXjPXCe3En45k9mjdrlR3bMX+2mEVP6WA4
 6RJ0PKlcOk+zbxqHlv5owaV44XZqGzJ1Eljrm3W/gHKybYad1R3i4LTtmleF2hnrd3qR
 4r2Zsb/am+O+TUMjC/XRNEeRfdEWZajO8An6PMU4nloBIwvUVUXxjK+a25tADBGMhjNj
 qYAw==
X-Gm-Message-State: AOAM5329Qp5Ygdtyi0S/838QQyGlDtpQqQHqfKrjqwXoucI2U51eQkbr
 bB1PiVziOT7V9YvWv4ZeVzKcBavmjaLfPQ==
X-Google-Smtp-Source: ABdhPJzQuraaKwvtCU3JsdS+wJRBZhjHRc1wPlbxwPJ1CipF8mdGCfhkJwZqOceMgal9oWsq2+Nxrw==
X-Received: by 2002:a2e:8512:: with SMTP id j18mr547873lji.31.1610397143325;
 Mon, 11 Jan 2021 12:32:23 -0800 (PST)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id c16sm102810lft.264.2021.01.11.12.32.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jan 2021 12:32:22 -0800 (PST)
To: Julia Lawall <julia.lawall@inria.fr>
References: <854fdad7-cf2d-49d8-571c-1ac64fa90fb6@linux.com>
 <alpine.DEB.2.22.394.2101112122350.15982@hadrien>
From: Denis Efremov <efremov@linux.com>
Message-ID: <a9c270d0-19c4-0357-173f-a2f9c8a1d7ce@linux.com>
Date: Mon, 11 Jan 2021 23:32:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2101112122350.15982@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 Jan 2021 21:32:25 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 11 Jan 2021 21:32:24 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] How to match function-like macro calls,
 e.g. RTA_ALIGN(rta->rta_len)?
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



On 1/11/21 11:23 PM, Julia Lawall wrote:
> 
> 
> On Mon, 11 Jan 2021, Denis Efremov wrote:
> 
>> Hi,
>>
>> Let's suppose I want to match otx_cpt_aead_cbc_aes_sha_setkey() function from
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c file (linux kernel).
>>
>> My pattern:
>> @exists@
>> identifier rta, param, key, keylen;
>> position p;
>> @@
>>
>> otx_cpt_aead_cbc_aes_sha_setkey(...,
>> 	unsigned char *key, unsigned int keylen)
>> {
>> 	...
>> *	if (RTA_PAYLOAD(rta) < sizeof(*param))@p
>> 		goto badkey;
>> 	...
>> *	key += RTA_ALIGN(rta->rta_len);
>> *	keylen -= RTA_ALIGN(rta->rta_len);
>> 	...
>> }
>>
>> $ spatch --no-includes --include-headers --cocci-file test.cocci drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
>> init_defs_builtins: /usr/lib64/coccinelle/standard.h
>> minus: parse error:
>>   File "test.cocci", line 13, column 9, charpos = 219
>>   around = 'RTA_ALIGN',
>>   whole content = *     key += RTA_ALIGN(rta->rta_len);
>>
>>
>> What can I do to match RTA_ALIGN(...) lines?
> 
> I don't understand the problem.  I took your rule and your command line,
> and everything was fine.

I use version:
spatch version 1.0.8-gc1dbb4f-dirty compiled with OCaml version 4.11.1
Flags passed to the configure script: --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --with-python=/usr/bin/python3 --with-menhir=/usr/bin/menhir
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

Maybe parsing error is fixed in new versions?

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
