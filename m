Return-Path: <SRS0=Ayxn=SQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF54AC10F13
	for <cocci@archiver.kernel.org>; Sun, 14 Apr 2019 08:21:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D93420850
	for <cocci@archiver.kernel.org>; Sun, 14 Apr 2019 08:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="c9js7BR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D93420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3E8LAKQ005861
          ; Sun, 14 Apr 2019 10:21:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0E8CF771D;
	Sun, 14 Apr 2019 10:21:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 18AC5770C
 for <cocci@systeme.lip6.fr>; Sun, 14 Apr 2019 10:21:09 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3E8L8Ib015096
 ; Sun, 14 Apr 2019 10:21:08 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555230068;
 bh=CyQl6cOS65F6mrG5GSqD2BHo4odaTMiXiJ9iATFSzEw=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=c9js7BR2ejql8txIr9jzThBL9YeETYFk+4QVnugtn1FbKgu11ZcYSNDvrCwbyy6Q0
 0R3SGb8neYITYA8J4mCmIik/VeJAGOvd2tq8e7Kf+ENm2EJ0v+neOojcDWJd4Zzh1h
 SWCkZSZR4IceGXkAXxPtICod27FI1bA/HMLymZeA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.103.133]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MaJse-1hZJ633hqS-00JpNr; Sun, 14
 Apr 2019 10:21:07 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <ce2b0c4c-bc85-0341-ca0a-9b158804943a@web.de>
 <alpine.DEB.2.20.1904111728380.3143@hadrien>
 <88620f8c-3762-ac4e-5e0f-6115a21635fc@web.de>
 <alpine.DEB.2.21.1904131737540.2536@hadrien>
 <ada8fea1-1b56-1c58-5a78-8fc95006d203@web.de>
 <alpine.DEB.2.21.1904131743330.2536@hadrien>
 <566b0019-021a-0415-4b98-b5d8c74beb83@web.de>
 <alpine.DEB.2.21.1904131802270.2536@hadrien>
 <bedc9f4a-4d02-6898-0226-6f9e67d5d870@web.de>
 <alpine.DEB.2.21.1904131816130.2536@hadrien>
 <b2fc8f6b-b89a-ee77-fdd7-0e219d5bea27@web.de>
 <alpine.DEB.2.21.1904131834510.2536@hadrien>
 <934077c2-a431-afb9-e7f5-0909d45abe2e@web.de>
 <alpine.DEB.2.21.1904131905320.2536@hadrien>
 <f30d46a4-db37-7e97-6fb3-2cc2917fd432@web.de>
 <alpine.DEB.2.21.1904140946570.2615@hadrien>
 <a47c2d88-9f8c-d644-ca34-351fe1636f35@web.de>
 <alpine.DEB.2.21.1904141006320.2615@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7fa971dd-8347-70e7-bf27-9ca102a61470@web.de>
Date: Sun, 14 Apr 2019 10:21:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904141006320.2615@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:SkO0uMC+lvYY3lHhpT52XUystJuJiE4JhrgQYV2vr1qHOWMgH57
 B+fH9n651UGJ0Bnf/d2MrQGOnAZIHZzqicOsK4YRfsFOqMZNflZAf43DDxHQ++o0Qt2DPt2
 HtRIKAV7lLESrFaYgsqCbo4ku84qyH9pIiYucpr9yBORC/fcm0EvPHVN26TwRXzysVfuasC
 l6L9joXxM2TKM0haiYctw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5r7bbY2NsWM=:chGEgPt/RRjdziqWvO0cQa
 Oi8lIAZ326aXJroJw33NxQHUGGqAbUnbhe1Pf7KaepXRrXBiHyWwNzVcOKVkHnLWwCnb1Bvfb
 zROWe8iadSdJRHaq8YmlOWSRYbgYfc3/Z44C1kXIdUcqbL0H4jEm+pn81bGWm103Hn+IoWv5N
 yJGD/vIhQknm9/OhJe5wojM9KCZE9471gQ9u8K8/jKRLa5Yl8v9IkRZXDf0O+09Hdk3gbwMWI
 DecCuUYfaGTAAy3tEATCQWDUNKH5uHyix43Acz4Mr3+N+r2lWoB/xjokoFQoDttOAme0fxWyu
 zuJnol9cuhmqhKmcdq2VwS1Q9c61p9vdi40pxSa3yoqJZy20jgqB0f832NaaKta0oLfe5vaaP
 7PGMobc4tJsEaQx29Yru9I3DHRC2a5cWyWNP7yzAafwOzAXWXkbRmLzgolJUo54T/ELIauzA8
 Kd2m8YOhdy3q+e+chUb3I8XzeuC2w2zreUK182hQ65KeUla+TGOJXnvWDa5KfV+mlPMHl9lFK
 sct1+vzkRyZjB+tVshUhrxrT9sc5Jthm4ZCSi9PqXhG6BJK3H2O+p7wSFljycFCB4MaC1ChyP
 Si1FR7gnA8ufl/KkiumIvt4IygVMzMDRjrs8lc2wnpHRlAmxo2tBB7d9nwpNBv76nWmdz0n4a
 P7I74rlOvqp8zX3eEqNrqMoKM7rXxOsk2+SluPZbyxdvNlRtpXb5g+c52wd/l77irHlvmICd2
 OyPCOmqq2sCnMrQXm+aWcrsbM7T06jS6VgquCbvS9c9V2sIbMFs60i1TowKjkMtmjm29YziZT
 yM6GYQP93HajPNzi0vy8m2PU3Ot8fBy/XLjpxDwlvpIu03taY3QS3h8dvi6pfBLH63ct5U5Yi
 MkHjSsa64atouULTiIzJO6HnjPq8wIaJodoeKzVqWwi9mCfowKFwjlAa1mveeCbp8IdvSURU2
 Jf3C8GDB6tg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Apr 2019 10:21:10 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 14 Apr 2019 10:21:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Clarification for SmPL functionality around position
 variables
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

>>>> Variable find.p2 in duplicated_code cannot be used as both a position and a constraint
>>>
>>> I think that you have to declare find.p1 and find.p2 on a subsequent line.
>>
>> I have observed the same error message then.
>
> Go back and read what I wrote.

I suggest to take another look also at my feedback.


> You put the metavariables on a previous line,

Yes, too.


> and I told you to put them on a subsequent line.

I tried three different orderings out for these position variables
in the meantime.

Will the implementation be fixed for all affected software components anyhow?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
