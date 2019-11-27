Return-Path: <SRS0=m0DH=ZT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EA4C432C0
	for <cocci@archiver.kernel.org>; Wed, 27 Nov 2019 20:41:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11DC120863
	for <cocci@archiver.kernel.org>; Wed, 27 Nov 2019 20:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="sO4Ed8XV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DC120863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xARKfFa8025247;
	Wed, 27 Nov 2019 21:41:16 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CD65977D4;
	Wed, 27 Nov 2019 21:41:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2DCAE77D2
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 21:41:14 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xARKfD79005970
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 21:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574887271;
 bh=m6eJASdnwqpW0lfNhIeNiQ6hgnJKzoCu8Dw8GRMGRm0=;
 h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
 b=sO4Ed8XVU3s8S8PafcPPBrIe2NJViKZWXFD53QYyaOWU067mb0FRtHuU/x7AnXolM
 7bepWMpTdiUEbFOMoCXJuqvyfb9/j9MTbEEdgOP2o7faAHpCWguChhn4chO1osrYz9
 sscwPDm61fvbdOFTwUs1HGB2l1ojSRh3zxjmKgVM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.1.60]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lc8aj-1i8jZq1bfh-00jZ46; Wed, 27
 Nov 2019 21:41:11 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
References: <20191127173815.24988-2-jaskaransingh7654321@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d36d63eb-0134-08c3-7566-aaefe3d8d7be@web.de>
Date: Wed, 27 Nov 2019 21:41:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127173815.24988-2-jaskaransingh7654321@gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:XM3Ls1W8XL2J70pJnYtySru6mvNTe3r8DrY7xIXIZY1+mSktK7D
 BKx5rZ3NCy9KeVZYnrLhk5ONUjotwYYC8K4BHs2y2a07YPTW4m5ZRsZVodqSnEmE6pnqyEW
 DpzJKizUP1j0jghvwrvudHzCk8ippdhboa4u0fIW50SZVFIjNlXyRdqhmz3U0nFmneeaz58
 eczbzScFQ9IEOrqVv7DkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YqMX9dQS9NM=:SHgQyoJMbP/iDOPt1IMQRG
 hZARIZKd4/MdAg+SpHCiVesZFCRFX2pnzu6q2UqdskzSIq4uT9tNEqOod593AwHoOG84CB+O2
 WcwgHi4Q5pavRfvijDtS64WOu2dN+KYtVeIbTvxmqY0YDTi50PPyBj6ZSo/FHGfQ/XMCRgIcz
 aoH/tN8UfCXGo7M0vp+qjoDCcJsiatuQodBYWGlcyNK+sO1NkreN/KCn1tHlUa5XLdBD9WMts
 rf6SJq7Jnhuy2AQ3OBUk5lnwGCoyGxOg6mw3/NhP/ECsYCaUTOA+O160KovkSq1Cdt78JOaFz
 3ofcmmDxd86oFDtTNg96Y4S1ptJaNd2QI3jQx45ZTP+wY7OzSflKXhRYleQyGn4FBWmq4n9tK
 VBBYPzTkj6ZnxO7sgOoPjIHQr0mqJOaxBp2dQ+VYxxZhkqhO2TWCyQOpI9piR3vwMYzmhGBfz
 /5VcAtf00Rub6AFn2zov3lj/OjSHosSu1TLH0FaTggA967it0slnTgyxwQOxebopPunbIaBxI
 9RkvSabpaFN3MVuiW04rk1Rv80ygHW/ak9f78uWxb9tlVe6nA03+YTLl8HmmtSZ11S0qLKYI8
 13T3EeMyVvwlqtu5hOv5TAFtNo5hM1wIEagXbWCjd6++Nz6W+R+Vy9wQiJzRVd7/Emdf9vJeG
 nwpASdQj4PB5TKuO/dpejat0XIXlvuO6T6JgCBRl2lS6WlQtqQKuY6pOcgN32ox1tfBwP4/X1
 FsWUcBaof5ebe3t+RFIYx8scEl61AFlg6U1maud9/U4LFjca1G3LhQ/lmlK2chrgPt0twSIeu
 dIgIx+J9+IHwfBW5uFB8jVmA3zk3WZuSd/Dx97miGAp2c+a7goVQYi3XQi721FHj5z2gxHAse
 YOUFiK8lq+f8Ej/8Ro1gkXp9IjZ3hfJz8+8JCMStlO5mjVY0IIfHsnPjSzzl+ryQTXPZYcdFy
 CKbIYBGgcO/av1Z5eFW24YjuEED521FWX4j7TjEIWnGgT7xsDCYnr7dle1hyJroQ9oioJOHft
 /ppn0ESRKeRupYo5EAlTTuhRCHiQ7HGkU9U0PVTWZ1A8ibjtBvsy9NZsaOylViKNyEOlpVeZO
 7eT0PFheq7LMevgk5IkP8WWnmZtC4Mx4/5qhGyzOdX2dHnSOfN1TI8aleUiub3yU3nRRFENrw
 IIRuMUt4XSpg114OOG+UG4G5qjUNO+tv7bdcOGCaolhtFeBfS3SjyxtED5Bgd51AQE1nMgjo0
 1AmtlU2uRvTHhtPpXKWGEKGABfEHgcm3O9JLgShIe8e/LCK0vUEmsI0Klb6I=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 27 Nov 2019 21:41:16 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 27 Nov 2019 21:41:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [Cocci] [PATCH 1/2] engine: remove circular references in
 MINUS/NOREPLACEMENT case
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

Thanks for your patch.


> The cocci info tag can sometimes have circular references in the
> MINUS/NOREPLACEMENT case in the transformation.

Can it make sense to clarify this software situation a bit more?


> Pass the binding info through clean_env to remove circular references.

Can such an additional function call be eventually avoided?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
