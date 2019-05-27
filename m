Return-Path: <SRS0=gsjE=T3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F102FC04AB3
	for <cocci@archiver.kernel.org>; Mon, 27 May 2019 15:00:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169562182B
	for <cocci@archiver.kernel.org>; Mon, 27 May 2019 15:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="SCsIlVdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169562182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4RF0L01019523;
	Mon, 27 May 2019 17:00:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F2C45774E;
	Mon, 27 May 2019 17:00:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0DA107747
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 17:00:20 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4RF0JHX004543
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 17:00:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558969218;
 bh=ksVNlXa9qq1rQCK0NbeiDUpKbsNFI8M+c/KUk6qOEuQ=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=SCsIlVdKLvNVEqYgynyyTKp2TE9geV+F53J5pNbP4fC5d/qiXO06eIjWVuloiIQUR
 QFSsmKAF0cjT6ccCa5a8eQbz0i/BKH5sHh1L9smnKI8SkQlzXkY8ZiF6vmvPWNeevJ
 NfLD7MtsTvk+uJDZsRv65D9lt9ZYPKP8XAK3DQGw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([2.243.140.65]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Meji8-1hFmX430A4-00OCse; Mon, 27
 May 2019 17:00:18 +0200
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <28b6ede5-cc25-c6be-8526-c291988d208a@linbit.com>
 <9393a949-d787-adfd-3dab-4edc76e92b45@web.de>
 <95a1255b-476b-e1b3-8a80-288dc9d3457f@linbit.com>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2a372261-fe35-0d56-b843-e29e53fc1338@web.de>
Date: Mon, 27 May 2019 17:00:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <95a1255b-476b-e1b3-8a80-288dc9d3457f@linbit.com>
Content-Language: en-US
X-Provags-ID: V03:K1:4aIkteacI4FW6aqAIW2GBxlz7gNRH14vXx2B+VPJP2Cb9sEBqvT
 QHBu4n/TEqeBNW6agKxl/jcc/eMygnPnqHNJGfhEVCst3w9mBLy5wAogx1wQtnnz0kNP1QS
 fzeTy75fzbbwPErOxZQV0N0Mz8/gTdAqTaItymTlq7rkj8Pi0bRrNYk0c6BXv3yA3v6GMJJ
 SOuDM++A2GUPgs4eKOd2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZWqW0Q6yXSg=:GCWQ52f0xx5w2tqBujH8Ii
 cK7f6xS0Hvq1FCJeR11tjg2H9ddmPpnqzzhtZGwQ8LuL1Ar32LBNoy//yqAfM0CEXLM9KwKR6
 7xXHy2KDjNsIBDALXpaogUdBWc1PQ2EiNaAB61yfR+S0Nwxp/jp8Kh1kRLewSY7vKQca70ZzH
 J+b66WoHXyWa44tSsflvkBeAqAlwWY/gq0IGDxdWYZOf7nnANSDMQ7US4UtKipWWEiDOyXg0j
 uE+AKJ0mRdz0DbFEATpP+J1N3H8zUkhghTTINv5S3H1Yw9Nmx7XBkvuglE66jo+gtnELT3ATH
 axkou1kT21gTikgksH7/XT//zqf8Z4o2XMqgj80Kr5ITztDzpNcuuI1Pja2OkykbEcl2sK2RS
 /AWd4tSdauqaFKBLbsm4dpXQw4GfjwXBdqBwMwwkriHbcUnBFlGR/Hb1QpprAiIE0LmopvIUB
 tTDCzpAijLorh5QjwZiURfc1FycZNRZM2YObOnf9zB3Yup7YOawS1/m7KTk5YAaMHc7akWz3V
 eYS+IURKDubt3ZcBzC3o+lxQTJ8O8oEDnnR9yYAIIGwMj6VucMoDZiQdy+99WTLptfiSqABE4
 UWlLIO7ZnXq679aiIRiJfhAkFmmDFFvYfBvrdQ5u6p2L5WDqqOrMkhgSK2/OygFMrSXjE6Mff
 KZvlUpcgLrdwlbp+ZS9vPpGie3W8ImPNgGSrtpNb9kDwnkFl/vPvbVr5Jspm8n6Kgk8JaoVO1
 IV4+fflQgCgZFmDUNCFLY95bfdvrsYdRjGT8LS0vHa1RV3cC+uzSmjvdRsgpEYoTEsEJmoF/M
 1r0PKSGaxzZRmeWJEhQffnH5UQ1g7HeLyKWol2Xd9PqSOLAmr7b7MydUGpZlsapGXO2BpuhZa
 Q2XOtCbau7pppxM/Ejw1Aj1TQjEPXpiIWRnKKRgqq44dBVHfKJJ6zky8ZzU9ZxWrIluSGzNUU
 6+7hpE0AHa1UO3hiEKykd5hENbL7BAweORabNAqtnx7v80Qqmnw5o
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 May 2019 17:00:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 27 May 2019 17:00:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Checking change scope for a data type replacement
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Pj4gQHJlcGxhY2VtZW50QAo+PiBpZGVudGlmaWVyIHg7Cj4+IEBACj4+IC1pbnQKPj4gK2ludCoK
Pj4gwqAgeDsgPgo+Pgo+PiBJbiB3aGljaCBzY29wZXMgd291bGQgeW91IGxpa2UgdG8gYWRkIHRo
ZSBhc3RlcmlzayBmb3IgdGhlIHVzYWdlIG9mIGEgcG9pbnRlcgo+PiBkYXRhIHR5cGU/CuKApgo+
IDEpICJ4IiBoYXMgYSB0eXBlIG9mICJpbnQgKiIKClRoZSBhc3RlcmlzayBhZGRpdGlvbiBzZWVt
cyB0byB3b3JrIGZvciAobG9jYWwpIHZhcmlhYmxlcy4KCgo+IDIpIHRoZSBuZXcgImludCAqeCIg
Z2V0cyBwYXNzZWQgdG8gYSBmdW5jdGlvbiAidm9pZCBnKGludCAqKSIgaW5zdGVhZC4KClRoZSBz
dWNjaW5jdCBTbVBMIGNoYW5nZSBzcGVjaWZpY2F0aW9uIGxvb2tzIGxpa2UgaXQgY291bGQgZXhw
cmVzcwpkYXRhIHR5cGUgYWRqdXN0bWVudHMgYWxzbyBhdCBvdGhlciBwbGFjZXMuCgpCdXQgYW4g
YWRkaXRpb25hbCBTbVBMIHJ1bGUgc2VlbXMgdG8gYmUgbmVlZGVkIGF0IHRoZSBtb21lbnQuCgpA
cmVwbGFjZW1lbnQyQAppZGVudGlmaWVyIGYsIHg7CnR5cGUgdDsKQEAKIHQKIGYoLi4uLAotICBp
bnQKKyAgaW50KgogICB4LCAuLi4pCiB7IC4uLiB9CgoKRG8geW91IGRpc3Rpbmd1aXNoIGFueSBy
ZWZlcmVuY2VzIHRvIGdsb2JhbCB2YXJpYWJsZXMgaGVyZT8KClJlZ2FyZHMsCk1hcmt1cwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5n
IGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxt
YW4vbGlzdGluZm8vY29jY2kK
