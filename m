Return-Path: <SRS0=C3HA=OK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FB0C04EB9
	for <cocci@archiver.kernel.org>; Sat,  1 Dec 2018 15:41:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B698C20673
	for <cocci@archiver.kernel.org>; Sat,  1 Dec 2018 15:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B698C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB1Felxw017373
          ; Sat, 1 Dec 2018 16:40:47 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 03A9776CE;
	Sat,  1 Dec 2018 16:40:47 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E869D60D7
 for <cocci@systeme.lip6.fr>; Sat,  1 Dec 2018 16:16:33 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB1FGXSc015842
 for <cocci@systeme.lip6.fr>; Sat, 1 Dec 2018 16:16:33 +0100 (CET)
X-pt: isis.lip6.fr
Received: from [192.168.1.3] ([93.131.34.83]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQ6LH-1gXFrv3zc3-005HEW for
 <cocci@systeme.lip6.fr>; Sat, 01 Dec 2018 16:16:33 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <8e3bad4a-61bf-c808-7ac5-feda64dfd44d@users.sourceforge.net>
Date: Sat, 1 Dec 2018 16:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:Kv18kgXrCLY6GJsErEd/AM1AGiSzVNXbGwYBH6rJAFV2dbbcSKf
 KUnUFCOmAV+N6+MfHQ2Ajh3D5fib66RnwcC1VtdgR9IeyiVxdQsp7Re6nieBfmWsCkatN7e
 BI2G+yaq1/0CcOIEw2LNAnFXxivyuJfQvad+e0z0qDOuMjmOEfm6tqbUqh5C24sJAEqj+9h
 hrxw9HJNkn2AImHjJAo8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1oInijFosRQ=:2RJ33KofxmH9x1+fbdivPA
 wDHnxlLkYJXtVvdArVmRgMnfkLoX/0HQdeAvtI4Om7hCHn54rpK9erG6NZ+PCDcYkQUJ3hIII
 VLULZ3pQcAKLehMCS3NC7Ca2XX8667lQE5MjWegqOVg5ePQNI/jBewdM6onbYy6x50VGHyQX7
 g8Df3t5v80g28xHXVT8w1cPHw+qYiK+uKB64qdO+ZU+R/LPPiLs9nhvySkBrefSv26n9XEdzZ
 acqSKw3ORAnZ13ABnvXBRw2uW8R7XsxehBR0tvPktxYjy23A9IjmMEsBRgycYEBtnaZdqccbx
 cEroixGTndtsTxhNMZle5aDmq/v6v07GwS3RkD7NZNG8ekoCBnc9SJs9sd0fN6KxCAM2qPQqc
 Bzsgez/JVofn9g2eGbfOcpJzqafCHA8G2mlFXm/t91aCXjUjrnG4bEaZ8aWLPHnyr1AQlea3F
 MQmwlxH1Am6q0qjX3apcfFVEeUYf1i6W/o37gTx329EvgAEGR1tpnZIN4MSjMXLHGHeAgbIeF
 YFHxTO3mdI64VpK58aTvqyMS/RCZJ+Xc9HH/HrntyDa/Deyi7oPlzx9ce6HBmI7x4UxFXZ5Ho
 wyqmSB2OGXhITOOjBPo4DXMtA/o701lOjo2FdwP8JZ5lTa3znCclQI0ED5CqgEWaQkUl9NbZp
 jYra9JZUtoCxJhCtZtQlmJhNB5EMeuipcjb7VTFj5+vlGgLVoZMOe+yoeBy3L1nA21gjT1QGN
 pQHs3FL2oQ5GzQtr5srFpxKu7N/EzKDZGN084ufz35PO4urNMSjdMeugtB6EvFbKJcB+vWHFq
 1RgKdeInHK8//a+QlmJAzkU1dHaD5j9hW10Nvr6yo3J6dD1YkxHbr2hDn+QK+9ID38eSATckj
 K56qpBc6bbxifXYu+OWsKvzOHVpp8c3XJasQgTBFuTIZ10HOhSIQiJoWGyKY8Zq3grGW3UWRo
 7sJtbEIxW85OF/n3w5a3dzYyIvQ3dexCF+ROB70DxwdP0LegS7GmSYbn6w5b1uD9uDEgIu6hS
 O5ZWqQDJImRPiZni8Edye7CfTKqLYJUa7O06HzxB8fELcjMcbWx9tdyK2fAsFkA4JQdrtbczi
 OvDVcg4Su6QxMI=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 01 Dec 2018 16:40:47 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 01 Dec 2018 16:16:33 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 01 Dec 2018 16:40:45 +0100
Subject: [Cocci] =?utf-8?q?More_applications_for_=E2=80=9CCTL-VW=E2=80=9D?=
	=?utf-8?q?=3F?=
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

SGVsbG8sCgpTb21lIHNvZnR3YXJlIGV2b2x1dGlvbiBoYXBwZW5lZCBzaW5jZSB0aGUgdGVjaG5v
bG9neSDigJxjb21wdXRhdGlvbiB0cmVlIGxvZ2ljCndpdGggdmFyaWFibGVzIGFuZCB3aXRuZXNz
ZXPigJ0gd2FzIHB1Ymxpc2hlZCBieSB0aGUgZG9jdW1lbnQg4oCcQSBGb3VuZGF0aW9uIGZvcgpG
bG93LUJhc2VkIFByb2dyYW0gTWF0Y2hpbmcgVXNpbmcgVGVtcG9yYWwgTG9naWMgYW5kIE1vZGVs
IENoZWNraW5n4oCdLgpodHRwOi8vY29jY2luZWxsZS5saXA2LmZyL3BhcGVycy9wb3BsMDkucGRm
Cmh0dHBzOi8vZG9pLm9yZy8xMC4xMTQ1LzE0ODA4ODEuMTQ4MDg5NwoKQXJlIHlvdSBzdGlsbCBs
b29raW5nIGZvciBwb3NzaWJpbGl0aWVzIHRvIGluY3JlYXNlIGl0cyB1c2FnZSBpbiBtb3JlIGFy
ZWFzPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0
cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
