Return-Path: <SRS0=mj88=UE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19176C28CC5
	for <cocci@archiver.kernel.org>; Wed,  5 Jun 2019 16:49:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CC220866
	for <cocci@archiver.kernel.org>; Wed,  5 Jun 2019 16:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CC220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x55GnZ9M006754;
	Wed, 5 Jun 2019 18:49:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D2365776A;
	Wed,  5 Jun 2019 18:49:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 832B57767
 for <cocci@systeme.lip6.fr>; Wed,  5 Jun 2019 18:49:34 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x55GnYTF007567
 for <cocci@systeme.lip6.fr>; Wed, 5 Jun 2019 18:49:34 +0200 (CEST)
Received: from [192.168.1.110] ([77.2.1.21]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M6DSo-1hWMsM2lIG-006gyw for <cocci@systeme.lip6.fr>; Wed, 05 Jun 2019
 18:25:47 +0200
To: cocci@systeme.lip6.fr
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <5c138195-ac1a-4ad6-c6e6-720acd4ea34f@metux.net>
Date: Wed, 5 Jun 2019 16:25:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:zzUdMyHTOGY+qkv1NqA7Igc/sD4adAtRF8ea4KWTWPIfnJCdI7u
 K3cy/O9l6gDb11Sw8Rmht1AB8J5UTFbkd27YjeiweFrEkFveEaLnvcxMoovyYOfQ+6+bVhM
 AKF8tbb+hGuiRqBvegWaAIllFzptpLR+YOBtRgi2zV+clzO45ouBIMP5inAKev9vWVXyYky
 ND6qz1024shKA62C5StPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BKX4psh57VQ=:E1uSC9VixVaS+C1itx9tUn
 WesV4a8Hr56/bpglicbU/Zqk+SqaPNZ5gytqT01+yGiQ0MgpewOSQg47aVr5cZnt96YbopnVI
 84d/dNf/UsOUoSQm32ETz5K8544UBIRL37vELtEcKQRPUAF52wqK3CBw6lwkhc6ryHMtPrL6v
 kIh1wzf/HmDSJGNYEuY5NLZVRyZR4sIczvqWACu3TaHfttUl1CADvadRTlS1sLBVlXT2sx3fh
 di8K0EDjyp3P8nhcgnayL/qtBR1zlooEhlKI2KnttDkaEjiTvXj/9JKbAOf1nybO4VvjfKnBM
 zYx4DMS8gfCBI9EOCBZjxKymiIkZUg/0upJ3aPKysf64OwrmqIuykBprf55tWEkdrhJM/k9Cs
 Baq4r4YtwZ32anTgBd50N14IafxqKdAhA9WTau7tB87Kuv4hs6AD5RCUCkD9TUrCFH3iOBbmg
 fPIIxR/jcCqmmque4GNf6iLU1vCHkdI07By2rkdyD4LSwVH2Fy6gg3Njh1zH2TTOSXY+tes0j
 vBaZ+8gIyAreCHRhhX4lfRbB+af0jd+nt0EaVswAGvtVWGfiDCAq8f5qhq9MCI/zjWpXSbZYC
 TJO5DfB0YEigHVtHrVOlpvyFusyguGlOnrM7DPkP7CRLV2D2+E01FnxCujOUArdiuLC6136As
 OuQijgP9GqmUJgQHBB8++dBI06uPSXX/aGi8WZMvBb3yzHDtlO4r1oxkGx8AxA2rn/i0wkJ2A
 i1ITn4xmMXpcuye8QqFzy21FUCP1IYSWPcz5ieAd9U/epOCL2+a4ZX4Wf6vMj6d9/wjsmM5ts
 HADnjOf
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Jun 2019 18:49:36 +0200 (CEST)
X-Greylist: Delayed for 00:23:47 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Wed, 05 Jun 2019 18:49:34 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] how to replace obsolete #ifdef's
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

Hi folks,


is there a way to replace obsolete #ifdef's via spatch ?

Here's my scenario:

In the linux kernel we have many places where drivers statically assign
pointers to match tables (eg. for oftree or acpi) into a global driver
struct - sometimes this is enclosed into some #ifdef CONFIG_..., when
things like oftree or acpi are optional.

Example patch for illustrating what I'd like to do:

--- a/sound/soc/codecs/pcm3060-i2c.c
+++ b/sound/soc/codecs/pcm3060-i2c.c
@@ -45,9 +45,7 @@ static int pcm3060_i2c_probe(struct i2c_client *i2c,
  static struct i2c_driver pcm3060_i2c_driver = {
         .driver = {
                 .name = "pcm3060",
-#ifdef CONFIG_OF
-               .of_match_table = pcm3060_of_match,
-#endif /* CONFIG_OF */
+               .of_match_table = of_match_ptr(pcm3060_of_match),
         },
         .id_table = pcm3060_i2c_id,
         .probe = pcm3060_i2c_probe,


Just wrapping the assignment into the macro call turned out to be easy.
But I haven't found a way to remove the now #ifdef :(

Any idea how I could solve this ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
