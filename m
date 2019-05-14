Return-Path: <SRS0=Nzf/=TO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823D4C04AB4
	for <cocci@archiver.kernel.org>; Tue, 14 May 2019 10:16:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD01A2085A
	for <cocci@archiver.kernel.org>; Tue, 14 May 2019 10:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="L50xGgO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD01A2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4EAGLAo015649
          ; Tue, 14 May 2019 12:16:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E9936775B;
	Tue, 14 May 2019 12:16:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BA0CA7754
 for <cocci@systeme.lip6.fr>; Tue, 14 May 2019 12:16:19 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4EAAOac019099
 ; Tue, 14 May 2019 12:10:42 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1557828614;
 bh=kNnqKhSpD6Lsqqcqj4wkmJSOsBQ6LHHYgZPY+xZL8gw=;
 h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
 b=L50xGgO/e19G7ffIJ/Sn5X30dKz4xFa1G7zD+uYx1GpBcKLQM4cUg5srihIlZ1TU/
 D4j4eWpSSJ1jwVhGuNMV7ITJxJoPGGMPxcNad+LYk7Tou6ylZIIkQwA7yKcXwuO8qY
 FlYV2Xp1MrPRetedZxz2ow/f7BdSID2y/Xtrts5g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.122.180]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0yiR-1gYEBj2HEt-00vAoY; Tue, 14
 May 2019 11:51:44 +0200
References: <201905141718583344787@zte.com.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Wen Yang <wen.yang99@zte.com.cn>
Message-ID: <00dcf0be-78e2-b547-4858-c86eec576607@web.de>
Date: Tue, 14 May 2019 11:51:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905141718583344787@zte.com.cn>
Content-Language: en-US
X-Provags-ID: V03:K1:hnuT8/eaYA1y/q3UjqQXWAN+xBCCGwYZRgexsRsrPneIh0jFWhi
 vAFlWOxoSJrDnQjHfVHuAyls0Y3dQoMe5sQeP7NBx+7kWdov65vpllw0IoaxnKMJq6MSNxB
 mrplf2s/eOBdPKSlpNN+YfGO6lQDED+PBA8uRuKYPNnXzCKvIfZLZSlBsce8Cle25KXvhVx
 1/VE5QqdKhiDFFATs8zwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0pZW1K2Xpts=:GgQF55ydJbM5piYdVNsPFV
 uIN7ICsIaGhHi3//Qsco2VmGB0XuJBB7f/mgZ3ZxqMJt46rDJUflNYka1JtoD+aSTdBaSvwh2
 IsoZxjbuUCFtWMB54RM8UrgdwO+IRwS4MJDtNhdgzMbOOyXYcKKn+jWbmIKKzyUhhQb7nk5NO
 QW+v6GZiQMnPWoyQSs49+/6uP0Ned0uQFR5gVyKgUssK9yN/hc0QfweN66XZVYw5R9rQs+h3h
 FD123oe0Jr0iYsg4ulDza/DfXA5a/0Mccw08F69oq0x2Gv3Y2+lQvbgG8CS7r9WILB1EXlr1K
 HhM2cVR3xImswYK1O5MFOQnrzu3lEahguEri9Y5+V+/UzPqJfp3ssSA/7WG9FkcdloBNfDQws
 6Rbpc/SapmwW5TfiSRkg6KVbjy/S/kOoWyvVAEWLInZ8TwEVcBKOdRR/5jay0hLotZwjqQLTo
 ZjHrd3PoLISFA4sa4PGpBvGCFlkO2Xk8l1kYJofaXMqGCOM6hqrU+fEFKryXMUFAmYsjcht0Z
 THXt/4O+MHTizY4zGfmqYfuZA+sRTV5XTcIqvfQ/GY3ipvG4G/yyt3M0+WTA1IzaKORaHQxQ7
 LBWXF3dZ6GaP+wBqGRuV9a1GCAnIo6gJjKkJjBgEfUb9iF21LZAV+FE2ZV2kpACxlIU50DBFA
 GZGBdrRO1xitI8PEBVuiVAqU87Ekys08EIpeLRPt1Fb5iA7GAztSVWYLr3SsUzJGB2r/vq0TK
 K7rftj0XUgKQ+zRWg9M13q9AD/jpt/NOUmEziZlv1RtgnZFwJdP8oDZHUC88OGDyG+jTbVeOA
 dRGVqBLmIQR4RccXdTzxaR/nXpyxWqHleteSs7n+eNNPBCN5+pxgj+Rnmt6kl84r28o9X3scZ
 fMDPNGz0O+BXjaGM50NUAYgSay8vMfUgROxnGmEuVf6Pn4WdmRHctfOk4TqK4tBJ6J+udrXLy
 +iTk/+K/T/kKHejUKq1tO13zTCV++SO8i3e0f+EanQvuLDrMGr1kYCFcJNLEz/CFH3vDEui8f
 SIx8zRWdPs4otFeyigazBAfjsmNVQPqtv7B6JNoRFQh1E0cn3lv+K/fvEiC/hHPsC0qyqRDZt
 Y/uIacwe5+jbvhktqu5+59HxFnMaTXb6CKhI1mvW5MyTuYMK3YvLSIRoA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 14 May 2019 12:16:25 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 14 May 2019 12:10:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [4/5] Coccinelle: put_device: Extend when constraints
 for twoSmPL ellipses
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

> I did another experiment at that time and found that this modification will
> reduce the false positive rate,

Thanks for such feedback.

Will my update suggestion influence the current (or future) software situation?


> but it may also reduce the recall rate.

Would you like to explain this information a bit more?


> Could we use it to find out as many bugs as possible in the current kernel
> and then modify it?

I hope so.

* Will the false positive rate influence change acceptance considerably?

* Would you like to work with source code analysis approaches based on
  adjusted confidence settings?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
