Return-Path: <SRS0=ltHb=6B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06033C2D0EF
	for <cocci@archiver.kernel.org>; Fri, 17 Apr 2020 18:56:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9C1206E9
	for <cocci@archiver.kernel.org>; Fri, 17 Apr 2020 18:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="aPc+0WwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9C1206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03HIuUAY001064;
	Fri, 17 Apr 2020 20:56:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 05C3F781A;
	Fri, 17 Apr 2020 20:56:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 287B73B93
 for <cocci@systeme.lip6.fr>; Fri, 17 Apr 2020 20:56:29 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03HIuQAf018668
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 17 Apr 2020 20:56:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587149785;
 bh=64JRdsmY3vft4GjYrScN7wZM0ZEser3ok/EeACEgoOM=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=aPc+0WwXTTJOodYC2gIAdnyy3K23xEhfcW5ROEeyrIZuK1YAGXr8W+Ka51Acg//u7
 jzw0mdZ2XK9V3vtu0khqM3xKu4ze82DpGSxH+myYj2FhboxhTXjOkaC+ee5b3UbU9C
 Zy06ZLTZhPh/DvP2u3WdTvOLb+eMVRlqunWUkDDA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.97.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwYwF-1jBEAg1D7X-018GGk; Fri, 17
 Apr 2020 20:56:25 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <alpine.DEB.2.21.2004151949230.2381@hadrien>
 <5702b553-d054-33a4-8544-f68ed5457acc@web.de>
 <alpine.DEB.2.21.2004161052210.2447@hadrien>
 <0365dceb-3b66-48cd-c273-4bf7fceb4688@web.de>
 <alpine.DEB.2.21.2004161444300.8125@hadrien>
 <735a3c61-695b-a857-b0ce-8999b04644b1@web.de>
 <alpine.DEB.2.21.2004161627300.8125@hadrien>
 <fc9f592c-ffe9-947e-3777-8791d4952daf@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <96a828a3-d977-e5d9-b7a8-10c976f41cea@web.de>
Date: Fri, 17 Apr 2020 20:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fc9f592c-ffe9-947e-3777-8791d4952daf@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:rHfnX39hGmHoqtW8iUsT/WNMhceYpjHx+1EHllYDvufPZ+Clfpu
 ZbSx/ygv7XDik6qRYyJhEQJxME3TsBb3i+Nk0/yFj0Sb3XeO+03PNk/Pg1H4PTxUJoGPjhu
 TJr/jliLAZVe+HSwvqlxtYLZvRda46QjDOud+LELrXxxvYwJzHpeABaeaYg7PTeUjhv2lIu
 03P3DIbgESHhRRdUEsFeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pZj9HY5SI2o=:xnDNO+Ywrn/3OdF0Ywcws7
 t0QPvbS3Gx4AYzC6famLnWboTkimTiZF+xkxkCSHCVf2eaL2zlv3ngCvws2+CJjoC5qS4XtEH
 qNDshg8mCg8mrR2ukF2wSH5vYWmDEJHPTmpuAmNVPNW1YkT+q/d4ogWqJc82d9RaQV9ZHVB/C
 Cb+lKNeNOrrfc7p3OiLBT2gqlC6n50YPtoD3geNvzGLGPg2BgOqhxUHuGgACEWQ1lk7JIAhpu
 QVommWkB1XYZFJbbDHX1+JssZhAgcb93w65vjsfspzVAl2R6oyZv8mGAAdOwPIqqFF2oVq3js
 ykpcKiQurvvN9XEGXWYZiQ8FMb7U+e01JfkT3gB5b8txZJWQvl+U5c7S+OLNbTmQGzsL7rY8t
 m103ny9otwBFfweB2sJhh2+UEVN0YjUv/xTtn1N+ou5/pCRn6BBMZpI78PsFJEJgxyCYf/ciF
 x2swRVZBTuyww9EFdtfnyFXia24KXDfBgdJjrEPuAywA7fuROR6No9A+9GEb4aORMDkOSspQv
 m1k42zm3kbyGTOugR+yTUxWLwzfcMtNm/JTyY3hFIDXFJYloteHRGD7LQEHdWnwYkZ6TcHf3P
 zUs/y1LNhsaCr+EaT3o5cafUP5+0VCqn/xFfRLz2mx9BBY/pyWEc6JrJGmXLQuWP8hGG5MCMA
 Q7s/l47P9yudrDHa5yG7cDDcbnVNZAUNF4ES+Aee7tmeij6APn88QFYCuPLBXcBQAz86MSRFu
 BzTgVibctrgyvSD7rI/jV6aSeF4MTxPpNrmPjORuB/ir9CXEBLCExsdb6UZ7Jdq0P8DrRiDRU
 H0jfVFmRN9OpL0yzQDFiHa9hobY9RV3Cp7avD/3taFXtZagsjI7nOjil9Ow2bGitYLuc2vgvp
 o9UI0NDJWFRuhxL8YdxTJzkeszDXlNCAiYeQ1D3tEvjYJNrLrr5AM8r4PkusZQxJG7GJJjK0v
 gdsRxPOyyJHJ384p84bo5IN5dhTvzrDnKLTQDgkcxbf8eHfvrzzOug27NvJ+ofOR/fW6+AEIT
 Cb7W4HCMLtkk39/JG/mokXJvy00+KuQpf7ctyMUkr8/M1k6FuQ/XYs4cJKLhNJBTMvSFTkhbP
 ScuT4hTXoWM/uII77A5awP7nz+ASjyrSJ15drl3S8rpXPLUpcDqG5fIvlXSpobdPA8QH5K1Y8
 v80wcONSyMqYXNFLK6f7E7mFDiXHy25GEwCEWpA6fUd2LXuR3HD2H9RclJnCpdhtwqZ0PuiBO
 zY6TS8WHNzndcLAYT
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 17 Apr 2020 20:56:30 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 17 Apr 2020 20:56:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Dejin Zheng <zhengdejin5@gmail.com>, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the replacement of two specific function calls
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

>> But I have now lost track of what the semantic patch actually is,
>> so I don't know what is the problem.

Another possibility should be taken into account for source code variations.

SmPL script example:
@replacement@
expression base, device1, device2, index, private;
@@
-private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
 base =
-       devm_ioremap_resource
+       devm_platform_get_and_ioremap_resource
                             (device2,
+                                     index, &
                                              private->res
                             );


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
