Return-Path: <SRS0=WUls=6J=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CDEC55185
	for <cocci@archiver.kernel.org>; Sat, 25 Apr 2020 13:16:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28F42071C
	for <cocci@archiver.kernel.org>; Sat, 25 Apr 2020 13:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odm/0TvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28F42071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03PDFtjC000321;
	Sat, 25 Apr 2020 15:15:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2C298781C;
	Sat, 25 Apr 2020 15:15:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6FA143DC8
 for <cocci@systeme.lip6.fr>; Sat, 25 Apr 2020 15:15:53 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03PDFpvB012557
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 25 Apr 2020 15:15:52 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id 18so6210383pfx.6
 for <cocci@systeme.lip6.fr>; Sat, 25 Apr 2020 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=2X5y9/W+WPCBUZfu2rBLDQK9YX3LEDIetIsu0q5BQLs=;
 b=Odm/0TvFAqAcZq1ZgfDNwlZOk0eA9Yy1KTBCPD7snA7sOgAtLwrpxDaDWSlE90DZPs
 SHcxmdFrrpCAwkVY46igg4elfUST2H2998qr7dKkzRM2Yw4kgU6RB8Qg5cUyP8Kk2Nln
 1OjzmsdIGG+Nyi0egCm3ag6q0KYubTgzCYlZmrmyETK69pqr8k6e3b2NSrh2mNA1BmcA
 sJ4FybgsrvIc0xeAfO5BOLgX9QdfyVrfI5hhNI6wT7zvArUiogMZBMBEq0CUmcpGSgJ8
 RAVzCeFdoH/YaDAzUbL7DsjTcJsdROgfLYEhTUiwaXEnlgKUbBbxdairhY7GECrzRSxf
 d6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=2X5y9/W+WPCBUZfu2rBLDQK9YX3LEDIetIsu0q5BQLs=;
 b=DIwDVoqW0QGgpHSjV8w7ukAsV0kwosA0jdLfYNqrNxmbe6L7lfWEBrGs6Ly5IJeiH3
 y+qPJjYxxJFobth8MvcneuqsODBTeXP4APag05cmI4cENn4QZOAhpkSDYu8NeQUTj5sn
 GNKnCN2bknNgu6YsGtRMilH1nF+gICXFjItZrhBmPvRmoUMQpyzpWEe5CEAf+q2fP3Hp
 NgjD2UjLxGslJYzPgcSrSWte6ffalR8PU2K1PnErP20OLbvE3+Nt2RcthzBhiWxxKDYr
 YQeWgodGxbVxAFJOgkmssjUtvXS60+f1BKMcUAmEJ8FRnEDGqK3fvXlfNNbMVHKgSHgQ
 Xf8w==
X-Gm-Message-State: AGi0PuYa0RTxk9xIHLLB2S0/m7TYgpnx8rlxMcWf/PeZKggcN/PZ3g/1
 yukY60cGnVQqZvRypzQZCkE=
X-Google-Smtp-Source: APiQypJF0v1BfMw0id1xhx6xW6SMQ0KPni9kslYHyTDUxN9VbMnCawv0XDZBkPCwMhC1BQuY3UNDgQ==
X-Received: by 2002:aa7:9724:: with SMTP id k4mr14922303pfg.309.1587820550962; 
 Sat, 25 Apr 2020 06:15:50 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.144])
 by smtp.gmail.com with ESMTPSA id c3sm8103900pfa.160.2020.04.25.06.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2020 06:15:50 -0700 (PDT)
Message-ID: <081e4dc524343830ad7653473e54d86081db807b.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Date: Sat, 25 Apr 2020 18:45:40 +0530
In-Reply-To: <490913cf-2563-25a5-c977-dadc87da866b@web.de>
References: <490913cf-2563-25a5-c977-dadc87da866b@web.de>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 25 Apr 2020 15:15:55 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 25 Apr 2020 15:15:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [RFC PATCH 00/25] cocci: Improve C parsing of attributes
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

