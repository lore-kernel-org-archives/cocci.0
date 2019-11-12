Return-Path: <SRS0=dn/h=ZE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EDEC43331
	for <cocci@archiver.kernel.org>; Tue, 12 Nov 2019 08:05:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C577321783
	for <cocci@archiver.kernel.org>; Tue, 12 Nov 2019 08:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="bhbezo0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C577321783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAC84xsa025373;
	Tue, 12 Nov 2019 09:04:59 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 56C2877C2;
	Tue, 12 Nov 2019 09:04:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 737E024D7
 for <cocci@systeme.lip6.fr>; Tue, 12 Nov 2019 09:04:57 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAC84ulI019134
 for <cocci@systeme.lip6.fr>; Tue, 12 Nov 2019 09:04:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573545896;
 bh=1oyK9msD55HQM3/RBrR/yTZDoa/LTnHz/j5dC+dN/oc=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=bhbezo0Lq4GOJQ8Eo/lqBy9PmK4cX0ehGa/+VprOOBrY5TuQaSmRDJPqUzsPoB1p5
 wSydBxkhaM7396LjUDiZVi4DEgl0UU+fFUyGR71oN5LjrdTFOisY8lAcQyCx5X5P5t
 Cac92bUjiYSjhXnxqLsrdPM53IMG+TGzMwawieE0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lrs70-1hkpHy2R6U-013egd for
 <cocci@systeme.lip6.fr>; Tue, 12 Nov 2019 09:04:56 +0100
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <c86eccbc-a1f3-50fa-34bf-f8fefdd3036f@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0488a253-fa97-cc18-7884-a7509016d8fe@web.de>
Date: Tue, 12 Nov 2019 09:04:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c86eccbc-a1f3-50fa-34bf-f8fefdd3036f@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:vov8Kt2njTjs9ZUtFlt73jWWzx6/vyoZ1lHr1ibWrFuUt+2wZXs
 RusWMDDGpLtUyUiT9tKh1pOKC9H+MOuDBfpAPYS+ZHU8S/NoUrTOpqhaAks5r2X9sKTPtSo
 Vdl+LGeYtLDNJ7h/lUy6/kPvqrj551L463lhR56VwFr1o2iOtSFegKu18iEd2MzT3qB+zNA
 FitR8nC3aUdvmQmD6gObQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6mqeP4iqcgA=:rOHDCZL62MK2ATy++t+3It
 zpN5vYxbFPe8BH4OC5Y9AnH17xVezpSYHNkPcDbiy95LU28+ij2FX+tpV94h8+DX8lgEZE0sy
 aL6y0f+Zlc3ZhsOwLrBPggr+1HF2Yo7f2kMHTSxmVc7rhyvTJxoaSicl3CgV0m7rNLjf4iyQN
 AVSRrxU6/ftFHEP6ELjjIXpgAyHT0VvSp9wCPVax4aBkKLuzidpe3NvWgxre8TnxJxEKr5bav
 fAYme3uMXE+g9nYEyz0TmMKugN9XExbiZzwI1yMCZ4/DfVngUyHit7D81o9q3gUn/Ur7noFwq
 pAan6IsWOQROaoCdCujA1aMOXopxX/LsJAMkWfAd7b94DnHlzKMoYNRsCy0NYgN2nnd7A0EhL
 YBjKrxg0nh/dzZIVoRutXpshj48b/tHa2aEr4rE7mPc6STGILjALaF+CoMyYJTl5z1hUeYQKq
 huiYLshIYizRCYu54GY5I1lGNpvehc8E/Sbzj8QkBTXb1ITMHdDdr598GNWHu3qBFA1hFKgV/
 dWOV+KMWyAW/bWn5Klh3xRhypbDFbxB9GibIDoeASpDosF19vTwxDcJsU9EQ5SWMALTI7+id6
 OEExR/xfGf8dlMCOhVpWOLoOMJwJsYo220P+0nuuQwU5U8C+pgjzMJW1OAxBA9cEcmcQ4y47Z
 nq6uTUBbzSQ0pe82hqibMK3zNj1Sz9+4khmiieW6Vib+TLV9+2P1PPjYGRnI+40+Ymoaj8nSZ
 ulc4QsITTys21OtIzV9Jc8jpDevZ6M202nVj8yq9Iz86CVa8dy4pnQkylyEw6vVQT4ushESuT
 ueBnjJk6AhM7NVntxGlSV//CICWBM0RrusYllDG2+t7kcbhO75IQ7KuXu2ARh/vQNCD9kC1CT
 YiQ9az20IpOaw41M8RDZZPKElY1onRcmOz2fLWtCkE0uMk3VR7POqq36Jcj3zBXfSxSFvuvBu
 do4ydwoYRjifc/mAnXwJMBphdbRG0FiMJEPVOLgzUOQEvc4nepbsZ6JV2VB+zfts7SnUy3PPE
 ZSXkHiOxjLpibbRSJfyBtdk56f6FdXs4OHmO9obvWyhL27yXbEEca2JfcJqehNQ1G1u7AnG3N
 PJwIeBRXCux0v3E0BTmvB1PwA7YXPEXVPriNvqTi/jg+xMugg/33neWEXOx0hrkU97OwGFwQj
 ugZkcj09yhmAzZMv7cckqr+Bsf5D9JZ+DfB0qZAXqb1vS/XzpBS2CDzxSEvsT1vjktEGEtvdI
 D6V3Y88r+kNBx/3BDOOwqxnrWoJ6NGCviMvaONCfCVxBeKbW5ASGkloVb1Y4=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Nov 2019 09:04:59 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 12 Nov 2019 09:04:57 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Checking data processing for parentheses in SmPL scripts
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

PiBVbmZvcnR1bmF0ZWx5LCB0aGUgZXJyb3IgbWVzc2FnZSDigJx1bmV4cGVjdGVkIGNsb3NlIHBh
cmVudGhlc2lzIGluIGxpbmUgNuKAnQo+IGlzIHJlcG9ydGVkIHRoZW4uCgpUaGUgZm9sbG93aW5n
IGNoYW5nZSBzcGVjaWZpY2F0aW9uIGdldHMgYWNjZXB0ZWQgYnkgdGhlIENvY2NpbmVsbGUgc29m
dHdhcmUuCgpAYWRqdXN0bWVudEAKZXhwcmVzc2lvbiBYOwpAQAorcG93ZXJvZjIKICgKLShYLTEp
JgogWCkKLSA9PSAwCgoKV291bGQgeW91IGxpa2UgdG8gZGlzY3VzcyBzaW1pbGFyIFNtUEwgY29k
ZSB2YXJpYXRpb25zIGFueSBtb3JlPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBz
eXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9j
b2NjaQo=
