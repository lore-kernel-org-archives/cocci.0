Return-Path: <SRS0=17+G=QX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43BCC43381
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 08:44:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7C7222D7
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 08:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="GQTPpAW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7C7222D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1G8iT1h028549
          ; Sat, 16 Feb 2019 09:44:29 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 796B676FA;
	Sat, 16 Feb 2019 09:44:29 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EF0B576F4
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 09:44:27 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1G8iQn3017849
 ; Sat, 16 Feb 2019 09:44:26 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1550306647;
 bh=Wv4RY9Iv2iNuAyTIbgEvXN0i2ER1qisG4NsPV0EopVk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=GQTPpAW9vlCEYvKqLZ8upOpBHNOqUOFbI841PStRcPUMj9FiUePO6732OWVON+ZEw
 vjj2xPWtMvbM6ic1PpK0XaQWvhWEbOpnmmtwNeh2+4vjnwnxt14JH7j3NrkS9FNrs1
 iOxw1o/qgmVnGv9GLjwdBQxlpdgED5HmpgGVP9Vg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.154.45]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LdF4n-1hKwo20RsX-00iRHJ; Sat, 16
 Feb 2019 09:44:07 +0100
To: Julia Lawall <julia.lawall@lip6.fr>, Wen Yang <wen.yang99@zte.com.cn>
References: <201902161529041506841@zte.com.cn>
 <alpine.DEB.2.21.1902160908150.3212@hadrien>
 <6a07c337-533c-61c2-d033-575539309738@web.de>
 <alpine.DEB.2.21.1902160931540.3212@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6c114d10-0d17-6f43-4c33-0f57c230306f@web.de>
Date: Sat, 16 Feb 2019 09:44:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902160931540.3212@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:zaR6rqC+H5I2c8ruNGBNcXje4c1H3cY908yNvRAXsJN4lKvSLG8
 MfA9s+bZGUtcyevsREmlv9UcfYtlC13IMl30mqYKViRxj1CKL6Pp8MwBzHxCV9rdx4e1cm0
 zp/TQGZbR4mZ1FwUngD8HUH0XjG3Pm9QOkWklEcbnUtRGG5ddpJzwqeXpTjJ6q61O5TtyLj
 ZAyKGPZq0dUC1Ym3OwoPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TtvhRHJDssg=:wX+JaFezTjD2yqhAAseERH
 bcpuR29u4BDbNxFIoMzstmyTVwoB7wIlFHBTRZqI40MmUOb86Vgw+TAVAJnuR9kxgN5XLOCIv
 GxOaOpo3gaqqH6qEPT9j7whdJhBOj8uoF+kYaguqaJv23nFjshOAFsMwpRMNFtclqEDvcKDGA
 iDChzxKAPQTe57u/uIhr3BqtsZpUMl/IwPIs0eAMBR99s0O9xLUOX1BC8JeItjl7tcDIA2aHa
 0qsEhvK+zgoL2pmuFqtizI1x1FP2OLX+o5PDRmmUKjMlbT4CstqFQeHslJattX7/ExnHL1Tj0
 raMwtIds5LyMTyP+SwmimzNDiqAMTcB04KqOowr/aub1jy3IbV7djka/IXvUXfK9sWf5blM5v
 7+QZW85dtYp2NVWzLcpvK8hzAnrxRKFqv6Muyc8ainpcoo32IN0BpuZYXVqQj03GwIFT4g01W
 RE1m5xhKqlRkAdIEV0MiHuKYEzcpvTNLIzoXX3BacHQDaFrjT2IeUyHYzyiDL9ezTUJ+SvS+f
 bTlQwZNa8uGZb2PkboIuPgkCAkDzOJeXi43v7h6UlUj28767S7Ijkeafrv2jE0093dQb53pTf
 dkA3RuRomqxIQCAvE3PJALdlASgmiyQUd/ONGjxa8avdARd6nErtwLkDFtza7nAslH8Y692vU
 dYImuVQ6iNnw7B/QtDOBCMAP+u4W6rMYOpVrRJFNWwFsDrsxh6IWikz1Ln/r9s3+X5KMdjYRt
 S9/qTgtdAz54l/EBvd/uT1jWLIhFBSKsQ10RutfhkiM+MUFz7N7EOwBHvdlCef8kKEB0TMlF2
 SRI4XyW0jetkFaXEMWDicXAUSDVFCJSm9oJR6hDayTbz1RguuOmmOfEvkYtPBpLZr050oYc7b
 LbruCcayKNRlEiSgc24sYg/dg9aqfgUiPUtAgSFH5h+MMPGR9gPOZfzcygKgkIpbQHhhWrb8t
 x40AdzSAT3w==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 Feb 2019 09:44:29 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 16 Feb 2019 09:44:26 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, kernel-janitors@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [v5] Coccinelle: semantic code search for missing
	put_device()
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

>> Thus I do not see a need (or requirement) for a duplicate search attempt.
>
> Why don't you actually try it and see what the difference is rather than
> repeatedly giving false information?

I suggest to clarify this software development disagreement by the following
SmPL code.


 ... when != put_stuff(my_pointer)
     when != if (...) { ... put_stuff(my_pointer) ... }


Is this a specification for a bit of duplicate code?


Or:
Do you insist to find such a function call only within a branch of an if statement?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
