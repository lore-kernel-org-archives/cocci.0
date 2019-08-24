Return-Path: <SRS0=z30s=WU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079D3C3A59E
	for <cocci@archiver.kernel.org>; Sat, 24 Aug 2019 17:34:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05AC220870
	for <cocci@archiver.kernel.org>; Sat, 24 Aug 2019 17:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="BPYeQiiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AC220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7OHXl1L016667;
	Sat, 24 Aug 2019 19:33:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E4A17778E;
	Sat, 24 Aug 2019 19:33:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 567D7778B
 for <cocci@systeme.lip6.fr>; Sat, 24 Aug 2019 19:33:45 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7OHXfFp009967
 for <cocci@systeme.lip6.fr>; Sat, 24 Aug 2019 19:33:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1566668017;
 bh=LHaEA+/8I17eYbx7il3tELpe4k0WwJz7AKLmXQ3AtEs=;
 h=X-UI-Sender-Class:From:Subject:To:Date;
 b=BPYeQiiC335OGVvNLytDrs5QKJUsnhNn9HDn4WaD9MrtpsMPoJRN3pQmwUhyAr0Ly
 V/MeD9bniXfaxlaQ/oMaljyU+pVikLyloDYZuOhH5y9emjPcm4MGILboQT/9iE3rfi
 icuniB0htFp/oS+MUlDXn4ILd39g8oiYU18JBheQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.189.49]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mck7d-1hjdWi34Hh-00Huxi for
 <cocci@systeme.lip6.fr>; Sat, 24 Aug 2019 19:33:37 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Coccinelle <cocci@systeme.lip6.fr>
Message-ID: <a7f12c28-0f96-d388-f1f4-57db4d3d880d@web.de>
Date: Sat, 24 Aug 2019 19:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:Oa/Z11r7Pbq2ZSrYewVaZoJ/kzi8V9SLbbLkKxxHw7NYHgc5ISC
 bLmXCZETozDzj9w+O5aE5qm5yllkS9xiyMC7YKnZcv30K8D3ajPXXZOEiI5UDQZc+qrruZT
 +rozfLbYDVpD7i09kJrIZ4mvXX+qqXAFGOdWnpLpd3j7+yc+R6/MSz0SaKhJgDcvLgL1E8K
 4o6G3qfwBc912NY9ERMSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BJGfFrk8wU8=:h685QZLSO6ZVYfO3rwMERY
 AwzoODfTxFcewlkFRCakLIDJnyUE4GAzpB88N3B0TqauWkbupkYWOX3l8LQctiXjJ2z9lvL4h
 qzJ17C3isWs1vVjElqIgndz30c2VNHsImRR8iXIl3DLG+4F7gizxpdvaLqgo3HErbS8haa8/O
 fc4lBi2fEtHEe6PfGeslmiN5mU9redl7iIM71dYgHyf5wh2xhGBvD0wxo5SIu2R/6pRvg8kM/
 2TqKKblNc1JoOhfgdiH2zmSU0VgKABPDyuMmdmnR55fnMFK5crIoXAr67p7eh4UD7RVVQGbG1
 Q/mXVRXy9k1xyRzRKSgYyL2hvtax2Jay+ZmbCtOuR7jHdo4OcAo75M6/SGYB0ugCQzwfh91cG
 Vtkp2JerraNd4zqlDi7aUVkrr/0DHkTlGqac0mgToSCbbP4KV702xibhKR4FEn+KGtLd38Vw/
 9UKGiI+TlJU7dHKa5/aLhiEZofrpPT1m9QNSbED69uYWbkg2AYzwpvMSMcj5R7hCJol1KaISN
 OChYVibjV2vDltAo9rvLd2D0NQjTHcYlvKPY7E9CJTNppfhqf5Cx3ONuFNzGklOg3yyORfXrZ
 cp5EVf5GsXDYeuUOCzrLyQ4isXXoc2q6NwUtCDPEs1FruJ2aJSpkkXqSACRLYiotnggJ69Kf2
 y3cD6WJ++r+BxMqchb+Ogr4OAvpQrJIGdCgHjlL2RYSKMfgdSns0D1zD6SMLw7Z66VmHJfUPx
 PoW3o4uTar0YyhRBIfk08YVZtmqIXaQ8V8rgjHobMn7oMwfAULNn5uUtIZOmz5fHdt2ABI7hp
 LyOg7uBmUjd1WgMvaJdnu635zgqPs/cPi4qzYMA/avMSQpFIUHfWLZBokzKDtHYenLPXynXY7
 elNnobqJTpzzvS9X44OLlYDugcplwSxB1tudu01+3aKjSyv8+WbgDbDSFGTBArZPkIZ+Wut7q
 t7nDy2rcX9jDh1/9an6MFqhcdb5TrxRF1RCGb7UL6i2xDWYf5IYfudgv1UB6hJPos5dDDMnny
 2bmozRE/KTV8e/xAssCXnnLr1a++hAX+PW5NYbAOLO+i0WCbzFwJuSIqo7+uJvRu0PMQdvZMU
 zrarUzE5J/eIMKKSswCi7FAt2ayKvFCAqxldWzXO1YlV2okw6GiwNl+cHw27QDreiarajct52
 J8BPA=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 24 Aug 2019 19:33:48 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 24 Aug 2019 19:33:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Challenges around asterisk usage in SmPL code
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

