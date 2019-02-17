Return-Path: <SRS0=/UbJ=QY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F73C43381
	for <cocci@archiver.kernel.org>; Sun, 17 Feb 2019 13:15:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1084F2192C
	for <cocci@archiver.kernel.org>; Sun, 17 Feb 2019 13:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YcBvFqVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1084F2192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1HDF0dL024270
          ; Sun, 17 Feb 2019 14:15:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 79B8F76F4;
	Sun, 17 Feb 2019 14:15:00 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9F24376E1
 for <cocci@systeme.lip6.fr>; Sun, 17 Feb 2019 14:14:58 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1HDEuBb021015
 ; Sun, 17 Feb 2019 14:14:56 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1550409280;
 bh=gIrvYy3qX5P42PmaNL0dx/MTF7EVgQsDF6prqv1CgeA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=YcBvFqVCgIX3E0Si9QH2s/n6j+Qo0hSveD5V4miunK0tF49Fw91+sHD+iU4uCIoyH
 nYNd/pbh4aQTdphO2UC9h2XDRK4Rq4oULaQvq2MYG7qLhYSRIzerLs9CphggpauawM
 S6zymcv94rvngqh1JWXEC+bcJUsdoE/2FotjKGic=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.167.97]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lcxfc-1hLvfc2pG4-00i8P6; Sun, 17
 Feb 2019 14:14:40 +0100
To: Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <yellowriver2010@hotmail.com>
References: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com>
 <8e7ba7c0-b7fe-a1f0-d28b-0c716ecbcfdb@web.de>
 <alpine.DEB.2.21.1902171235570.2444@hadrien>
 <1c152067-0135-79d7-1285-4bb9925054c8@web.de>
 <alpine.DEB.2.21.1902171246560.2444@hadrien>
 <782fd1c3-80ff-a296-b3a2-351257bb13b3@web.de>
 <alpine.DEB.2.21.1902171304520.2444@hadrien>
 <10836645-5b19-a748-56d7-c0572a76ab4d@web.de>
 <alpine.DEB.2.21.1902171350500.2444@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <52c07e7c-eec7-792b-0b03-b5cb46ddeab3@web.de>
