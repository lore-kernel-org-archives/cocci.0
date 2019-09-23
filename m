Return-Path: <SRS0=+zv9=XS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2534C04EBF
	for <cocci@archiver.kernel.org>; Mon, 23 Sep 2019 11:18:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132B420835
	for <cocci@archiver.kernel.org>; Mon, 23 Sep 2019 11:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="rgKGk352"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132B420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8NBHo4a012558;
	Mon, 23 Sep 2019 13:17:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1126877AB;
	Mon, 23 Sep 2019 13:17:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4A121779A
 for <cocci@systeme.lip6.fr>; Mon, 23 Sep 2019 13:17:48 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8NBHlC5002720;
 Mon, 23 Sep 2019 13:17:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569237467;
 bh=pQcdL8p0cfAGYurJCM6gBy1rxlpe+L3dV87WzCg6m/U=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=rgKGk352XZxH73BsQB7fWR24dLHUSmi+2Dw8KFWKm22OSI41sgYGB2+9fyOeNfWB8
 /LEVhhRo3c3fvDp4K0uiRwZUHefDFC/jbfEy/ddOb2j3WalKurFZXAasY5EuWpqnQO
 k7cPe2oWTAvNgR00Hh8TS0ETEj7mPFRMg1rIWBRg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.187.72]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LzEO1-1i89Ax458D-014QZC; Mon, 23
 Sep 2019 13:17:47 +0200
To: Julia Lawall <julia.lawall@lip6.fr>, Coccinelle <cocci@systeme.lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <60d48f4c-e187-6bdd-432b-9101888e7464@web.de>
Date: Mon, 23 Sep 2019 13:17:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909231058380.2283@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:4KdZPc2z17tfWhT2YJpckyIOBdTQ8t1l0jE2Lx1ZCcTyq5uNWM8
 ZhJJg2j4UkoP+MB6Hm55xqztoM7uQ0oQwvpObtD5jc/rz4yuaGPZkxdap1Fcu8n3FzP6o1m
 dGQYlXxhDmZyn2TQZzJUf4RtzHOQdQ+7MoxH10yeWnruI9Ne+4tED2ySyzcvXY6VhlkGpiQ
 28tXKLxw+j+O6lOoDEYaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1y1swfKcg6I=:+VELLiaWF6Bu9bhOaxLxcD
 gwctaWcSvEUCJQJHzZJjGN8qMK20raNNKCAiSQ0y1GIsPO8Wb5xLqRcJli0bpr8dXRlnfjQ9r
 t0S5n1WIfjI2yQtFz/TmMMXzeDtVD9ULmnIvHi4TyRiqP3aTy8n8wqAZ/lUdF+YvFdfsbKakj
 ivjsbmOXAE/290wkQQl0i7wLoR993LMJNpqsvsB2tZOrOVkSN5GYhNRnW5OcJ5pk7mtNqiI31
 XQ2867NXnq6us7HlZWOm1T+wraHkAH9fUpeQTptjh9Ut82X+xfEebpMBUfu2FYgMh1SlABFVu
 ZofqUA0zhTY+rXgCT5KvnCr3pS9SKiECrferf+/W/VOuvdCOctfqhXb+e4R1momXthr5KF6j6
 1qvpr4IhfKt6b6yoSoVRgBVebgJclNvv9nspweZ4XCDwc1t/7g3DZQh346ksCay53WPWoptfL
 1YkXAa9ElK+3qADsGn/YLCq5DrRqVo48Iino6vcrdw+xXDZQKT+sT7B8+NHoCilNgP2OkZQ91
 ILsxI8zBeeRae/VwxEuiDfJi8naXTV0DgBglPk102NN+g2w9PfnFBMFGdtNjeckXaF1acgKmL
 twAzQU7AdJiHbUzDvceUVoH7L7ahrNvGVnyg37POz9bqToicoVaRKCBk3NyqlKJAtzMAarKfC
 4/zXL1p8Y7i8wNnyEqGslU0YUgFhE4vkXJtckQVuVAXJOHfUKB1ASQi25NOJN00O4MADRG5AG
 ssmicgcbckd6nXgrwHYRyljVqdQriIFmLvSlpBad4wJoIpnU4VoELZslc/lxxPawszrvuihy9
 s9RLH6xNa9s/qyMDPwkpScbQd00xocbBGlt3jDQjKunecnkw/ypT1yqRvpMLbrxY92KwECaKR
 DJmOHIQiFzT6wxVkM9xEd0OzOz5qd9YZlRoouJ7yFt1MjcJhvc5lOp4UQhexMaj0snjFmSbO8
 m7Q9QikguemU6R7nxtAcGAZo/pN1tNUVstmm8Y6JeoKaxCyI1DAtfzQYjs2Q6rI8FPPEcIfJQ
 yKVLqkGpHuA905EpZeM79lCkeChJ/G0NXf+oXC0afLrOk0YKDwPVjljn3NfF+JhzwUPauPJTR
 tIesaVXp3MDRMmcwQh05SHjV58wRSLHZYKzpeLMglimdm3lR4U5O+wiq8g9i10TPkU9t8J8q6
 j1+SVSREg2JBAbgeA7jRjOmzgjE7hRUhb/BEPQwyfTfkNVGwBJQk+6pfwYuBf1I1LnFhBBbF/
 GzqsjLxRVsZGunBASAKhyDp2+8Vb0co5Jblure4vh/zh80CtnItbRuQHxEU8=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 23 Sep 2019 13:17:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 23 Sep 2019 13:17:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org
Subject: Re: [Cocci] Reducing source code around return statements with SmPL?
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

>> The following small script for the semantic patch language
>> can point various source code places out for further considerations.
>>
>> @replacement@
>> expression x;
>> identifier rc;
>
> Add: local idexpression lrc;
>
>> @@
>> -rc = x;
>
> Replace by - lrc@rc = x;
>
> julia
>
>>  return
>> -       rc
>> +       x
>>  ;

Thanks for your advice.


>> Which adjustments should be taken better into account for this use case?

The shown metavariable combination is interesting, isn't it?
2064 Linux source files are pointed out by this transformation approach.

* Does this number need any additional thoughts?

* Will it become helpful to integrate such a SmPL script
  into a corresponding Linux directory?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