SGVsbG8sCgpUaGUgcHJvZ3JhbW1pbmcgbGFuZ3VhZ2VzIOKAnEPigJ0gYW5kIOKAnEMrK+KAnSBz
dXBwb3J0IGZ1bmN0aW9uYWxpdHkgd2hlcmUgY2hhcmFjdGVycwpjYW4gYmUgYW1iaWd1b3VzOgpU
aGUgYXN0ZXJpc2sgY2FuIGJlIHVzZWQgZm9yIHRoZSBzcGVjaWZpY2F0aW9uIG9mIG11bHRpcGxp
Y2F0aW9ucwpvciBwb2ludGVyIGRlcmVmZXJlbmNlcyAoZm9yIGV4YW1wbGUpLgpodHRwczovL3Nv
ZnR3YXJlZW5naW5lZXJpbmcuc3RhY2tleGNoYW5nZS5jb20vcXVlc3Rpb25zLzEyNDU3MC93aHkt
cG9pbnRlci1zeW1ib2wtYW5kLW11bHRpcGxpY2F0aW9uLXNpZ24tYXJlLXNhbWUtaW4tYy1jCgpO
b3cgSSB3b3VsZCBsaWtlIHRvIHNwZWNpZnkgYSBzb3VyY2UgY29kZSBzZWFyY2ggZm9yIHRoZSBj
YXNlIHRoYXQKdW5hcnkgb3BlcmF0aW9ucyB3b3VsZCBiZSB1c2VkIHdpdGhpbiBjb21wdXRhdGlv
bnMuClRoZSBDb2NjaW5lbGxlIHNvZnR3YXJlIGFjY2VwdHMgdGhlIGZvbGxvd2luZyBhcHByb2Fj
aC4KCkBhc3NpZ25tZW50QApleHByZXNzaW9uIHgsIHk7CkBACiogeSA9IC4uLiAqKHgpIC4uLjsK
CgpJIGJlY2FtZSBjdXJpb3VzIGlmIGFub3RoZXIgc21hbGwgc2NyaXB0IGZvciB0aGUgc2VtYW50
aWMgcGF0Y2ggbGFuZ3VhZ2VzCnNob3VsZCBhbHNvIHdvcmsgdGhlbi4KCkBjaGVja0AKZXhwcmVz
c2lvbiB4LCB5OwpzdGF0ZW1lbnQgZXM7CkBACippZiAoIFwoICEoeCkgXHwgeCA9PSBOVUxMIFwp
ICkKKiAgIHkgPSAuLi4gKih4KSAuLi47CiBlbHNlCiAgICBlcwoKCkJ1dCBhIHBhcnNlIGVycm9y
IGlzIHJlcG9ydGVkIHNvIGZhciBmb3IgdGhpcyBjb2RlIHZhcmlhbnQuCkhvdyB3aWxsIHRoZSBz
b2Z0d2FyZSBzaXR1YXRpb24gZXZvbHZlIGZ1cnRoZXIgYXJvdW5kIHN1Y2ggY2hhbGxlbmdlcz8K
ClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8v
c3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
