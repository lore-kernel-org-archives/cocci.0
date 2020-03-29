Return-Path: <SRS0=tDau=5O=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC5BC43331
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 11:16:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7A62076A
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 11:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="gmM3ZjdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7A62076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02TBGAB1000202;
	Sun, 29 Mar 2020 13:16:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5A0A87750;
	Sun, 29 Mar 2020 13:16:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6919A66CB
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 13:16:08 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:42f])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02TBG7Fb014179
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 13:16:07 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id 65so17476576wrl.1
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UpJGKAJOWFns3bgAGWqGBZumCwNs4nAWgVhiTO3ZqwY=;
 b=gmM3ZjdLKXcaKZPJJjEKUoHrv5SWrXTNSkIjxtzVXppLoxxPdSp6fQKi7NiD7RzR4k
 ORjvCZDJ07m1lbhySxWnsCgjAQEcRXfQc9gsYd1wDlUjWaYaB8U260gD/AKPN0oddvaR
 nhnr4mgc6bgaO+dkFg9G+QsyUsZulZn5r4UI6etqaKfJ/0R5leWj58YHV4zy78IkMPvy
 t9j7o2UhA1yzDQ8I/c3ukrB7P3XUAU6mvXMZGWxzOOlkEh9XHZVI7vVLdSL53fTCVRi9
 DEAN+zQfnncnISSu5AHOC8Zvspg4RenD/a4HuwKVkLtSAZT+83z6Ro60R8WcggmLM/RH
 X8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UpJGKAJOWFns3bgAGWqGBZumCwNs4nAWgVhiTO3ZqwY=;
 b=Yi+LVpuVrryh+Pdi7S9Ae5S8Ezk3i1SVGxdwDdfQxfUU4+C7eq8cBsD8RMY6zJzBZ0
 qDCEcvuHEUyD5kl5f51BfMgZn3i6PIXuFrp+gEW8qKgrfqeD7Pk/P1ZSgpe/qvBB+8kS
 SHUZUULOUjoLfNPwIyvbnBjPUhFW+ahiKt7R0MqzFW9ANnn4fjHnWVJbU6wnbm14ntwZ
 K1nbimRUe73jWTZR6TxK0wb1Hy1CuDfElIDaVVD4XkQI3YpM+npxZ/izoq2FdMwM5Blk
 v3fFGQKr6RKvUDGyE6LoNxfXL/wYc3le7Tc8do29CdqrfqmuXUJMXeP4ueXOt6WNNcbq
 OADg==
X-Gm-Message-State: ANhLgQ1qBgbpUD/e4Yw1qk7wCLlodQwLugX/Rz3vZpv1CnRUWpA48ZN1
 u/7NdED+jpvcqx8kpwbZGVBEZJYfEYM=
X-Google-Smtp-Source: ADFU+vsFuO/ibqrGbMMb4aaf1ikFetFxiEPzMJjHP5HLmUVGZgMXRCUZy/TxUAo5DImZARSmeaI5uA==
X-Received: by 2002:a5d:4cc2:: with SMTP id c2mr9639473wrt.398.1585480567163; 
 Sun, 29 Mar 2020 04:16:07 -0700 (PDT)
Received: from localhost.localdomain ([94.136.13.132])
 by smtp.gmail.com with ESMTPSA id w7sm16874963wrr.60.2020.03.29.04.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Mar 2020 04:16:06 -0700 (PDT)
To: Julia Lawall <julia.lawall@inria.fr>
References: <b86347f3-69d3-0801-c91f-87c3424e71dc@linbit.com>
 <alpine.DEB.2.21.2003271645370.2709@hadrien>
 <1f1a7b29-b767-551c-e2ec-d5cdf5ceecd0@linbit.com>
 <alpine.DEB.2.21.2003271714150.2709@hadrien>
 <2a36722e-c5ff-aa94-fac1-d885b89176d0@linbit.com>
 <alpine.DEB.2.21.2003291118410.2990@hadrien>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <0d87349e-f919-562e-eeea-fe6b09f44462@linbit.com>
Date: Sun, 29 Mar 2020 13:16:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003291118410.2990@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 29 Mar 2020 13:16:10 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 29 Mar 2020 13:16:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Matching against a declarer macro
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