Date: Sun, 17 Feb 2019 14:14:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902171350500.2444@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:mcW/alvgV2U2JkeM76bMIURS9xZXu7gfN8WPtB165B/WxlpuNAS
 URC6c9PzBDgcV1KRgwYTCihcUBduaN2PhrbyJQmlVvs8dMaM+wNn5bpeceCz+2Sx3HEt9/f
 FZKdqSA8Lc7/6zQ2meoTRASVEmAdd+O30BAQ07XFleRRJkgjaewRsyL9oxrf1UV1ECS+Q03
 F3wr7QCBkEQDIJoFJV7tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FV32otE0dCM=:/wKbpDwVSz3N8VKGtXyc09
 2OEB/OER9qAIhIzwkdwl4XTWDLKe+rhV7c/yVvCVLp2cMHmIht+nx9h4hpau5mY9SiaHkx6QX
 9hfrjo+VOH6BCQWAT92yyPkKwZgwmAqy9x4AstufHyPOnHLdHHXWVRQGNyWJgjGzsT1uphWYk
 td3tp+hgXBrYhB8DSkrYVBPfDUPPukPmQ4Y+YJ3ySRrdQHCQcfa97T65usna6b89j979NJIFC
 WPE3HA068cBs9zYa9l+Kr8cw+KBBL6COKBIT6ZptluyOcEEokGBULuqTwLXyeETUkST20421i
 AotI65cDYu1zmsOTuHKi1UtpzpaFulLJbdbnGMvkmD1+C1lnnG5E0ELEjtFZ0nR6mT8OHp93Z
 90nl7pZgmWR3yVPI1WbG9palVF1NzWU+uBudoYfavxpIawl1zFd+LW2T3rM0Euk5WqPNsDYzP
 RUjeRO5iPighZUcuoaC4voGKDPkwmQK2QSj8MziKDLcU9l9qxVKk08wdOILr8ICMinQe86psT
 MtoDk+I2zli1zJEtnUaN9TOq8M1AZAb++SqoGTkbK4cQ9p9bQqn0gcwDSfBk4dAEbr/SoaIeV
 e7dRkhs54OuBYT6JU/Mq/KhEm3nqU8K9WnVG06Z5qIPRi3H+KrcYqzWfrNlBRmntnyoThOp4W
 +J0fdf7NkxT9RRGOoIZoNlO3IGJ/Uq7PdIhPPzWkpF2cwgvwATW6T3wZj0cBhrGk9hoeFHNhf
 GjvEfq+DkNYpuZQM1psOzKj8E+uPVR5b6s3Rdr1OhXAP80L/taP+zsFeELLu//uTX+KDlQglm
 Uaq19iU9zk6IFNCAM2hVAyLLP/BWJWmcKdKRX9+aVoA9GRduBsPo9gL83ZZw9LgLQSHYQb2oK
 X6u2Iy9baEYunuG3ehe5DSOjyqe68TkVMKIrkLfIgLBR5g/AvkPTGRns9UsNfqUeRLqJquPzh
 OpI+mjEczxg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 17 Feb 2019 14:15:02 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 17 Feb 2019 14:14:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [Cocci] [v6] coccinelle: semantic code search for missing
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Pj4g4oCmCj4+ICtAc2VhcmNoIGV4aXN0c0AKPj4gK2xvY2FsIGlkZXhwcmVzc2lvbiBpZDsKPj4g
K2V4cHJlc3Npb24geCxlLGUxOwo+PiArcG9zaXRpb24gcDEscDI7Cj4+IOKApgo+PiArQEAKPj4g
Kwo+PiAraWQgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlQHAxKHgpCj4+ICsuLi4gd2hlbiAhPSBl
ID0gaWQKPj4g4oCmCj4+Cj4+IE9yOgo+Pgo+PiDigKYKPj4gKyAuLi4gd2hlbiAhPSBpZCA9IGUK
Pj4g4oCmCj4+Cj4+Cj4+IFdoaWNoIFNtUEwgc3BlY2lmaWNhdGlvbiB3aWxsIGFjaGlldmUgdGhl
IGRlc2lyZWQgc29mdHdhcmUgYmVoYXZpb3VyPwo+Cj4gVGhlIGRlc2lyZWQgYmVoYXZpb3IgaXMg
dG8gY2hlY2sgd2hldGhlciB0aGUgYWxsb2NhdGVkIHZhbHVlIGlzIHNhdmVkIGluCj4gc29tZSBv
dGhlciB2YXJpYWJsZSAodHlwaWNhbGx5IGEgc3RydWN0dXJlIGZpZWxkKSBhbmQgdGh1cyBpdCBk
b2Vzbid0IG5lZWQKPiB0byBiZSBmcmVlZCBqdXN0IGJlY2F1c2UgdGhlIG9yaWdpbmFsIGxvY2Fs
IHZhcmlhYmxlIGdvZXMgb3V0IG9mIHNjb3BlIGF0Cj4gdGhlIGVuZCBvZiB0aGUgZnVuY3Rpb24u
CgpJIGZpbmQgdGhpcyBkZXNjcmlwdGlvbiByZWFzb25hYmxlIHRvIHNvbWUgZGVncmVlLgoKKEkg
YW0gdW5zdXJlIGlmIGEgcHJvZ3JhbW1lciB3b3VsZCBsaWtlIHRvIGZpZGRsZSB3aXRoIHJldHVy
biB2YWx1ZSBzdG9yYWdlCmluIGEgZGF0YSBzdHJ1Y3R1cmUgbWVtYmVyIGZyb20gYSBsb2NhbCB2
YXJpYWJsZS4pCgoKPiB3aGVuICE9IGUgPSBpZCBhY2hpZXZlcyB0aGlzIGJlaGF2aW9yLgoKSSBj
YW4gbm90IGFncmVlIHRvIHRoaXMgdmlldyBjb21wbGV0ZWx5IGJlY2F1c2Ugb2YgdGhlIG1lYW5p
bmcgdGhhdCBpcyBjb25uZWN0ZWQKd2l0aCB0aGVzZSB2YXJpYWJsZSBpZGVudGlmaWVycy4KCkJv
dGggbWV0YXZhcmlhYmxlcyBzaGFyZSB0aGUga2luZCDigJxleHByZXNzaW9u4oCdLiBTbyBJIGNh
biBpbWFnaW5lCnRoYXQgdGhlcmUgaXMgYW4gaW50ZXJzZWN0aW9uIGZvciB0aGUgc291cmNlIGNv
ZGUgbWF0Y2ggcG9zc2liaWxpdHkuCkJ1dCBvbmUgd2FzIGludGVudGlvbmFsbHkgcmVzdHJpY3Rl
ZCB0byB0aGUga2luZCDigJxsb2NhbCBpZGV4cHJlc3Npb27igJ0gc28gZmFyLgoKV2hpY2ggZGF0
YSBlbGVtZW50IHNob3VsZCBub3QgZ2V0IHJlYXNzaWduZWQgaGVyZSAoYmVmb3JlIGEgY29ycmVz
cG9uZGluZwpudWxsIHBvaW50ZXIgY2hlY2spPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApD
b2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0
aW5mby9jb2NjaQo=
