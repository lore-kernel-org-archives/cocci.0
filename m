Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2052C18E5B
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 17:37:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED339205ED
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 17:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kF9esAKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED339205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GHaawb025611;
	Mon, 16 Mar 2020 18:36:36 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7CAAE781A;
	Mon, 16 Mar 2020 18:36:36 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 11B787809
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 18:36:35 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GHaYwO019531
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 18:36:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1584380193;
 bh=qH/4FMpwFCgjleF0ELajl6J/LnBmEevsjxGVL4mPmo4=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=kF9esAKGBOw9x9er0xQ0CJ124tMmPooj+TQUKKz0ccPBtHgtbIZvHotPjA9s1W+RO
 oBXp7EIn5NmBTr7VgG8nnLr7YFNxPVl7M4xA4QzOMQfj3Swh6XTgTSvd4lC2HgoVss
 xuRBBE0+nwmU+F6EiMQ1jqnxT1xj6X1/XEShqjY4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.93.189]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1X0v-1jSwXo0csT-00tVfO; Mon, 16
 Mar 2020 18:36:33 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9cffdd3e-241a-200a-7eee-f5ffcd140762@web.de>
Date: Mon, 16 Mar 2020 18:36:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:cyTYm37e7trYwS7CYgLTkkWBdNOHqI9S41DOdranPHuKNH94aTS
 OcnD5nsYbMlJ4dr17fODx77ySm/C/LnZ0qOIgB5IV7v9ItwUPJpTQZPG73e1O0j/wDO104k
 47xgtzgrhjKXywFa2jf41IflCP29D+OCvCxukpjd1ZONCB7ILZmZ1OldbO6upOdD8ioK95B
 Q5FHtwtEbUibL6ix1xk7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zq54E6GUPg8=:G/FmzS845kDh6/xru3sYK0
 xiztIiLZW35cwtqUhUdH4751mClckn1G1XFwn/pNK5qa2muCwKHCkfXgIYBRMCptBF/KMhDAn
 Av0JPW8+3bFlYh8QYYtILhO2J7UYwQ/6a878as/4tya+vflbS6l9keP3AVoLaUpx8lIZcHAtK
 XUBcyNxiAyLcq88LUqaJ9zzgKsOea2McuX/lwkbKgr7pQYQlcaNk3sDQ39TWPC9a19vb3KDti
 nj4PSlNY1uUSGIrorlgc9Mjq+pm2x5iRYpb7muU/C3CW2EuSuwfbB077gfNyAqpKn0MMSn/Uq
 mDwkM+ARhjdZtet1NJ8BiLsssiC64FlT1lM9bnp/NdkijuPZm3I2qb5Dn4m670Q81rtCzXcpp
 lMafM3eY9taEUrPXYE+Ecf0fXgFvSmG92yvdbg4DZtEIYcyersocdbl3+uFekUFZRnie+au1h
 JYSwCYZZ2seH3TvmKZeFluHYRUopNFPQUVLwpTBgFCZYc0IL6+M2xbaAF9Kf6RD2UYh5FqU9x
 YwdoM9Jpz3kQem7wzkrPgkv7rEoCZOPq0qo/Vc8PCvMM0jYGJyOTX1T+7bop6byMJyWqZylqS
 UW8yj4QqSqEnq9rdUxWmK9FQhxEpIY/7ey5VJV5clKkhZSCGOip+P+KvNWdfVB8dTfSqjqUK0
 SDqPp+M1QkjvPK/99xF7TCcSuYphJvr3K0i7Lin911rJdpvAdd3vLuHdbl58oAz/emPgaIDFV
 Iqz7ShT55a3AEwl5lTjDTWNWoWQ9SIUEsUgZlujeqQl5iLvqdo3L9fu+mSGrl5MWNJ3SX4Nr1
 VZ1Vn9AlDnUbjhnsQ4SpVUQVZr3CdMzOx+rK1vLj8xw0a9G8gIZKGksYovCw2K2nbsx6fDnhK
 T/H1B3I3326h2YvSLSI+m+UtmcB0aeHK+RQvA+ki2oMrhkFCXP2r0TYyKIkPWDKrMLS45Ypof
 4Fe8Dap/O+VKMdCDGZYmWlBKosLa/kvA7EVFGmubMozwQh3Rutd6tMr4x3jB1jGnAC2KVY9Zc
 WjQnXO601592GI+yX1+uCN0OdGrMvzxcXyAH9WDFqFm6OxNhD6UESINOLhKexVknji/d5T7qa
 t4gMQu4R6WT0yGR5mP8NAKSPCZizJT5L50gy9rQiXPcaY2DSiJbJ+U6T7Mi6oXpnl0WVi9Qth
 NyaWmLus/OXjyKM9FTw6Jcf0xQ0VMljNINAUQIFy4iZPJmpr1mRaX6EYCZe6UrJHnLFGuJG8C
 M7B5fqNynBjAjVv9Q
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 18:36:37 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 18:36:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH 00/26] cocci: Add ParenType/FunctionType to SmPL
 ASTs
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

> The aim of this patch series is to add the types ParenType

Can it be that this kind of data processing will need a bit more explanation?


> The FunctionPointer type is removed from the SmPL AST, since
> all the productions that produce FunctionPointers in the SmPL
> parser are replaced by those that produce ParenType.

I imagine that dedicated data types can occasionally be helpful.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
