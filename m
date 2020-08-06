Return-Path: <SRS0=Kdcw=BQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E24C433E1
	for <cocci@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0814221E3
	for <cocci@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HL+bKaZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0814221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 076K949n005347;
	Thu, 6 Aug 2020 22:09:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D2FA276BF;
	Thu,  6 Aug 2020 22:09:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AFC33428B
 for <cocci@systeme.lip6.fr>; Thu,  6 Aug 2020 21:48:32 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:241])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 076JmURW000896
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 6 Aug 2020 21:48:31 +0200 (CEST)
Received: by mail-oi1-x241.google.com with SMTP id l204so15226191oib.3
 for <cocci@systeme.lip6.fr>; Thu, 06 Aug 2020 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4gQ75ruoSOCI+/ZqdsWxnLpvjWBjTukbDtC3AHZ8rTg=;
 b=HL+bKaZ+qVQ7F1TeHaJfo1vBm5yKb7vlf1+/xmjhLCt38vp7sIy8YHm32APcZNMHRZ
 Pk8848zPgRvrItpKjsDLfhlQ1I97F12VaL4ybd3Bg/rAwX6FnS3hld18jW4QXK7VUVmH
 CrDQcIQQ0hIDhPm5bXwQw+0rHRPZ7idk5LuXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4gQ75ruoSOCI+/ZqdsWxnLpvjWBjTukbDtC3AHZ8rTg=;
 b=SaeowQiQ44a+jO927q4JBBkE97JoulLgtk3mzO3G+WrtAK27JCXgVoGf16A31QK187
 CBipFXKseYG7vV0Zoe53NE9d7MPAf+8gjNXigty2Caso60Vtq12flxJMxcGubvN/GF8+
 YUp+efiwp+KQGK7Wpu3AGoujfQxjM9I8N47AQPUYU1a4g6jrSlJV25F2eeXCood+9l5f
 qJP9P3lSSlUDYttPtTc+4nytJsBNyuova053MyXr/o2ZMBSaHHnqz5Vw3e9pd23HItW2
 vbvJWLsx2irYl/SwYcSCUknfGNWkTrwS7oppZpqMQVoFojHby3C3MdCntG2L4EoVXHoc
 EhhA==
X-Gm-Message-State: AOAM530zbLSPtbMBwp4eVasBkDgorZOlu2M1nyaOxOCFpFnAT8AWBj1a
 X98980wOxWm+tFFc5ahjLANzwQ==
X-Google-Smtp-Source: ABdhPJw21Tec6i06lnsFmCKGZ+xmQIMhPfqdJ0RZ3DidumVLHLn1K9s9oALDXkGudqsb5SkM+Xo+0g==
X-Received: by 2002:aca:b106:: with SMTP id a6mr8160402oif.46.1596743308916;
 Thu, 06 Aug 2020 12:48:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id 63sm1190607otp.39.2020.08.06.12.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 12:48:27 -0700 (PDT)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200604164145.173925-1-maennich@google.com>
 <alpine.DEB.2.21.2006042130080.2577@hadrien>
 <bf757b9d-6a67-598b-ed6e-7ee24464abfa@linuxfoundation.org>
 <20200622080345.GD260206@google.com>
 <0eda607e-4083-46d2-acb8-63cfa2697a71@linuxfoundation.org>
 <20200622150605.GA3828014@kroah.com>
 <f09e32dc-8f17-d09a-b2e4-fb4c0699838e@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <baf80622-0860-e640-eb14-dffc02597ed3@linuxfoundation.org>
Date: Thu, 6 Aug 2020 13:48:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f09e32dc-8f17-d09a-b2e4-fb4c0699838e@linuxfoundation.org>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Aug 2020 22:09:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 06 Aug 2020 21:48:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Thu, 06 Aug 2020 22:09:03 +0200
Cc: Matthias Maennich <maennich@google.com>, skhan@linuxfoundation.org,
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

