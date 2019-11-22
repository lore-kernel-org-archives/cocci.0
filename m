Return-Path: <SRS0=0+7Q=ZO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102D1C432C3
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 09:25:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2AA2070E
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 09:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WyvJVocZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2AA2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAM9Oh53009567;
	Fri, 22 Nov 2019 10:24:43 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1409677E3;
	Fri, 22 Nov 2019 10:24:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8859577D2
 for <cocci@systeme.lip6.fr>; Fri, 22 Nov 2019 10:24:41 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAM9OfHM028110
 for <cocci@systeme.lip6.fr>; Fri, 22 Nov 2019 10:24:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574414680;
 bh=CYj0j/4lvcwK1ZjfCAKDjV/fcnHUo+wL+Q2MR96v4go=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=WyvJVocZ84ZDAmGuQiFA/BlXPNcAysRyzFS3dbbIssuXrkNRHWBG38A1m6mXkQozE
 5ahMXAJW4/0/8Hj7v8w1Z82sDIgnVJsyUX/jtpotenLcYAw4irZOA33ZZW9QfwS153
 MsgQKmCQpZMs5P17DEXDiiq0Gs6EEpzwihpE+UwE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.174.75]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYO5B-1iKett2gFt-00VAwS for
 <cocci@systeme.lip6.fr>; Fri, 22 Nov 2019 10:24:40 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cc561358-4d00-9f1f-eaa2-8fae400ccc8b@web.de>
Date: Fri, 22 Nov 2019 10:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:FhdjZPyWWJEATRqA1tzYznM+K4xpZTWIkOoVEeSVSELmqhMApE8
 +TqdelpkxJToXMqZSwsCccKRnqVMbL7VKBGXDVTCEyP5/7yGuS4A2Q07VA0yu5yiySF3dIl
 qEQkIsAdSNLQm0rZxm37+0PXzZBuOZbPwYwQI5AogSkZDEHCiyZV3Eu6SJLEowaDzDRHX3I
 M+0b+WfdMkMViyscYLpmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8LjskY7dMrk=:kC/cERnLQbbU0UoKmzlizs
 H7o6bAlPm52FT8RRfgoOWKPsUwgqLdsX4K9aQ29oeh9jQB0H7+Fik3NS5PMuE838ikcIIa0Q4
 mg629xDOr9qe7EvE55iWWA9zvlin0wcJOMBqH+g3RH/B8n4WU1EvN+5AJRumdhB1Dd0XzQvsh
 E5B10zv+JADVSHlciu5KnzuIimaRIhJ6hKiyyTrSf53/vZ4/rt23CMZvUOaAV5k4zs3uHYUfH
 l4egNlZBJ8O0fNZEDiW/LqFFNcVABtDqDVGWMM1e0NkerAKpz3t7nhBHyr5EareJUolCB/aOR
 QK0MbaJI8dnta58LRyDiXxclCNFHPnzmHIUFb+8fRps4SKVTO08G4cUqEqTYGbPdkKNIyDh+9
 btWv/n3t8RYVvJwv+UoZ683gF7nRHfT9q7vjKHsa3KO71+jHUJtmf5z29Lzb9UtH8SYT1qxeW
 GV8rXbXjExmzpxVyLlfbqmYesQCnCcs+1DbOI1ovAiSeLGMYGV0jW4ZhjMyDppz70d/kh5V2K
 nMgn7WQeMbiy7jZqqLYxfUmcs2mCQVsenIWZnKv8JeGYzqySSA9IRfHuaF7FYd6F0pafyjYqc
 WV9RoLK3fhfdzT9lgUmKDq7x+WyJuQbEgDA8kQTng4NL4TkuagTqkytegJ4BZTCrQ0PicZvW1
 tc6S5vFewFZhkgX8XR0A9zfVzpqgEmWqH0udiX2MYFuIjf47O+xcRqLx2AOKx5EIoK27tgd4W
 VTY2wualFN+FPTraQBSgnnCN/MtYcZUOm1/wF44EwSvina4MCP7+xTeBCdV5XSjhZPYbZrLbK
 3/DYEfXFI9F9SrXxk+RhB1TXCLPcnJHUDcVY4INTLZKZwRdDHbnHdd738fX0CNG0vfkYp8+0Q
 Otwz04xI372SQwdF3p+2lA3SXMdX7do+aeP3ePuPhgUd5hqZGQqX8gRvNQKoRIbIIT919DTB/
 kzQq4INcyZPx94+RR1RZPTdwJ2jhA39AJgUt661vGilOD5YkTDDqQhy0jlHIiHOvBvZYMs+Jv
 zuUKzVanRjzxv9nsUDQ0AIM2L4ercyaMfQgxwof9ocJOHxLpCzhg+hicqHTSr8rzSvgxRHChp
 WpsvvJfOjM6hyQa3h5GcA65j8iOExzKGHc0rmV6CJrhNTmW+md7xIIJZYARBeVEgaO1/BeLVW
 Dj/RrxIMpbJshUjVoQI09M6l3DcF3QQ3sCzDomkYltBODsbnfypw8HodtlNUEI546Pbgxa84A
 d2nPsSTrGuOG5QozNukynX8OF8wA/nSltP83ZosOaw3Yfpf47n86MG1u1L2o=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 10:24:43 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 10:24:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Concerns around type safety for usage of expressions
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

SGVsbG8sCgpUaGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2Ugc3VwcG9ydHMgc291cmNlIGNvZGUg
c2VhcmNoZXMgYWxzbyBmb3IgdXNlcwpvZiBzcGVjaWZpYyBkYXRhIHR5cGVzLiBTdWNoIHJlc3Ry
aWN0ZWQgc2VhcmNoZXMgY2FuIG9jY2FzaW9uYWxseSBiZSBuaWNlLgpCdXQgd2Ugd291bGQgbGlr
ZSB0byBmaW5kIG1vcmUgc29mdHdhcmUgdmFyaWF0aW9ucyBvZnRlbiBlbm91Z2guClRoZSBjb25z
ZXF1ZW5jZSBpcyB0aGF0IG1ldGF2YXJpYWJsZXMgb2YgdGhlIGtpbmQg4oCcZXhwcmVzc2lvbuKA
nSB3aWxsIHVzdWFsbHkKYmUgYXBwbGllZC4gQnV0IGl0IGJlY29tZXMgdW5jZXJ0YWluIHRoZW4g
dG8gd2hpY2ggZGF0YSB0eXBlcyB0aGUgZm91bmQKZXhwcmVzc2lvbnMgd2lsbCBiZSByZXNvbHZl
ZCBmaW5hbGx5LgoKV2Ugd291bGQgbGlrZSB0byBhY2hpZXZlIGNvbnNpZGVyYWJseSBzYWZlIHNv
ZnR3YXJlIHRyYW5zZm9ybWF0aW9ucy4KVXNlIGNhc2VzIG9jY3VyIHRoZW4gd2hlcmUgdGhlIGNv
cnJlY3QgYXBwbGljYXRpb24gb2YgZGF0YSB0eXBlcwppcyBlc3NlbnRpYWwuIChUaGUgaW50cm9k
dWN0aW9uIG9mIGZhbHNlIHBvc2l0aXZlcyBpcyB1bmRlc2lyYWJsZSBoZXJlLikKCkhvdyBtdWNo
IGNhbiBTbVBMIHNjcmlwdHMgaGVscCBmb3IgY29ycmVzcG9uZGluZyBjaGFuZ2VzPwoKUmVnYXJk
cywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1l
LmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
