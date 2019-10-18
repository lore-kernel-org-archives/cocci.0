Return-Path: <SRS0=N+LH=YL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A236CA9EA0
	for <cocci@archiver.kernel.org>; Fri, 18 Oct 2019 14:47:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D74621D7C
	for <cocci@archiver.kernel.org>; Fri, 18 Oct 2019 14:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="C1sg2XIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D74621D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9IEklSx004543;
	Fri, 18 Oct 2019 16:46:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B431D77B8;
	Fri, 18 Oct 2019 16:46:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AF37877B4
 for <cocci@systeme.lip6.fr>; Fri, 18 Oct 2019 16:46:45 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9IEkjGU028306;
 Fri, 18 Oct 2019 16:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571410005;
 bh=ayg/ww/AhZUNobbPz0+K6x7VViKV2pYZWEqju3QvLRk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=C1sg2XIcCIOgl1k20l2WzH5f6a8/VFqUC8uyuyMf96QxftDxYiVZ9oHCaObD/Tsgt
 bGSLmcUQC0mQ4kEFOl7naANx6CN0lOsh2zmSxv7M/61NS/V3875IdVEvvz+BiLvE3M
 LPH7/jAyBkgqGdLbeSZRnMTfjko7mNEWn3lWC71U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.164.145]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCIYT-1iCR7N3ut7-009D7p; Fri, 18
 Oct 2019 16:46:45 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
 <alpine.DEB.2.21.1910181530460.3697@hadrien>
 <4df6f184-fcc0-343d-2460-0b2dee55fd0a@web.de>
 <alpine.DEB.2.21.1910181548450.3697@hadrien>
 <28630366-9e3a-07ef-8ccd-a42c35a3a9cc@web.de>
 <alpine.DEB.2.21.1910181630300.3697@hadrien>
 <48013059-fd23-3e79-3f0e-0b421ee8967e@web.de>
 <alpine.DEB.2.21.1910181638310.3697@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5359c9dc-1f1c-fd23-b09a-76d08aab517e@web.de>
Date: Fri, 18 Oct 2019 16:46:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910181638310.3697@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:elfK+54Ln/KCtKDcPSas2LSixOJ9U3KmuYHpgnjQx9tZiIxU3zn
 Xor3GYx8vg3bGaK+sclROUaITQq800hcgbA6y8BHn5dMPIgxwqNcg+TPYgQ3Vv9T3qbKwv+
 J7vOfOhvXkFQkVuIkmZU+m2fW+URPrSwqwejAGQSqI/Nq8//aWjQeW29c0EYiDZPW1WtvRn
 k+ib2o7nfDJB9Ix9NxajA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1pHdKKd8hA4=:cObi916AU5is4g4LepWBTc
 sB3ECsbTzirSu+t23f6uP6p+gQ0aZFr3ihpKKCSqC+gptccxpBpBCqN3QixNwSCPoyjdILLLI
 XdHWDovjZwJdqXoO71iXMy0HO4GLaAlO0SfD8nmUplzJyDe2citJfhhMmSWkiHdVmyflx9RGT
 n+BenD+2C4/Cw4gj3s9QBD60BK1j5vzUMKLXyuFmNBX7oFJ6JxO2mQZAAgN6B8Wsfk0JPTty6
 XaRznzWydwKjgvoHqjWqFzL9tq0fEjSN5HFikAXzw80Es3RwTYOTFXu25ppKhm9mZXGma7jjI
 rSRvsHZCziDp7UDdku6keTOFL8Xz0rW32TCxlc7Wrj6otKyjeltk2ZFHRu4u501fNZBxrFzzI
 YZmIUnTunPGSti0zf0lYftvkyaIy22WDubRnenws+aN+9MlQjhO+yDQmKSlcbi6ZMZycNLj1Q
 b5Tj8r3HHYlfy4LyFz59WgosU6tHyovTlf/9MqyL1PfOf8Eldg1uOKrl2PhbtBPfljRFtc0fO
 FWidQ7qXVOPM42irRJ75t7E3qFumDssYuT+n5bFiZmT07/h12ot2Fau0yVjYwrqTrRv945pLW
 kOCOW6QAddxdg2XadZtYfwMyKRQMkLcKoM6FtZ33IWJBvGEBg68+8ixWHhUZeHFJeC0mCdAJi
 RHmko3iUYzfw5xW8SZuINgelDXL+UUcsS+SpibPnp/eVxkt/llae+MdQkq3JQa0uDesA6udcK
 +hsnqVv8mL1/DXmsOiuyINo0ICy6EsNNiqi4MzPI7aRBKf+UBIXgMhRXHoBj7C33WLEFwp9un
 tbT8RGPEu1bwrVpL5RUNeZ2uK5tcl7/jGm4N2i+AxLCsSa6+OJb/QHoAUZ1IvLDKeswvrpuiz
 5LudyWtdp5Pc081ebewcW3C2mDrqZ6+UwZvWWEe8ipEDN6sIQs+K0tyTU6Oy/10ANp7om8zjc
 Qa0yw/7iCVg17QJODv7ahr4pMTarL8sMToXvAfqPkpIdjAGpYI3YQSFXdZkcEp3xfnK9zYAsr
 HJc5dgl20LR/hoeMEBnRxZqmyeCd6EpO/zWe0+nJ6SR0oUQrnrKhQrRipiyFBiyvs/K+2TQNk
 NVEsBmVyYlShZTMm9GBWXK6yMcqXfU1eyL6spRZlGDV3hW/ojnlRDVY9Oy9CLydY2P8+1nDZf
 050HDq4iNwpOUnqPzpiIMvvdx4h86h6uhfcFY6HW3Njwu05lDRHUGmBxPs7/xTwmFQXrPisE9
 WeDx/ADQmKowZg031oUlqk1OZGwiZkbLaN3wJYnsmBtZ30BRRM4qLI1+9m30=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 18 Oct 2019 16:46:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 18 Oct 2019 16:46:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked pointer
 function calls
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

>> Will the distinction be improved for the safe usage of function pointers
>> also together with the semantic patch language?
>
> I don't see any reason why declaring x as expression *x; should imply
> anything about the type of the value returned by a function pointer.

Function pointers have got also the property of a return type, don't they?

I would like to restrict the kind of called functions at the mentioned place
as precise as possible.

By the way:
Would we occasionally like to exclude the possibility for variable
assignments with incompatible pointer types?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
