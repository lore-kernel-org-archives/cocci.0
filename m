Return-Path: <SRS0=W5OG=D2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89079C433DF
	for <cocci@archiver.kernel.org>; Mon, 19 Oct 2020 13:48:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF20222BA
	for <cocci@archiver.kernel.org>; Mon, 19 Oct 2020 13:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+MOJIA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF20222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09JDlODm018737;
	Mon, 19 Oct 2020 15:47:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EAA8775B4;
	Mon, 19 Oct 2020 15:47:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6BF6D445E
 for <cocci@systeme.lip6.fr>; Mon, 19 Oct 2020 14:55:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09JCtadi004370
 for <cocci@systeme.lip6.fr>; Mon, 19 Oct 2020 14:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603112135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ticZMXdjFyuhy7AlqQJ6aW1BCbz8bmeqkMyCMuPVBrQ=;
 b=g+MOJIA4H1ahTv14ks8ZehSUdr7w3TQKF8+/oVOVzz9gakazCni0XFPnYsltVmiQoHvfpX
 p3S89hp8HcYFZOSvXazY31U/+SlnIyb2XSzAIFpT5USyDCdKYGafPeZ9Vkcdw+rPMKewUo
 6enafYwMXaqWKGkqOb4V9HSIWWhDxF8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50--F6wVSuBPcC8dqjZARvFGQ-1; Mon, 19 Oct 2020 08:55:34 -0400
X-MC-Unique: -F6wVSuBPcC8dqjZARvFGQ-1
Received: by mail-qv1-f69.google.com with SMTP id t13so5981214qvm.14
 for <cocci@systeme.lip6.fr>; Mon, 19 Oct 2020 05:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ticZMXdjFyuhy7AlqQJ6aW1BCbz8bmeqkMyCMuPVBrQ=;
 b=Y6WRb6GioqlcO2V8gFn2b7j0jxTrQvdtkqmHLrCo4hLvudWklxuhQ+gjJY/PH5x3zZ
 vEi0ZyXH6iRsOYQ3H4dyrKT6KoSRWlZcOB4oc8bTZ62yv77cLhckHNCMKRmgRXX2HBg5
 XAdFR0commb2X9SnRyW8b+H/mQ4f2Kwn2snuMs9zxf9YHqL4ITxHVju19E2ZjvboF5th
 Aw962AAjAbdYpF39Jqfd6r2Vc+R/PsVuXd/cJLsVna+kwmmGTopO2zlqvUYprpnXQx7O
 ZoK09ngROATTXzzk4//BQVc4tAG2C8jyMh438K/xGjxhvT90+S0c4vcO4FCMJU7cYs/a
 wYzg==
X-Gm-Message-State: AOAM533DDJOm5uBnryjis5ALEdtNjTsOndehw2PGS3zBbRQDJgb0U9uV
 aGCAMp7Z4jLYBcrOfeTxZAPGZm34oxVkPvbvCjAtsmoYG5w28cYM8TY4LfVI3Wk2cs9sXZg8BhM
 SVFq788XYm4QjDCY=
X-Received: by 2002:ac8:6ec7:: with SMTP id f7mr14275227qtv.45.1603112133309; 
 Mon, 19 Oct 2020 05:55:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxLA2eF0bNDpUfMI2wAfc8LZq4aaTUjKQgRbAsiAJUaZNudtOj8D0MCnF/brfSxzHb1cBOiA==
X-Received: by 2002:ac8:6ec7:: with SMTP id f7mr14275204qtv.45.1603112133039; 
 Mon, 19 Oct 2020 05:55:33 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id z69sm4136661qkb.7.2020.10.19.05.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 05:55:32 -0700 (PDT)
To: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20201017160928.12698-1-trix@redhat.com>
 <f530b7aeecbbf9654b4540cfa20023a4c2a11889.camel@perches.com>
 <alpine.DEB.2.22.394.2010172016370.9440@hadrien>
 <dfe24da760056e31d90ff639b47c494263b5f4a7.camel@perches.com>
 <a15ada1f-9bad-612e-e841-934bff088f38@redhat.com>
 <49c87dede8d06ba90ecb3200b2a773860d61a3c8.camel@perches.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <c02aed9b-ab6c-1054-1e8a-4006f2a75f94@redhat.com>
