Return-Path: <SRS0=ES+2=3X=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BBEC35247
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2020 20:45:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD7220721
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2020 20:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="HVZeniQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD7220721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 013KjWdl028812;
	Mon, 3 Feb 2020 21:45:32 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1E1D877E8;
	Mon,  3 Feb 2020 21:45:32 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 73B5C772B
 for <cocci@systeme.lip6.fr>; Mon,  3 Feb 2020 21:45:30 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 013KjTMx020214
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 3 Feb 2020 21:45:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580762728;
 bh=v0mrqCQeHRGpMiHLl6fOVKjp/1KhfhAjhO+LIeLTj+8=;
 h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
 b=HVZeniQMO2bL+KnROa/vttrzc5EZTD0B9R+vb29BpSW2gdKDB1IuzG+w5NJPdX2+I
 hJdtWS7bBCjOgOY00VtEJCl2cDXfmnhUW8QPZ7rFX3Ch2PiQ/5AABXjp5gO7+jawdo
 n6loMgFR2ZM5wzq6kub8oQj2HbW8uNbCr0iTaTSs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.154.151]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkPW7-1jWPaN1NgB-00cMRD; Mon, 03
 Feb 2020 21:45:28 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
Date: Mon, 3 Feb 2020 21:45:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:3WHdtFhACAty7/TBw0iDXRsILQm7iI2G9YHO17fKuL9OwzBQcp0
 EsWNM24RM8h7J/brnGm1XGvtiyO8HsplRDRQyMKP01+cVd5qZCPHSEOOc7QE6Gdl7v/beOv
 2gNjkZyvI55ZOuwHa9gPqan2Imqf+cTQX5YBi5FK9ZCjlNO0AMH9WrIO9ISvwuZiY4LaS3p
 ddxowYHUEYqb4zikdLpAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aXSjfB26YjE=:SXqjayZ2wDgz0ahN3u1NRo
 uNqE8OZlZpCuD9HspJOLp5Yd0Sij+uFP0FO1G9PIgGH5M6f4EQyXnR13XqcOwpYE/lLbAnv1Y
 xcMMwrWE1QHJ2/EzdgkOaiCCjzmyWV9q5cE8WvkbUHqj5MkcYiQKv7f3P1mMMN1ZZSd4ur54X
 siKG3wcMWlU5OV26dDldm64eNvlcEKrwpQYpB+0fYxCbXmBVDmHwJOj6nW7pXDaCZKKVru/pO
 w6gski7GnBDSqbzlco9X1/MPNK7nq5NzRt9I+Pd+4nil7M8+U85353ZiQj0Dl4MJ02NgFRM8K
 BsVEC5YwXMxb88VnVlRsNw6pHK4L7IfEi4G8bWAKqmWoHNhN06Ocxctugp7W+gfsCkhTNkcZk
 Ip/u178UJP9f0HQby0KTqSKrKnxf5cM0c6ZZgAWuBSgB5ZCNjDHMYNSNn/pPtmO+dDYeGadIB
 HiFA5jVWvLvYl4F+S8XKFLUlpOBqZ5sdOaAkF8uEJJBCz3jtg4pQrc+obrFr5DlezQHIsEr+B
 VaHP5hh7THc6u+YOzL9w1sj+V3q5PwnUOXN9ZDfo+rwm2j410oIKVrRfNAJ6NdfmsbyJQ8Nkg
 4yIku+0StcI/v8vqYI7Ew+EsDu31I6RqcmFj3QCIiswwCAhhxlGHKcxGcZbQy8Jr9jJoa90Hz
 nusmMaS7i8HyltZMuH6cxPgqIJujge7HnBNhSLb4uCkpWIUgCXvS17BS1haRa5HebPlTfx34E
 x1z4wXXDzuq/dP0saK41wYfAFpNorx7lJ0/iBEv/f5jBMYPs9one/I6IFM1WyQoIab91HyABB
 VZooIHVr89ydCc1EKK9jqHJKoobOiORzHRdiDlk8POgiPqfS8MKPo69y7X2Thp4RMltQogDoW
 UyZid+a2QtgVyMi08vi/zQ6I80H4i6yrmF9M0hJ+9fXTrKArS3wWv07I4j3tDCyJVDH4aiQlO
 FOdAiafQyJbAKv9aC+dGvBjEDBptc252igt2MmrT/XCeJM7wokriuIQlwRC8uqlY+b6TcJC/a
 vv7bSu+wa5RqOt9jcHvr7UrX6XHmfpM7iVrtTwejgm0YypeuaV4FMOMDRVgKhqyhZE1oTfdHs
 slJWHXks/RvYxc7x70NEGZxJmavs4jL0wJDlh1nUSNQfoLkMBfRpfYQWck7bbsvBYOQLe7hwI
 xiY9Dted0jxvm1WLPzHZOE7tCHWJwwRUMjUxsVYI+mzd/Z0dJ5uG2yImBcM1zv3qdRLI03yNT
 xW7tTmEVoLv/30aG3
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 03 Feb 2020 21:45:32 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 03 Feb 2020 21:45:29 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wellington Wallace <wellingtonwallace@gmail.com>
Subject: [Cocci] Replacing a std::string check by strcmp() with SmPL
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgdGhlIGZvbGxvd2luZyBzbWFsbCBzY3JpcHQgdmFyaWFudCBv
dXQgZm9yCnRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZS4KCkByZXBsYWNlbWVudEAKY29uc3Rh
bnQgYzsKaWRlbnRpZmllciB0ZXh0OwpleHByZXNzaW9uIHg7CnN0YXRlbWVudCBpcywgZXM7CkBA
CmNoYXIqIHRleHQgPSB4KC4uLik7CgppZiAoCisgICBzdHJjbXAoCiAgICB0ZXh0CisgICAsCi0g
ICA9PSBzdGQ6OnN0cmluZygKICAgIGMKICAgICkKICAgKQogICBpcwplbHNlCiAgIGVzCgoKQSBj
b3JyZXNwb25kaW5nIHRyYW5zZm9ybWF0aW9uIHJlc3VsdCBmcm9tIHRoZSBzb2Z0d2FyZQrigJxD
b2NjaW5lbGxlIDEuMC44LTAwMDI5LWdhNTQ5YjlmMOKAnSBsb29rcyBwcm9taXNpbmcgKGluIHBy
aW5jaXBsZSkuCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2luZWxsZS9Qcm9iZT4gc3Bh
dGNoIC0tYysrIHJlcGxhY2Vfc3RkX3N0cmluZ19jaGVja19ieV9zdHJjbXAyLmNvY2NpIFB1bHNl
RWZmZWN0cy1zb3VyY2Vfb3V0cHV0X2VmZmVjdHMtZXhjZXJwdDIuY3BwCuKApgpAQCAtMSw3ICsx
LDcgQEAKIHZvaWQgb25fbWVzc2FnZV9lbGVtZW50KGNvbnN0IEdzdEJ1cyogZ3N0X2J1cywgR3N0
TWVzc2FnZSogbWVzc2FnZSwgU291cmNlT3V0cHV0RWZmZWN0cyogc29lKSB7CiAgIGNoYXIqIHNy
Y19uYW1lID0gR1NUX09CSkVDVF9OQU1FKG1lc3NhZ2UtPnNyYyk7CgotICBpZiAoc3JjX25hbWUg
PT0gc3RkOjpzdHJpbmcoImVxdWFsaXplcl9pbnB1dF9sZXZlbCIpKSB7CisgIGlmIChzdHJjbXAo
c3JjX25hbWUsICJlcXVhbGl6ZXJfaW5wdXRfbGV2ZWwiKSkgewogICAgIHNvZS0+ZXF1YWxpemVy
X2lucHV0X2xldmVsLmVtaXQoc29lLT5nZXRfcGVhayhtZXNzYWdlKSk7CiAvLyBEZWxldGVkIHBh
cnQKICAgfSBlbHNlIGlmIChzcmNfbmFtZSA9PSBzdGQ6OnN0cmluZygid2VicnRjX291dHB1dF9s
ZXZlbCIpKSB7CgoKMS4gQnV0IEkgd29uZGVyIGFib3V0IGFuIGFkZGl0aW9uYWwgc3BhY2UgY2hh
cmFjdGVyIGF0IHRoZSBiZWdpbm5pbmcKICAgb2YgdGhlIHNob3duIGZ1bmN0aW9uIGluIHRoZSBn
ZW5lcmF0ZWQgcGF0Y2guCgoyLiBXaWxsIGl0IGJlY29tZSBwb3NzaWJsZSB0byBhY2hpZXZlIGEg
c2ltaWxhciBjaGFuZ2UKICAgaWYgdGhlIHNwZWNpZmljYXRpb24g4oCcYXV0b+KAnSB3b3VsZCBi
ZSB1c2VkIGluc3RlYWQgb2YKICAgdGhlIGRhdGEgdHlwZSDigJxjaGFyKuKAnT8KICAgaHR0cHM6
Ly9naXRodWIuY29tL3d3bW0vcHVsc2VlZmZlY3RzL2Jsb2IvYWNiNTE2MWE2YWI4ZDNiMGMzOTVl
ZDI4MDlkMzMxOGNjZjQ5MzFiYy9zcmMvc291cmNlX291dHB1dF9lZmZlY3RzLmNwcCNMNgoKUmVn
YXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0
ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