QW0gMjkuMDMuMjAgdW0gMTE6MjAgc2NocmllYiBKdWxpYSBMYXdhbGw+Cj4gSXQncyBub3QgcGFy
c2luZyBhbnl0aGluZy4gIFlvdSBjYW4gc2VlIHRoYXQgaGVyZS4gIEl0IGlzIHBhc3NpbmcsIGll
Cj4gaWdub3JpbmcsIHRoZSBlbnRpcmUgY29tbWFuZCBsaW5lLgoKUmlnaHQsIEkgbWlzaW50ZXJw
cmV0ZWQgdGhhdCAicGFzc2VkIiBhcyAidGhlc2UgcGFyYW1ldGVycyB3ZXJlIHBhc3NlZAp0byB0
aGUgbWFjcm86Ii4KCj4gCj4gSSBkb24ndCByZW1lbWJlciB0aGUgZXhhY3Qgc2l0dWF0aW9uIHdp
dGggdGhpcyBjb2RlLiAgSXMgdGhlcmUgbm8KPiBzZW1pY29sb24gYXQgdGhlIGVuZCBvZiB0aGUg
bWFjcm8gbGluZT8KClRoaXMgaXMgdGhlIGV4YWN0IHBpZWNlIG9mIGNvZGU6CgpSQl9ERUNMQVJF
X0NBTExCQUNLU19NQVgoc3RhdGljLCBhdWdtZW50X2NhbGxiYWNrcywgc3RydWN0IApkcmJkX2lu
dGVydmFsLCByYiwgc2VjdG9yX3QsIGVuZCwgTk9ERV9FTkQpOwoKUHV0dGluZyB0aGlzIChhbmQg
b25seSB0aGlzKSBpbiBhIHRlc3QuYyBmaWxlIHByb2R1Y2VzIHRoZSBzYW1lIHByb2JsZW06Cgok
IHNwYXRjaCAtLXBhcnNlLWMgdGVzdC5jIC0tZGVidWcgLS12ZXJib3NlLXBhcnNpbmcKaW5pdF9k
ZWZzX2J1aWx0aW5zOiAvdXNyL2xvY2FsL2Jpbi8uLi9saWIvY29jY2luZWxsZS9zdGFuZGFyZC5o
CgpQQVJTSU5HOiB0ZXN0LmMKV2FybmluZzogUEFSU0lORzogdHlwZSBkZWZhdWx0cyB0byAnaW50
JzsgdmFsdWUgPSBbKCgoKDAsIDIpKSkpOyAoVGFnMSAKKCIiLCAoKCIiLCAwLCAwLCAwLCAiIiks
IC0xKSksICgwKSwgKCgwLCAwLCAwLCAwKSksIDAsICgzKSldCkVSUk9SLVJFQ09WOiBlbmQgb2Yg
ZmlsZSB3aGlsZSBpbiByZWNvdmVyeSBtb2RlCnBhcnNpbmcgcGFzczI6IHRyeSBhZ2FpbgpUWVBF
REVGOl9oYW5kbGVfdHlwZWRlZj1mYWxzZS4gTm90IG5vcm1hbCBpZiBkb24ndCBjb21lIGZyb20g
ZXhuCldhcm5pbmc6IFBBUlNJTkc6IHR5cGUgZGVmYXVsdHMgdG8gJ2ludCc7IHZhbHVlID0gWygo
KCgwLCAyKSkpKTsgKFRhZzEgCigiIiwgKCgiIiwgMCwgMCwgMCwgIiIpLCAtMSkpLCAoMCksICgo
MCwgMCwgMCwgMCkpLCAwLCAoMykpXQpFUlJPUi1SRUNPVjogZW5kIG9mIGZpbGUgd2hpbGUgaW4g
cmVjb3ZlcnkgbW9kZQpwYXJzaW5nIHBhc3MzOiB0cnkgYWdhaW4KKE9OQ0UpIENQUC1NQUNSTzog
Zm91bmQga25vd24gbWFjcm8gPSBSQl9ERUNMQVJFX0NBTExCQUNLU19NQVgKVFlQRURFRjpfaGFu
ZGxlX3R5cGVkZWY9ZmFsc2UuIE5vdCBub3JtYWwgaWYgZG9uJ3QgY29tZSBmcm9tIGV4bgpXYXJu
aW5nOiBQQVJTSU5HOiB0eXBlIGRlZmF1bHRzIHRvICdpbnQnOyB2YWx1ZSA9IFtbWzBdXTsgKCgo
KDAsIDIpKSkpOyAKKFRhZzEgKCIiLCAoKCIiLCAwLCAwLCAwLCAiIiksIC0xKSksICgwKSwgKCgw
LCAwLCAwLCAwKSksIDAsICgzKSldCnBhc3NlZDpzdGF0aWMgLCBhdWdtZW50X2NhbGxiYWNrcyAs
IHN0cnVjdCBkcmJkX2ludGVydmFsICwgcmIgLApwYXNzZWQ6c2VjdG9yX3QgLCBlbmQgLCBOT0RF
X0VORAotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQptYXliZSAxMCBtb3N0IHByb2JsZW1hdGljIHRva2VucwotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpOQiB0b3RhbCBmaWxlcyA9IDE7IHBlcmZlY3QgPSAx
OyBwYnMgPSAwOyB0aW1lb3V0ID0gMDsgPT09PT09PT09PiAxMDAlCm5iIGdvb2QgPSAxLCAgbmIg
cGFzc2VkID0gMiA9PT09PT09PT0+IDY2LjY3JSBwYXNzZWQKbmIgZ29vZCA9IDEsICBuYiBiYWQg
PSAwID09PT09PT09PT4gMTAwLjAwJSBnb29kIG9yIHBhc3NlZAoKCkRvZXMgdGhpcyBtZWFuIHRo
YXQgdGhpcyBpcyBqdXN0ICJ1bnBhcnNlYWJsZSI/Cgo+IAo+IGp1bGlhCj4gCj4gCj4+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4+IG1heWJlIDEwIG1vc3QgcHJvYmxlbWF0aWMgdG9rZW5zCj4+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+IE5CIHRvdGFsIGZpbGVzID0gMTsgcGVyZmVjdCA9
IDE7IHBicyA9IDA7IHRpbWVvdXQgPSAwOyA9PT09PT09PT0+IDEwMCUKPj4gbmIgZ29vZCA9IDE2
MCwgIG5iIHBhc3NlZCA9IDIgPT09PT09PT09PiAxLjIzJSBwYXNzZWQKPj4gbmIgZ29vZCA9IDE2
MCwgIG5iIGJhZCA9IDAgPT09PT09PT09PiAxMDAuMDAlIGdvb2Qgb3IgcGFzc2VkCj4+Cj4+PiBE
byB5b3Ugd2FudCB0byBhY3R1YWxseSBtYXRjaCBOT0RFX0VORD8gIElmIHNvLCBpdCBzaG91bGRu
J3QgYmUgZGVjbGFyZWQKPj4+IGFzIGEgbWV0YXZhcmlhYmxlLgo+Pgo+PiBSaWdodCwgSSBkbyB3
YW50IHRvIGV4YWN0bHkgbWF0Y2ggTk9ERV9FTkQsIHNvIEkgcmVtb3ZlZCB0aGUgZGVjbGFyYXRp
b247Cj4+IHN0aWxsIG5vIG1hdGNoIHRob3VnaC4gSWYgaXQgaXMgZGV0ZWN0ZWQgYXMgYSBrbm93
biBtYWNybyBpdCBzaG91bGQgYmUgYWJsZSB0bwo+PiBiZSBzdWJzdGl0dXRlZCwgcmlnaHQ/Cj4+
Cj4+Pgo+Pj4ganVsaWEKPj4+Cj4+Cj4+IFRoYW5rcywKPj4gLS0KPj4gQ2hyaXN0b3BoIELDtmht
d2FsZGVyCj4+IExJTkJJVCB8IEtlZXBpbmcgdGhlIERpZ2l0YWwgV29ybGQgUnVubmluZwo+PiBE
UkJEIEhBIOKAlCAgRGlzYXN0ZXIgUmVjb3Zlcnkg4oCUIFNvZnR3YXJlIGRlZmluZWQgU3RvcmFn
ZQo+Pgo+IAotLQpDaHJpc3RvcGggQsO2aG13YWxkZXIKTElOQklUIHwgS2VlcGluZyB0aGUgRGln
aXRhbCBXb3JsZCBSdW5uaW5nCkRSQkQgSEEg4oCUICBEaXNhc3RlciBSZWNvdmVyeSDigJQgU29m
dHdhcmUgZGVmaW5lZCBTdG9yYWdlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0
cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
