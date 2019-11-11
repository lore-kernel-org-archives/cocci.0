Return-Path: <SRS0=c7KL=ZD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F371C43331
	for <cocci@archiver.kernel.org>; Mon, 11 Nov 2019 16:47:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F95214DB
	for <cocci@archiver.kernel.org>; Mon, 11 Nov 2019 16:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="mcSiFxlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F95214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xABGlLvF028386;
	Mon, 11 Nov 2019 17:47:21 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4A8BC77C2;
	Mon, 11 Nov 2019 17:47:21 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 66CFA7700
 for <cocci@systeme.lip6.fr>; Mon, 11 Nov 2019 17:47:20 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xABGlJAd025230
 for <cocci@systeme.lip6.fr>; Mon, 11 Nov 2019 17:47:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573490839;
 bh=lddRJJSzXiSJk+NhBhxiwWb9u5/BxjIQPiNUT8S7qGU=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=mcSiFxlHts06LWzGZDgULLO04mH1kF19/Ldd3zAC1zWKclbgCJtEi53In+0S6WrGD
 zXO53GvLZ/17XMhk0uZ0WzgbBlBQTlksvcj3ENzZYAgIUOdQ0MX/ua1CoPoYrGn67r
 OySSF+5sOuTASMEYG2l1F0o8Pg7rqSPwp7FEWqMc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.55.229]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lk8T4-1htEOz2AQc-00c8Ti for
 <cocci@systeme.lip6.fr>; Mon, 11 Nov 2019 17:47:19 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c86eccbc-a1f3-50fa-34bf-f8fefdd3036f@web.de>
Date: Mon, 11 Nov 2019 17:47:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:rx+lkcAF1j6vTe5vaKH78WER7KhHU4MyyNoBemERyW7SfbH8hIk
 9uDQNk1tz64OtmRkIMqas3pferXiWx9KtX9QVETlqCioNXN23gq/5j3PuAdYL3R38etzL8+
 X0Q7a72+HwGZvuhPeaZsAUWju/bfceF5FmmvUkDjivrnF854ur77UnuUN8tRmbs7ewLQHMF
 wHue7NmEGJi7lrsgIaxoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gn6cpP+PXjE=:9kxPOAlQ3ryQAj7Z+RxGvH
 ueP13wwg9YyAusNPx0kN2Bv4dO+FVexC0gl7apGLF5swylRy90SusuUOh0/oGqIyruqQifcED
 O/7uuMmctYuvJCHGoddMVJpU5n/Br0+UKSH+36J/4Vp0FNMVmyAwem1CE8MDxkz4mNMFeOCUB
 /YcYoCwtixRpz3Si93N9eUt2vwvJUG0z/AyvokeWa3kyAqCrAxgyQGlW9xMdyJXNLhnu26zyi
 tUoXUIbvp3Fuwj83U//n23RquqnU1GcF7k1HDGVl/rqM74Py0F55+/P3sZzFdYG4IH26N84sG
 6ff7deh9Ya+xQYS1NF6Kdn45n8wNM4UL9tpz3hCpGEj3ATW1SBQH1CQ3lyJ4SlP5UfifVGBCs
 bkW7Ncfu385ogS4YBxvLokIyEPK8oXYOh6pICC/gAu8+Qwz3krXlAWJ6w5Be6AofqpaXMdUpL
 d5yomRAmZrRi4Ma6LZ+15cCC8vn6uWMZWUH1Vzs9rBOK/uO+e7b9ds8BXssDguB8VTu9t252T
 mcTNpuPHxtflKmXBIyBKSU8/kHdF1qSf1KV68AY0iparXGzdFdhFlAIEtv+msPaeaBRKouMWk
 4KzqjUu2EhG9Sbcd5IoBt5CL+ef7ZTFfDUZqvpXhnwYzb9goMRKuQsP3U2ei7mBM59UntYk4Z
 C2LF33bHS2LqWK618Sg597PNhbnOPC89eEGZinSS0tSuv8GqAn1erjkBILUeZYZRWiqHBqGp2
 XtxgYbJON/mjcYOQM1ZXuRyP381i2wEQyxSkUtqGaHozlWtjy7pXObfXfbX+YXY5UOJoNEP+h
 oNbWjFbNy8rHnVhcmEpyWCATpIwnPcOTPfjgJ2iMryjYzfSxneawhn7A7Sy+F97WbrkHylPxj
 YrlP2SyU9XFMtDar/dnfUdBlclXhuQpPhAJgGS+0YD1Pt58HsseH2ehmNRyynmPBDEzaJ6Vus
 +n5MWFckuETnuMtjrp/k5vFxxrNnDf8BmKeuLCdKZPWD+HBBD4S8xOiXM3N+Stt2sxQ8LOnL5
 nAbxpQmJCSEqKnAwZ12tPxLUuMRLeQ2yt7kDsToFtNcEiAtdqdYityGhnIuKXFHNJDGummvOm
 5/La4X1G6HAwh2WQEyLnZZQoQ1DUfIar6IKK+emuf6ko1AO1zp4OnJbUQF8er6WabJpXUuh/b
 zUOAXYT4cTBN3pnzUcfZw4EBCVD8w/C3euvnE7Q0QAbJ6n5t4yo3TAUv84NunBG61n3Hp62dV
 256KsLsdS/i9sPU66MeU7ArTXCJ3wqq1PA7Desj2jc161wHIzIK4BtPM+RrY=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 Nov 2019 17:47:21 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 11 Nov 2019 17:47:20 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking data processing for parentheses in SmPL scripts
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

SGVsbG8sCgpUaGUgZm9sbG93aW5nIGNoYW5nZSBzcGVjaWZpY2F0aW9uIGdldHMgYWNjZXB0ZWQg
YnkgdGhlIENvY2NpbmVsbGUgc29mdHdhcmUuCgpAQApleHByZXNzaW9uIFg7CkBACi0oKFgtMSkm
WCkgPT0gMAorcG93ZXJvZjIoWCkKCgpTZWUgYWxzbzoKaHR0cHM6Ly9naXRodWIuY29tL0RyYWdv
bkZseUJTRC9EcmFnb25GbHlCU0QvYmxvYi83MjJjM2I4YjYzNzZkZWFiOTQwN2ZmMDBiNWU2MzAx
OGFiM2FlZjBiL3Rlc3QvY29jY2kvdXNlZnVsX21hY3Jvcy5jb2NjaSNMNTMKCgpJIGdvdCBpbnRv
IHRoZSBkZXZlbG9wbWVudCBtb29kIHRvIHRyeSBhbm90aGVyIGNvZGUgdmFyaWFudCBvdXQKZm9y
IHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZS4KCkBhZGp1c3RtZW50QApleHByZXNzaW9uIFg7
CkBACitwb3dlcm9mMigKLShYLTEpJgogWCkKLSA9PSAwCgoKVW5mb3J0dW5hdGVseSwgdGhlIGVy
cm9yIG1lc3NhZ2Ug4oCcdW5leHBlY3RlZCBjbG9zZSBwYXJlbnRoZXNpcyBpbiBsaW5lIDbigJ0K
aXMgcmVwb3J0ZWQgdGhlbi4KQ2FuIGFuIG90aGVyIGNoYW5nZSB2YXJpYXRpb24gbWFrZSBzZW5z
ZSBmaW5hbGx5PwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYu
ZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
