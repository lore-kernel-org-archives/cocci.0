Return-Path: <SRS0=lBEj=6A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34A9C2BA2B
	for <cocci@archiver.kernel.org>; Thu, 16 Apr 2020 07:13:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3E720771
	for <cocci@archiver.kernel.org>; Thu, 16 Apr 2020 07:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="N8C2Hit3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3E720771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03G7Chub027936;
	Thu, 16 Apr 2020 09:12:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7D5C3781F;
	Thu, 16 Apr 2020 09:12:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8DD097816
 for <cocci@systeme.lip6.fr>; Thu, 16 Apr 2020 09:12:41 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03G7CeoA004780
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 16 Apr 2020 09:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587021159;
 bh=duNySOO9tFXrCcla5sCY+qhsmv4ZrAqA3I9RbUJRyzU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=N8C2Hit3GOasVPw7bjwH70MhLXc6acKKTGUqCzaa6YNAqIozWMxG2WTX0GKia2VXr
 pJqCZ2a0NelfT4bKhF/YbBsCnk22EUnWVRS+KGoeDFGPtyK24BKVXwPlzpTIjgD9oa
 dyET8HdvYKze6rcAtn6vg5Iw943Zen9NCaI/z1B0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.109.113]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHGed-1jUFt61XVr-00E3Tq; Thu, 16
 Apr 2020 09:12:39 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <alpine.DEB.2.21.2004151949230.2381@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5702b553-d054-33a4-8544-f68ed5457acc@web.de>
Date: Thu, 16 Apr 2020 09:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004151949230.2381@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:h5Cqhkil+LzGtkE8GVmXIFDFjhYLv+d50TK2Gxu/MXElqbMz5wR
 ig0qSmEkWQyZo1L3+Z4KqAL88Mgx6im5oQvF91o6SBB9rQOGqE0kU2awWR+mRxfqrFWJvK0
 4Y4sx4iPGyfwgKrq3ME9mUMlbPzuQXFJi/xGmerW58g4PSu2aC10CfteH+qccQ+vgPI9OMT
 9iRhUk5giq46iKqzG8UtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RAlZpdUtrII=:5dOPLRdcQftCzLGO9izxSi
 XcV95dvFH365z5Mkq/jISq3cqxwLTBwmNI/OP3hKi/AYMTerD7PZtt2s7vojg32v9f8thsvfF
 iCi08N6tFnCH89l4TjwNw5fiZXkmIe9xTYaB56RdwrsXCUcooybLgBZhEmKg8NYYvKPpMCfdo
 WA/d0IgMfhdLy4OzqtOQdhhwbXJujkI9SdgALjtrkJRMSkYyTBcPBykgQd4cdqRDr93ayto6k
 3V0VlTEjuiQT4yCUWBfZGnK8sgpaV6qg29Hd7V8zLjS2nkb238fzHOQp+rXza9Uyq8f7IHzNh
 fDx20zTXceg8BG0tUPmw5e2fC49r6roOPxlTSWrtzZCxVSkmxJTe25gCRoN+YPQFjIeiRalrR
 wmLRvhEHha8lMWbHewcS5Z73310+X7sg9Qkmag1mZqOANtbboIAaKedghUeFfcZ2lhmrYY4CV
 QoYcvlP1+cbwhfYep/t2SzbsqKR3W2yQR3ilG9T6FTABDOLzMT3RhMI2QvSRPlin3dZyLd0VQ
 CNWQrpACTlLqHbWEcvS55Xt464E26hSJ6G5mk9rZIZndtUemt0dRzX/uXvTkdNYaAEp/Q8gKS
 4hoEqrdWs+7dCeJ6fIDd8zgZCdi/BcNt6Wegkf1eOunRMhOppgtOkDuYqcsk6M4OvPasZemez
 Iw3Otrm/tC/O496H6glY7in6wlGThVHhZiOe5tvVWHl2KZXSnMf0fn5SYpGmcfZwaTMnJUc2w
 c47xYqSDzBazJqeTO/79wBfsHkNvavAAyGPeU7aABgzGOVNN9nfQPSCkIOIu/nKocOxWQvodj
 Rp2bRqWHyx5xVuqizwRmp80ih8sMgiOqhFeIaYuCDZKc94r9H9adzkoypj1Po50sI5LE8GBTp
 FiEweIAcSTJhQNtrQVMMM5Po6HCED2Cc4vq7bMrIUwULWuaGKaaZNKvVVA5+Cv+e5OZQgBcui
 yJPjp/nwdOC7c4UbUy8j1OV4oHeWn5In24Qf3imznrMgq0pFmpCi1uWCe4Q3VZHc3Xha5AozY
 EqsWNJ6gw8RmRMUfETVXVVZexgDEp37IF4KdrreWcWGfmbKHqiFFu2ezmL56NgU4+GFfuAsjT
 08A3DaFzrOxoNpVTTgmD7MN/BrxafQ3llb8lOUqY/wCLi+jgl6mpEfkKvGlGksHfArcyORYFr
 21gELX30uStv0SCSdVlemRjh/VEpNlvokJ3BKg9nxbU7Js7srhR4ZZYRpg5AHLWUqSx+SBS3T
 SLZ0C5E77DmxxPsgP
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Apr 2020 09:12:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 16 Apr 2020 09:12:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Dejin Zheng <zhengdejin5@gmail.com>, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the replacement of two specific function calls
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

