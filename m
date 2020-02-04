Return-Path: <SRS0=4B11=3Y=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10438C3524A
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 08:12:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5C32087E
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 08:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jtR2it9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5C32087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0148CMY9012663;
	Tue, 4 Feb 2020 09:12:22 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 380A977EC;
	Tue,  4 Feb 2020 09:12:22 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D280577E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Feb 2020 09:12:19 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0148CJHS003969
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 4 Feb 2020 09:12:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580803900;
 bh=0OSQhWFO/Ro6lt8YbFbgIaVtTdkSX++LRHowC9oeU2I=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=jtR2it9x080zDX1sHvdnYvuTotBeTd3owwT4EsKrWaPUlcna/gIQn6WTnT5lakZtj
 i4TRm5GHgQljc93iCHc9DRxwIfxu/NK1O0l4z/b45DuuWk7PRCyV0YQ31Hv3cm+FxT
 rS/xSBQ6HkvUgYdAn5xuI7hQbN1ZGmRTSy9mvJYM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.133.16]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtFAh-1jf8op0qjr-012s8E; Tue, 04
 Feb 2020 09:11:40 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
 <alpine.DEB.2.21.2002032151520.3356@hadrien>
 <b318a372-2f31-f57f-4684-62ac2b82bff3@web.de>
 <alpine.DEB.2.21.2002032226260.3356@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f0ccaf84-1b37-4936-3a7a-d5c11e3ef1c3@web.de>
Date: Tue, 4 Feb 2020 09:11:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002032226260.3356@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:fqBnKVHSpu8H5PHlIoHgL4upo/Tcsr0SxWW7nQPhQtOh/pfbANm
 s/0GXiiEWPMAtgemVGMa31/Agk/dwBE0aFdaF/6t1YruESWAM7nt4Kd4WEfoceTO3iPUXMS
 ZeJsEC3yPAC37Y/AeTI9lYG1CBZTcXV/hc8v8Q4As+3F1iaQ/boCo+ZBmeQYbgllc+dJwfK
 CM4LRs0VX5Vv+NuyKWOGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iJEXTzYa8xs=:Q3QNYCiLAWNeeLJRuGOXJ8
 48TsCF+Pd7fO9TEmkZN3leb1MvwGLjNOeAk/Fkz65M2769Qk4bLQPXgVCbkPAfV1AE4EohgMM
 nb3c5CCHmC/3bb2wvbhzBjSOveIS5AZOX4Bhlx6wGIEtnmCK1RiAAKkfdqUwmAjZGuL7PmVt1
 5IFp9ShHF+ABBqCuf16+WGDvh9T8KjSY9mD7SlvNmqnMexswAe2Hf+H+R2NENhYuKSo1nEs9/
 ODI2yLSw26npoqxgnfp/d3YvPHgPsOlcvbRUsn+yQY++AbvG1w2kcj5WYy42U8gh0Jx3qbFvC
 OeRvq7TUeWwulpR0PbAeW/Naaa4jl2Ex1hafbR4ZCmeaBZfnjlZdfFq2R8gyW8rVJ8UPCyPm6
 2ouvyb1xWg4Bs9MCz8TfF+6jP2rCMMuLQzY224rhoQ6Hn3h8xxNhgBHkoxCxnNdbYmk7UAlPV
 qmwkygShWgVfXpRAAB+6jg4jUqhBkRPD75vekvAFrfcUmfrgl/o5z/OE4Hf5sgRAsEJjyFMME
 csdTiFjKDTK2X+Ei6At+cNf724zZauELLyauDduoj8wDXECRdI1cy9UztKtE1xLp2SpvJxuFR
 rjM9mE0QUMiRVgCyYkFiB9pGktlwpDNNO8usI5shqPLn4pTNwe/U/5AU/6FqRcgdzFwYbjMXi
 Ows7GNKiHgtkObdp7JuBBd2a++gXoN+wC+iQWY8ab3MeLt6hyfZSIEztUySexk7n5rJsYWtO0
 FPOhxYFHpFU/B1d240Dwg+KioSOXL4EajYzPT4KYFGKb+yKoxrXF2OAx5Ik8IjfL8Ru+8iv8k
 MAVVP3EE4GxT/bMOL45oI4+f8obeeAfnXsN3+0j/5/Jt2Y+ZTgtOa99rkwtTgYY10/7sJlSpe
 UFoM9nxLAG7vdhXkAEB8anFLhO4POIN3QUYT/8zGPyjcRWe0hOH5y9Zvjbr+QvYTsbFBDKdoK
 LBcLCXv5qDqdzD+X7jZbFq6qSGvIH+Tgtrt1ALYalYkM9c4xQurtW4TQf5g30zhQVvSy3io45
 Ix2IWaNCI9zHDHEoaChuUS928OJYAQ27dsGWcDj8xqc2XhgWBK4oTWmRDrjUTHXIsZQ8GlCc7
 bs9TbqbyF6EjGsQDr7htOS9z/98gwNOd8QH4/Z+mzZMEBXo1q2X75/gfqCvW/DJCxtJ85JcN1
 zo8zN4MGCzYABZH8m7Tt8YstZbu1jWqFCQCRgJ86hawWEMNMbqQIPNCidxgqGQSvUV4kRjBgX
 RLBmK27As+h7vP1c2
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 09:12:22 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 09:12:19 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wellington Wallace <wellingtonwallace@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a std::string check by strcmp() with SmPL
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