Date: Mon, 19 Oct 2020 05:55:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <49c87dede8d06ba90ecb3200b2a773860d61a3c8.camel@perches.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 19 Oct 2020 15:47:24 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 19 Oct 2020 14:55:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 19 Oct 2020 15:47:22 +0200
Cc: linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] checkpatch: Allow --fix removal of unnecessary
 break statements
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

Ck9uIDEwLzE4LzIwIDE6MTkgUE0sIEpvZSBQZXJjaGVzIHdyb3RlOgo+IE9uIFN1biwgMjAyMC0x
MC0xOCBhdCAxMzowNyAtMDcwMCwgVG9tIFJpeCB3cm90ZToKPj4gSSBsaWtlIQo+IFtdCj4+IGNv
dWxkIGFkZCBhICd8YnJlYWsnIGhlcmUgdG8gY2F0Y2ggdGhlIGNvdXBsZQo+IFtdCj4+IGJyZWFr
Owo+Pgo+PiBicmVhazsKPiBVbmZvcnR1bmF0ZWx5LCBjaGVja3BhdGNoIGlzIHJlYWxseSBzdHVw
aWQgYW5kIGl0Cj4gd291bGRuJ3QgY2F0Y2ggdGhvc2UKPiBjYXNlcyBhcyB0aGVyZSBhcmUgYmxh
bmsgbGluZXMKPiBiZXR3ZWVuIHRoZSBleGlzdGluZyBjb25zZWN1dGl2ZSBicmVhawo+IHN0YXRl
bWVudHMuCj4KPiBJdCB3b3VsZCBjYXRjaAo+Cj4gCWJyZWFrOwo+IAlicmVhazsKPgo+IGJ1dCB0
aGVyZSBhcmVuJ3QgYW55IG9mIHRob3NlIHNvIGl0IHNlZW1zIHVubGlrZWx5Cj4gdG8gYmUgYSB2
ZXJ5IHVzZWZ1bCBhZGRpdGlvbi4KClVudXN1YWwsIGJ1dCB0aGVyZSBhcmUgYSBjb3VwbGUgb2Yg
dGhlc2UuCgpIZXJlJ3Mgb25lIGZyb20gbXkgcmZjIGRpZmYKCmRpZmYgLS1naXQgYS9zb3VuZC9z
b2MvY29kZWNzL3djZC1jbHNoLXYyLmMgYi9zb3VuZC9zb2MvY29kZWNzL3djZC1jbHNoLXYyLmMK
aW5kZXggMWJlODIxMTNjNTlhLi44MTdkODI1OTc1OGMgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9j
b2RlY3Mvd2NkLWNsc2gtdjIuYworKysgYi9zb3VuZC9zb2MvY29kZWNzL3djZC1jbHNoLXYyLmMK
QEAgLTQ3OCwxMSArNDc4LDEwIEBAIHN0YXRpYyBpbnQgX3djZF9jbHNoX2N0cmxfc2V0X3N0YXRl
KHN0cnVjdCB3Y2RfY2xzaF9jdHJsICpjdHJsLCBpbnQgcmVxX3N0YXRlLArCoMKgwqDCoCDCoMKg
wqAgd2NkX2Nsc2hfc3RhdGVfaHBoX2woY3RybCwgcmVxX3N0YXRlLCBpc19lbmFibGUsIG1vZGUp
OwrCoMKgwqDCoCDCoMKgwqAgYnJlYWs7CsKgwqDCoMKgIGNhc2UgV0NEX0NMU0hfU1RBVEVfSFBI
UjoKwqDCoMKgwqAgwqDCoMKgIHdjZF9jbHNoX3N0YXRlX2hwaF9yKGN0cmwsIHJlcV9zdGF0ZSwg
aXNfZW5hYmxlLCBtb2RlKTsKwqDCoMKgwqAgwqDCoMKgIGJyZWFrOwotwqDCoMKgIMKgwqDCoCBi
cmVhazsKwqDCoMKgwqAgY2FzZSBXQ0RfQ0xTSF9TVEFURV9MTzoKwqDCoMKgwqAgwqDCoMKgIHdj
ZF9jbHNoX3N0YXRlX2xvKGN0cmwsIHJlcV9zdGF0ZSwgaXNfZW5hYmxlLCBtb2RlKTsKwqDCoMKg
wqAgwqDCoMKgIGJyZWFrOwrCoMKgwqDCoCBkZWZhdWx0OgrCoMKgwqDCoCDCoMKgwqAgYnJlYWs7
CgpUb20KCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1l
LmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