Pj4gQHJlcGxhY2VtZW50QAo+PiBleHByZXNzaW9uKiBiYXNlLCBkZXZpY2UsIHJlc291cmNlOwo+
PiBAQAo+PiAtcmVzb3VyY2UgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UoZGV2aWNlLCBJT1JFU09V
UkNFX01FTSwgMCk7Cj4+ICBiYXNlID0KPj4gLSAgICAgICBkZXZtX2lvcmVtYXBfcmVzb3VyY2Uo
JmRldmljZS0+ZGV2LCByZXNvdXJjZSkKPj4gKyAgICAgICBkZXZtX3BsYXRmb3JtX2dldF9hbmRf
aW9yZW1hcF9yZXNvdXJjZShkZXZpY2UsIDAsICZyZXNvdXJjZSkKPj4gIDsK4oCmCj4+IHN0YXRp
YyBpbnQgcmNhcl9pMmNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4gewo+
PiAJc3RydWN0IHJjYXJfaTJjX3ByaXYgKnByaXY7CuKApgo+PiAJc3RydWN0IGRldmljZSAqZGV2
ID0gJnBkZXYtPmRldjsK4oCmCj4+IAlwcml2LT5yZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Uo
cGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOwo+Pgo+PiAJcHJpdi0+aW8gPSBkZXZtX2lvcmVtYXBf
cmVzb3VyY2UoZGV2LCBwcml2LT5yZXMpOwo+PiAJaWYgKElTX0VSUihwcml2LT5pbykpCj4+IAkJ
cmV0dXJuIFBUUl9FUlIocHJpdi0+aW8pOwrigKYKPj4gfQrigKYKPiBQcm9iYWJseSBDb2NjaW5l
bGxlIGlzIG5vdCBhYmxlIHRvIGRldGVybWluZSB0aGF0IHByaXYtPnJlcyBhbmQgcHJpdi0+aW8K
PiBhcmUgcG9pbnRlcnMsIGlmIHlvdSBoYXZlIG5vdCBnaXZlbiBpdCBlbm91Z2ggZW5jb3VyYWdl
bWVudCB0byBsb29rIGZvcgo+IGhlYWRlciBmaWxlcyB0byBmaW5kIHRoZSBkZWZpbnRpb24gb2Yg
dGhlIHR5cGUgb2YgdGhlIHByaXYgc3RydWN0dXJlLgoKV291bGQgeW91IGZpbmQgdGhlIGZvbGxv
d2luZyB0ZXN0IGNvbW1hbmQgZW5jb3VyYWdpbmcgZW5vdWdoPwoKZWxmcmluZ0BTb25uZTp+L1By
b2pla3RlL0xpbnV4L25leHQtcGF0Y2hlZD4gc3BhdGNoIC0taW5jbHVkZS1oZWFkZXJzLWZvci10
eXBlcyB+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvci91c2VfZGV2bV9wbGF0Zm9ybV9nZXRf
YW5kX2lvcmVtYXBfcmVzb3VyY2UzLmNvY2NpIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtcmNhci5j
CgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6
Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