T24gNi8yMi8yMCAxMDoxNCBBTSwgU2h1YWggS2hhbiB3cm90ZToKPiBPbiA2LzIyLzIwIDk6MDYg
QU0sIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToKPj4gT24gTW9uLCBKdW4gMjIsIDIwMjAgYXQg
MDg6NDY6MThBTSAtMDYwMCwgU2h1YWggS2hhbiB3cm90ZToKPj4+IE9uIDYvMjIvMjAgMjowMyBB
TSwgTWF0dGhpYXMgTWFlbm5pY2ggd3JvdGU6Cj4+Pj4gT24gVGh1LCBKdW4gMDQsIDIwMjAgYXQg
MDI6Mzk6MThQTSAtMDYwMCwgU2h1YWggS2hhbiB3cm90ZToKPj4+Pj4gT24gNi80LzIwIDE6MzEg
UE0sIEp1bGlhIExhd2FsbCB3cm90ZToKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gT24gVGh1LCA0IEp1
biAyMDIwLCBNYXR0aGlhcyBNYWVubmljaCB3cm90ZToKPj4+Pj4+Cj4+Pj4+Pj4gV2hlbiBydW5u
aW5nIGBtYWtlIGNvY2NpY2hlY2tgIGluIHJlcG9ydCBtb2RlIHVzaW5nIHRoZQo+Pj4+Pj4+IGFk
ZF9uYW1lc3BhY2UuY29jY2kgZmlsZSwgaXQgd2lsbCBmYWlsIGZvciBmaWxlcyB0aGF0IGNvbnRh
aW4KPj4+Pj4+PiBNT0RVTEVfTElDRU5TRS4gVGhvc2UgbWF0Y2ggdGhlIHJlcGxhY2VtZW50IHBy
ZWNvbmRpdGlvbiwgYnV0IHNwYXRjaAo+Pj4+Pj4+IGVycm9ycyBvdXQgYXMgdmlydHVhbC5ucyBp
cyBub3Qgc2V0Lgo+Pj4+Pj4+Cj4+Pj4+Pj4gSW4gb3JkZXIgdG8gZml4IHRoYXQsIGFkZCB0aGUg
dmlydHVhbCBydWxlIG5zZGVwcyBhbmQgb25seQo+Pj4+Pj4+IGRvIHNlYXJjaCBhbmQKPj4+Pj4+
PiByZXBsYWNlIGlmIHRoYXQgcnVsZSBoYXMgYmVlbiBleHBsaWNpdGx5IHJlcXVlc3RlZC4KPj4+
Pj4+Pgo+Pj4+Pj4+IEluIG9yZGVyIHRvIG1ha2Ugc3BhdGNoIGhhcHB5IGluIHJlcG9ydCBtb2Rl
LCB3ZSBhbHNvIG5lZWQgYQo+Pj4+Pj4+IGR1bW15IHJ1bGUsCj4+Pj4+Pj4gYXMgb3RoZXJ3aXNl
IGl0IGVycm9ycyBvdXQgd2l0aCAiTm8gcnVsZXMgYXBwbHkiLiBVc2luZyBhIAo+Pj4+Pj4+IHNj
cmlwdDpweXRob24KPj4+Pj4+PiBydWxlIGFwcGVhcnMgdW5yZWxhdGVkIGFuZCBvZGQsIGJ1dCB0
aGlzIGlzIHRoZSBzaG9ydGVzdCBJCj4+Pj4+Pj4gY291bGQgY29tZSB1cAo+Pj4+Pj4+IHdpdGgu
Cj4+Pj4+Pj4KPj4+Pj4+PiBBZGp1c3Qgc2NyaXB0cy9uc2RlcHMgYWNjb3JkaW5nbHkgdG8gc2V0
IHRoZSBuc2RlcHMgcnVsZQo+Pj4+Pj4+IHdoZW4gcnVuIHRyb3VnaAo+Pj4+Pj4+IGBtYWtlIG5z
ZGVwc2AuCj4+Pj4+Pj4KPj4+Pj4+PiBTdWdnZXN0ZWQtYnk6IEp1bGlhIExhd2FsbCA8anVsaWEu
bGF3YWxsQGlucmlhLmZyPgo+Pj4+Pj4+IEZpeGVzOiBjN2M0ZTI5ZmI1YTQgKCJzY3JpcHRzOiBh
ZGRfbmFtZXNwYWNlOiBGaXggY29jY2ljaGVjayAKPj4+Pj4+PiBmYWlsZWQiKQo+Pj4+Pj4+IENj
OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+Cj4+Pj4+Pj4gQ2M6IGpleXVAa2Vy
bmVsLm9yZwo+Pj4+Pj4+IENjOiBjb2NjaUBzeXN0ZW1lLmxpcDYuZnIKPj4+Pj4+PiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZwo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1hdHRoaWFzIE1hZW5u
aWNoIDxtYWVubmljaEBnb29nbGUuY29tPgo+Pj4+Pj4KPj4+Pj4+IEFja2VkLWJ5OiBKdWxpYSBM
YXdhbGwgPGp1bGlhLmxhd2FsbEBpbnJpYS5mcj4KPj4+Pj4+Cj4+Pj4+PiBTaHVhaCByZXBvcnRl
ZCB0aGUgcHJvYmxlbSB0byBtZSwgc28geW91IGNvdWxkIGFkZAo+Pj4+Pj4KPj4+Pj4+IFJlcG9y
dGVkLWJ5OiBTaHVhaCBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPgo+Pj4+Pj4KPj4+
Pj4KPj4+Pj4gVmVyeSBjb29sLiBObyBlcnJvcnMgd2l0aCB0aGlzIHBhdGNoLiBUaGFua3MgZm9y
IGZpeGluZyBpdAo+Pj4+PiBxdWlja2x5Lgo+Pj4+Cj4+Pj4gSSBhbSBoYXBweSBJIGNvdWxkIGZp
eCB0aGF0IGFuZCB0aGFua3MgZm9yIGNvbmZpcm1pbmcuIEkgYXNzdW1lIHlvdXIKPj4+PiBUZXN0
ZWQtYnkgY291bGQgYmUgYWRkZWQ/Cj4+Pgo+Pj4gWWVzCj4+Pgo+Pj4gVGVzdGVkLWJ5OiBTaHVh
aCBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPgo+Pj4+Cj4+Pj4gSXMgc29tZWJvZHkg
d2lsbGluZyB0byB0YWtlIHRoaXMgcGF0Y2ggdGhyb3VnaCB0aGVpciB0cmVlPwo+Pj4+Cj4+Pgo+
Pj4gTXkgZ3Vlc3MgaXMgdGhhdCB0aGVzZSBnbyB0aHJvdWdoIGtidWlsZCBnaXQ/Pwo+Pgo+PiBJ
ZiB5b3Ugd2FudCB0byB0YWtlIHRoaXMsIHRoYXQncyBmaW5lIHdpdGggbWUuwqAgQnV0IGFzIEkg
aGFkIHRoZQo+PiBvcmlnaW5hbCBmaWxlIGNvbWUgdGhyb3VnaCBteSB0cmVlLCBJIGNhbiB0YWtl
IGl0IHRvby7CoCBJdCdzIHVwIHRvIHlvdSwKPj4gZWl0aGVyIGlzIG9rIHdpdGggbWUuCj4+Cj4g
Cj4gR3JlYXQuIFBsZWFzZSB0YWtlIHRoaXMgdGhyb3VnaCB5b3VyIHRyZWUuCj4gCgpHcmVnISBM
b29rcyBsaWtlIHRoaXMgb25lIGRpZG4ndCBtYWtlIGl0IGluLiBDYW4geW91IHBpY2sgdGhpcyB1
cD8KCnRoYW5rcywKLS0gU2h1YWgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0
cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
