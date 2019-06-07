Return-Path: <SRS0=qtAw=UG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B63EC2BCA1
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 17:37:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEE620868
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 17:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="stSorJt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEE620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57Hatvx024919;
	Fri, 7 Jun 2019 19:36:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4334D7770;
	Fri,  7 Jun 2019 19:36:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7E5F8776C
 for <cocci@systeme.lip6.fr>; Fri,  7 Jun 2019 19:36:54 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57HasPq029691;
 Fri, 7 Jun 2019 19:36:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1559929013;
 bh=GRFwDxUOKPUPIkIIHlm7hOWYGyTfYpUBSsrllBvuSwQ=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=stSorJt34ZbdoXkPW1bMyRdgWtn7BLjmuK7hZgnqu6JmhD+e1tsUl6xYm9vtuH4Qh
 xWsVTrtfggQ03UuqaUF64ZUNWN5WhKTMdZBOb2a/i89wIfPlU7LYEGo0e8IpeioROK
 dBYrvYLYWJAr4xEqXp8mP5m0vTj/QvGOcGwpADq0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([93.133.66.13]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lc8Xx-1gsVqi1ffR-00jXuD; Fri, 07
 Jun 2019 19:36:53 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <69c34970-8b6d-a2a3-2e8b-0b6560f78505@metux.net>
 <6ebd6ec8-bcd0-3dac-8992-a6c8d9a14939@web.de>
 <alpine.DEB.2.20.1906061137570.7612@hadrien>
 <9745086a-cb39-b751-9cb4-faea0308e3a6@metux.net>
 <alpine.DEB.2.20.1906071430450.3692@hadrien>
 <c2cf2b61-990d-af7b-2228-0e79e0daa0ce@web.de>
 <alpine.DEB.2.20.1906071833010.14523@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8419d17a-eb16-a8c2-393c-05e0dee53f92@web.de>
Date: Fri, 7 Jun 2019 19:36:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1906071833010.14523@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:IVAOKGzqi5aiGXFtUR2qxnmqvVBXd+zRdqn99/KfkOMIFBfsatu
 9B8iOlhqGo1GfHaJd2vP9+xVHLzLVJ/JDh2R5iFnkMoMXtLRvPC9NaibpkFEtu2gdT9Ugsx
 uDL26jA/WrWzbKlppxy0Nmie1mjY1hME/CAaBGXwU74jmTTPypKgyMoZIXsMeUXQ58+cHoT
 7jpv8ZqHsBbutWShDn5Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gmxc1ffHqyc=:4zvyrMqD/LiwoO5mGfClyC
 64+hw3eE0YGOnDjEPS37Q6kwn3hJGamXb3JEDQpAAMNo6fZ7RIV0D9nfk7+Sph8R1pZsUUtHa
 2hvEykHijf5Mr+6tTO6+m8ZItOkIAwP03WN7R5UdNB+CvXu0q/n4mQs/0mSdUH6V4+IJmQlHn
 b0/9wmRO1aulx91QLr6Svjwj1/egPA8R5tYUObGx54H8wSxV2CFOYhLTk6Qmm3/ppaaSG0ShE
 xpTbR6brAZpP/VDnc9Jln+m43EvR0HX2zGSK+CLbc3ELJODEZyLmNihj7+FTjR8iI64hdGC4Z
 LSoeFmsrzlOmhMHAX3jjdhO4MXVUc4krul/XpOUVtswD1BhkFXOK28TKHMYAfyouE2ie2bz1t
 Y+5LTIAyUxXPuXUbuOB2PBtU41pwgtlMrM89wyIciZvhlPdkJiLz6tUMm9HYxrJlEyUqSJyXe
 qE1NQDUWVKSFjjx8389w+GnUkFhgzMB/a7QVCo1SRaJ79iVwq3dAk6HFZ3Xuiv9I0AvueQu2p
 uHhuAnMp03j8FPkEGCIvvPS1rcC4J34JX9rJdtI4VMHDcfWcLEvnWXxALwDNmsRCWC0buaLe4
 moXEgvvIU+ElDhzMcQO6QZ8TYQ1/HvoGfGWk6AoqRV5XN3n4DSST9ng1ptc68wy2hY9qRujm/
 +NAe8++XKXhJqreCU4ebGhdD868ysLL4hoGlx5M3yI+zAfwiL3J7PAPKsPEcAMlfW5PJuoeJS
 tNaTroMb2aWi4cugLTeme2/zSkSINekRzIqA2rovGSLzLEFsR7xbQpiQHe0uGOi6WhGbEtsZf
 MmQSkp0OXHtr8sFwg13emANvF+r0gxEFt/cKWyMC82oQdl5+B4+/J6+ReWVa6wHKyczGfVKvU
 pLskkdOXZxbsGIgpHfmABRSqXuJgSm8cA8Z5WxEcT5MAJ0SsaF419uIYjtGXW1dowBOciNdMz
 MMB5HEJ5MF3nkWQWfY19NUfRaumTgtgKh3nyZ/Ojs8nEyr5lTAxtH
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Jun 2019 19:36:55 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 07 Jun 2019 19:36:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to replace obsolete #ifdef's?
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

>> Will similar software updates become more challenging for the initially
>> described handling of designated initialisers for known data structures?
>
> This is in the spirit of the solution I already proposed.

Would you like to compare transformation results also for the following SmPL
change specification?

@replacement@
constant text;
expression value;
identifier my_name;
type driver_type;
@@
 static
 driver_type my_name = {
-                      .driver = {
-                                .name = text,
-                                .of_match_table = value
+                      .driver = {
+                                .name = text,
+                                .of_match_table = of_match_ptr(value)
                                 ,
                                 }, ...
                       };


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