Pj4gRG8geW91IGRpc3Rpbmd1aXNoIGJldHdlZW4gdGhlIHN0b3JhZ2UgY2xhc3Mgc3BlY2lmaWVy
Cj4+IGFuZCBvdGhlciB1c2VzIG9mIHN1Y2ggYSBrZXkgd29yZD8KPj4gaHR0cHM6Ly9lbi5jcHBy
ZWZlcmVuY2UuY29tL3cvY3BwL2xhbmd1YWdlL2F1dG8KPgo+IFNvcnJ5LiAgSSBrbm93IG5vdGhp
bmcgYWJvdXQgQysrLgoKSSBndWVzcyB0aGF0IHlvdSBrbm93IHNvbWV0aGluZyBhbHNvIGZvciB0
aGlzIHByb2dyYW1taW5nIGxhbmd1YWdlCmFjY29yZGluZyB0byB0aGUgcHJvZ3JhbSBvcHRpb24g
4oCcLS1jKyvigJ0uCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxv
Yi8wY2VjZTM2MzkwNDhkYzdlODFjNGIyY2M4ZjJhNmY3YTU3ZmQ1NDZiL2RvY3Mvc3BhdGNoLjEu
aW4jTDQzNApodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2lzc3Vlcy8x
CgoKPiBBdXRvIHNlZW1zIHRvIGJlIHN1cHBvcnRlZAoKSSBhbSBsb29raW5nIGZvciBmdXJ0aGVy
IGV2b2x1dGlvbiBhcm91bmQgdGhpcyBzb2Z0d2FyZSBhcmVhLgoKCj4gLSBJIHNlZSBpdCBpbiBi
b3RoIHRoZSBDIHBhcnNlciBhbmQgdGhlIFNtUEwgcGFyc2VyLgoKSG93IHdvdWxkIHdlIGxpa2Ug
dG8gaGFuZGxlIGNvcnJlc3BvbmRpbmcgZGV2ZWxvcG1lbnQgY2hhbGxlbmdlcz8KCkBkaXNwbGF5
QApleHByZXNzaW9uIFg7CmlkZW50aWZpZXIgSTsKQEAKKmF1dG8gSSA9IFgoLi4uKTsKCgplbGZy
aW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2luZWxsZS9Qcm9iZT4gc3BhdGNoIC0tcGFyc2UtY29j
Y2kgc2hvd192YXJpYWJsZV9kZWZpbml0aW9uX3dpdGhfYXV0bzEuY29jY2kKaW5pdF9kZWZzX2J1
aWx0aW5zOiAvdXNyL2xvY2FsL2Jpbi8uLi9saWIvY29jY2luZWxsZS9zdGFuZGFyZC5oCm1pbnVz
OiBwYXJzZSBlcnJvcjoKICBGaWxlICJzaG93X3ZhcmlhYmxlX2RlZmluaXRpb25fd2l0aF9hdXRv
MS5jb2NjaSIsIGxpbmUgNSwgY29sdW1uIDYsIGNoYXJwb3MgPSA0NwogIGFyb3VuZCA9ICdJJywK
ICB3aG9sZSBjb250ZW50ID0gKmF1dG8gSSA9IFgoLi4uKTsKCgpDYW4gc3VjaCBhIHNvdXJjZSBj
b2RlIHNlYXJjaCBhcHByb2FjaCBtYWtlIHNlbnNlIGFsc28gYWNjb3JkaW5nIHRvCnRoZSBydWxl
cyBvZiB0aGUgQyBwcm9ncmFtbWluZyBsYW5ndWFnZT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
