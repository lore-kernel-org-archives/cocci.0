Return-Path: <SRS0=Kdcw=BQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73D2C433DF
	for <cocci@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307DE221E2
	for <cocci@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AzQNBu5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307DE221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 076K95Fp005581;
	Thu, 6 Aug 2020 22:09:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 52695781D;
	Thu,  6 Aug 2020 22:09:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 94341428B
 for <cocci@systeme.lip6.fr>; Thu,  6 Aug 2020 22:02:51 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:143])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 076K2nE5023361
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 6 Aug 2020 22:02:50 +0200 (CEST)
Received: by mail-il1-x143.google.com with SMTP id y18so33067407ilp.10
 for <cocci@systeme.lip6.fr>; Thu, 06 Aug 2020 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GcmxaFAbN9FMOZvy1ws6uE/hP82637tGxfEk48uh7HY=;
 b=AzQNBu5LtmU+t3c6vUOJRUCvqiRtHE7oZ2mjfQNHOTkSRfBPMdGUrkKbxZBQI1jIU5
 LKinN/3WztDZsYn5pMZ1v3MxwbqbolF0H+dYM5UpKIhdOHXv1r41z2XVOl7VY3QHH1tL
 7bb+Ssl+fBKgZxUvcWKBbr/I4BFlGWg/jvilI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GcmxaFAbN9FMOZvy1ws6uE/hP82637tGxfEk48uh7HY=;
 b=Ay+F7k83ByJay0mRf3A5bDH2YpYBYf03nBy66jyC5zMYWJ6lLKUh6JIV8bi2+2nmNV
 HA39yO3VYMD/1vPoCTXU5STIri7W1eDYMH63zmqSpBhCPP8q590pRaA6DOZlmZb6Wg6Z
 6Oj1a0+IY89s6oxAzrUFkwO4NuCUBqRdb0e3Rq2koenq1QEsgBk8kctjoWMi7q/mC0fO
 Q3l3Ok/UUfR4fdPwfjaLLTyZehs4vHJc2auLxwnExcPsVP5i2bN9f2UXMUA9QtuPyK4P
 Qf3XMicgWui5dwi9W3yNF2pIcki4w9Lo4xF2uC1aQfIruKgODz8Ui7E4+YO5yW8hTv5o
 cUeA==
X-Gm-Message-State: AOAM531cdvU3w5tWjLBqxfyYNVvpaQFV6RxPmBpLPZQZIKOPDlqSOcIw
 n1UCkGbSoNyj72bgQD3cm90G2Q==
X-Google-Smtp-Source: ABdhPJyVWpq4Hy6ek99rwtJSeq/2b1JB3+ZMX421UkOI3KmSXS+Rx1lmNwqnEWR8vOC170Yh+F6Wkw==
X-Received: by 2002:a05:6e02:1213:: with SMTP id
 a19mr658521ilq.129.1596744169530; 
 Thu, 06 Aug 2020 13:02:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id l5sm5241282ios.3.2020.08.06.13.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 13:02:49 -0700 (PDT)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200604164145.173925-1-maennich@google.com>
 <alpine.DEB.2.21.2006042130080.2577@hadrien>
 <bf757b9d-6a67-598b-ed6e-7ee24464abfa@linuxfoundation.org>
 <20200622080345.GD260206@google.com>
 <0eda607e-4083-46d2-acb8-63cfa2697a71@linuxfoundation.org>
 <20200622150605.GA3828014@kroah.com>
 <f09e32dc-8f17-d09a-b2e4-fb4c0699838e@linuxfoundation.org>
 <baf80622-0860-e640-eb14-dffc02597ed3@linuxfoundation.org>
 <20200806195704.GA2950037@kroah.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8417ccd3-9964-3b8e-65e5-6140be0b28fd@linuxfoundation.org>
Date: Thu, 6 Aug 2020 14:02:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806195704.GA2950037@kroah.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Aug 2020 22:09:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 06 Aug 2020 22:02:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Thu, 06 Aug 2020 22:09:03 +0200
Cc: Matthias Maennich <maennich@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jeyu@kernel.org, kernel-team@android.com,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: add dummy report mode to
	add_namespace.cocci
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