T24gRnJpLCAyMDIwLTA0LTI0IGF0IDE0OjAyICswMjAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToK
PiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFpbXMgdG8gaW1wcm92ZSBwYXJzaW5nIG9mIGF0dHJpYnV0
ZXMgaW4gQyBieQo+ID4gQ29jY2luZWxsZSdzIEMgcGFyc2VyLgo+IAo+IEhvdyBkbyB5b3UgdGhp
bmsgYWJvdXQgdG8gdXNlIHRoZSB3b3JkaW5nIOKAnGluIEMgc291cmNlIGNvZGUgYnnigJ0/Cj4g
Cj4gCj4gPiBUaGVzZSBwYXJzaW5nIGVycm9ycyB3ZXJlIGRpc2NvdmVyZWQgYnkgcnVubmluZyBh
IGJ1aWxkIG9mCj4gPiBDb2NjaW5lbGxlJ3MKPiAKPiBXb3VsZCB5b3UgbGlrZSB0byBvbWl0IHRo
ZSB3b3JkIOKAnFRoZXNl4oCdPwo+IAoKSGkgTWFya3VzLAoKQ291bGQgeW91IHBsZWFzZSBrZWVw
IHlvdXIgZmVlZGJhY2sgcmVsZXZhbnQgdG8gdGhlIGFjdHVhbCBwYXRjaCBpdHNlbGYKKG9yIHRo
ZSBjb21taXQgbWVzc2FnZXMpPyBNYXliZSBwdWxsIHRoZSBwYXRjaGVzLCBhcHBseSB0aGVtLCBy
dW4gdGhlbQp5b3Vyc2VsZiwgc2VlIGlmIHNvbWV0aGluZyBicmVha3M/IEZlZWRiYWNrIGxpa2Ug
dGhpcyByZWFsbHkgaXNuJ3QKcmVsZXZhbnQsIHVubGVzcyB0aGVzZSBtaW5vciB0eXBvcy9ncmFt
bWFydGljYWwgZXJyb3JzIGNhdXNlIGEgX2xvdF8Kb2YgY29uZnVzaW9uLgoKPiAKPiA+IENvY2Np
bmVsbGUgY3VycmVudGx5IG1hbmFnZXMgYXR0cmlidXRlcyBzaW1pbGFyIHRvIGNvbW1lbnRzLAo+
IAo+IFdpbGwgdGhpcyBhc3BlY3QgdHJpZ2dlciBmdXJ0aGVyIHNvZnR3YXJlIGRldmVsb3BtZW50
IGNvbnNpZGVyYXRpb25zPwo+IAoKSSBkb24ndCBrbm93LgoKPiAKPiA+IHNvIHRvIGV4cGxpY2l0
eSBzdGF0ZSB3aGF0IHRoZSBhdHRyaWJ1dGVzIGFyZSB0byB0aGUgQyBwYXJzZXIsCj4gPiBhIE1B
Q1JPQU5OT1RBVElPTiBoaW50IHdhcyB1c2VkIGluIENvY2NpbmVsbGUncyBzdGFuZGFyZC5oIGZp
bGUuCj4gCj4gSSBmaW5kIHN1Y2ggaW5mb3JtYXRpb24gc3VzcGljaW91cyBhdCBmaXJzdCBnbGFu
Y2UuCj4gQWRkaXRpb25hbCBiYWNrZ3JvdW5kIGluZm9ybWF0aW9uIGZyb20gYW4gdXBkYXRlIHN0
ZXAgbGlrZQo+IOKAnFtSRkMgUEFUQ0ggMTIvMjVdIHBhcnNpbmdfYzogY3BwX3Rva2VuX2M6IElu
dHJvZHVjZSBNQUNST0FOTk9UQVRJT04KPiBoaW504oCdCj4gbWlnaHQgbWFrZSB0aGUgcHJvcG9z
ZWQgZGF0YSBwcm9jZXNzaW5nIGFwcHJvYWNoIG1vcmUgcmVhc29uYWJsZS4KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9jb2NjaS8yMDIwMDQyNDA5MTgwMS4xMzg3MS0xMy1qYXNrYXJhbnNpbmdo
NzY1NDMyMUBnbWFpbC5jb20vCj4gaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvcGlwZXJtYWlsL2Nv
Y2NpLzIwMjAtQXByaWwvMDA3MjE3Lmh0bWwKPiAKPiAKPiA+IFNlcGFyYXRlIHBhdGNoZXMgd2ls
bCBiZSBzZW50IGZvciB0aGUgYWJvdmUuCj4gCj4gSSBhbSBjdXJpb3VzIGhvdyB0aGUgc29mdHdh
cmUgZXZvbHV0aW9uIHdpbGwgYmUgY29udGludWVkIGhlcmUuCj4gCgpHb29kIHRvIGtub3cuCgpD
aGVlcnMsCkphc2thcmFuLgoKPiBSZWdhcmRzLAo+IE1hcmt1cwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5
c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2Nv
Y2NpCg==