T24gOC82LzIwIDE6NTcgUE0sIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToKPiBPbiBUaHUsIEF1
ZyAwNiwgMjAyMCBhdCAwMTo0ODoyNlBNIC0wNjAwLCBTaHVhaCBLaGFuIHdyb3RlOgo+PiBPbiA2
LzIyLzIwIDEwOjE0IEFNLCBTaHVhaCBLaGFuIHdyb3RlOgo+Pj4gT24gNi8yMi8yMCA5OjA2IEFN
LCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4+Pj4gT24gTW9uLCBKdW4gMjIsIDIwMjAgYXQg
MDg6NDY6MThBTSAtMDYwMCwgU2h1YWggS2hhbiB3cm90ZToKPj4+Pj4gT24gNi8yMi8yMCAyOjAz
IEFNLCBNYXR0aGlhcyBNYWVubmljaCB3cm90ZToKPj4+Pj4+IE9uIFRodSwgSnVuIDA0LCAyMDIw
IGF0IDAyOjM5OjE4UE0gLTA2MDAsIFNodWFoIEtoYW4gd3JvdGU6Cj4+Pj4+Pj4gT24gNi80LzIw
IDE6MzEgUE0sIEp1bGlhIExhd2FsbCB3cm90ZToKPj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4g
T24gVGh1LCA0IEp1biAyMDIwLCBNYXR0aGlhcyBNYWVubmljaCB3cm90ZToKPj4+Pj4+Pj4KPj4+
Pj4+Pj4+IFdoZW4gcnVubmluZyBgbWFrZSBjb2NjaWNoZWNrYCBpbiByZXBvcnQgbW9kZSB1c2lu
ZyB0aGUKPj4+Pj4+Pj4+IGFkZF9uYW1lc3BhY2UuY29jY2kgZmlsZSwgaXQgd2lsbCBmYWlsIGZv
ciBmaWxlcyB0aGF0IGNvbnRhaW4KPj4+Pj4+Pj4+IE1PRFVMRV9MSUNFTlNFLiBUaG9zZSBtYXRj
aCB0aGUgcmVwbGFjZW1lbnQgcHJlY29uZGl0aW9uLCBidXQgc3BhdGNoCj4+Pj4+Pj4+PiBlcnJv
cnMgb3V0IGFzIHZpcnR1YWwubnMgaXMgbm90IHNldC4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBJbiBv
cmRlciB0byBmaXggdGhhdCwgYWRkIHRoZSB2aXJ0dWFsIHJ1bGUgbnNkZXBzIGFuZCBvbmx5Cj4+
Pj4+Pj4+PiBkbyBzZWFyY2ggYW5kCj4+Pj4+Pj4+PiByZXBsYWNlIGlmIHRoYXQgcnVsZSBoYXMg
YmVlbiBleHBsaWNpdGx5IHJlcXVlc3RlZC4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBJbiBvcmRlciB0
byBtYWtlIHNwYXRjaCBoYXBweSBpbiByZXBvcnQgbW9kZSwgd2UgYWxzbyBuZWVkIGEKPj4+Pj4+
Pj4+IGR1bW15IHJ1bGUsCj4+Pj4+Pj4+PiBhcyBvdGhlcndpc2UgaXQgZXJyb3JzIG91dCB3aXRo
ICJObyBydWxlcwo+Pj4+Pj4+Pj4gYXBwbHkiLiBVc2luZyBhIHNjcmlwdDpweXRob24KPj4+Pj4+
Pj4+IHJ1bGUgYXBwZWFycyB1bnJlbGF0ZWQgYW5kIG9kZCwgYnV0IHRoaXMgaXMgdGhlIHNob3J0
ZXN0IEkKPj4+Pj4+Pj4+IGNvdWxkIGNvbWUgdXAKPj4+Pj4+Pj4+IHdpdGguCj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4gQWRqdXN0IHNjcmlwdHMvbnNkZXBzIGFjY29yZGluZ2x5IHRvIHNldCB0aGUgbnNk
ZXBzIHJ1bGUKPj4+Pj4+Pj4+IHdoZW4gcnVuIHRyb3VnaAo+Pj4+Pj4+Pj4gYG1ha2UgbnNkZXBz
YC4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBTdWdnZXN0ZWQtYnk6IEp1bGlhIExhd2FsbCA8anVsaWEu
bGF3YWxsQGlucmlhLmZyPgo+Pj4+Pj4+Pj4gRml4ZXM6IGM3YzRlMjlmYjVhNCAoInNjcmlwdHM6
IGFkZF9uYW1lc3BhY2U6Cj4+Pj4+Pj4+PiBGaXggY29jY2ljaGVjayBmYWlsZWQiKQo+Pj4+Pj4+
Pj4gQ2M6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4KPj4+Pj4+Pj4+IENjOiBq
ZXl1QGtlcm5lbC5vcmcKPj4+Pj4+Pj4+IENjOiBjb2NjaUBzeXN0ZW1lLmxpcDYuZnIKPj4+Pj4+
Pj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBN
YXR0aGlhcyBNYWVubmljaCA8bWFlbm5pY2hAZ29vZ2xlLmNvbT4KPj4+Pj4+Pj4KPj4+Pj4+Pj4g
QWNrZWQtYnk6IEp1bGlhIExhd2FsbCA8anVsaWEubGF3YWxsQGlucmlhLmZyPgo+Pj4+Pj4+Pgo+
Pj4+Pj4+PiBTaHVhaCByZXBvcnRlZCB0aGUgcHJvYmxlbSB0byBtZSwgc28geW91IGNvdWxkIGFk
ZAo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBSZXBvcnRlZC1ieTogU2h1YWggS2hhbiA8c2toYW5AbGludXhm
b3VuZGF0aW9uLm9yZz4KPj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IFZlcnkgY29vbC4gTm8gZXJy
b3JzIHdpdGggdGhpcyBwYXRjaC4gVGhhbmtzIGZvciBmaXhpbmcgaXQKPj4+Pj4+PiBxdWlja2x5
Lgo+Pj4+Pj4KPj4+Pj4+IEkgYW0gaGFwcHkgSSBjb3VsZCBmaXggdGhhdCBhbmQgdGhhbmtzIGZv
ciBjb25maXJtaW5nLiBJIGFzc3VtZSB5b3VyCj4+Pj4+PiBUZXN0ZWQtYnkgY291bGQgYmUgYWRk
ZWQ/Cj4+Pj4+Cj4+Pj4+IFllcwo+Pj4+Pgo+Pj4+PiBUZXN0ZWQtYnk6IFNodWFoIEtoYW4gPHNr
aGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+Cj4+Pj4+Pgo+Pj4+Pj4gSXMgc29tZWJvZHkgd2lsbGlu
ZyB0byB0YWtlIHRoaXMgcGF0Y2ggdGhyb3VnaCB0aGVpciB0cmVlPwo+Pj4+Pj4KPj4+Pj4KPj4+
Pj4gTXkgZ3Vlc3MgaXMgdGhhdCB0aGVzZSBnbyB0aHJvdWdoIGtidWlsZCBnaXQ/Pwo+Pj4+Cj4+
Pj4gSWYgeW91IHdhbnQgdG8gdGFrZSB0aGlzLCB0aGF0J3MgZmluZSB3aXRoIG1lLsKgIEJ1dCBh
cyBJIGhhZCB0aGUKPj4+PiBvcmlnaW5hbCBmaWxlIGNvbWUgdGhyb3VnaCBteSB0cmVlLCBJIGNh
biB0YWtlIGl0IHRvby7CoCBJdCdzIHVwIHRvIHlvdSwKPj4+PiBlaXRoZXIgaXMgb2sgd2l0aCBt
ZS4KPj4+Pgo+Pj4KPj4+IEdyZWF0LiBQbGVhc2UgdGFrZSB0aGlzIHRocm91Z2ggeW91ciB0cmVl
Lgo+Pj4KPj4KPj4gR3JlZyEgTG9va3MgbGlrZSB0aGlzIG9uZSBkaWRuJ3QgbWFrZSBpdCBpbi4g
Q2FuIHlvdSBwaWNrIHRoaXMgdXA/Cj4gCj4gSSB0aGluayB0aGlzIGlzIDU1Yzc1NDk4MTllNCAo
InNjcmlwdHM6IGFkZCBkdW1teSByZXBvcnQgbW9kZSB0bwo+IGFkZF9uYW1lc3BhY2UuY29jY2ki
KSBpbiBMaW51cydzIHRyZWUgcmlnaHQgbm93LCByaWdodD8KPiAKClllcy4gSXQgaXMgaW4gTGlu
dXggNS45LiBJIHdhcyBsb29raW5nIGluIHRoZSB3cm9uZyBwbGFjZSBvbgpMaW51eCA1LjguIDoo
CgoKdGhhbmtzLAotLSBTaHVhaAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRw
czovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
