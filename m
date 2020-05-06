Return-Path: <SRS0=rX/m=6U=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2308CC28CBC
	for <cocci@archiver.kernel.org>; Wed,  6 May 2020 12:01:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C84206DD
	for <cocci@archiver.kernel.org>; Wed,  6 May 2020 12:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cilium-io.20150623.gappssmtp.com header.i=@cilium-io.20150623.gappssmtp.com header.b="FcLvBqu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C84206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cilium.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 046C1Kxr020519;
	Wed, 6 May 2020 14:01:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 097CF775A;
	Wed,  6 May 2020 14:01:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1470B7559
 for <cocci@systeme.lip6.fr>; Wed,  6 May 2020 14:01:18 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:42e])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 046C1DV1019173
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 6 May 2020 14:01:13 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id h9so1895638wrt.0
 for <cocci@systeme.lip6.fr>; Wed, 06 May 2020 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cilium-io.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=SM/DjLts2NGU+Kystdi5gESGkqH5v/cSh354jRHQ17w=;
 b=FcLvBqu04eAphlp5pvcZCIRg1djiRrZXR06FjPz8ImMkb3tatmHqpvymqKwxM+VLa5
 ev/cr3K6o88ttoi6rNPuYlDHSbR4cXhW1X7M5rsJADtC6ALErqhk4aO74cMk9ZhzRxBP
 YS2WVVrQuwSyN/x8ejmzzaz1kX4rw1d9cMnujzCmm4pJ9F7099ZG+/DqtTbTSNqSjDnm
 BfOQzqTydE80/FM/sKzqBB6sAdWCLf6okV5wLGKRDGQCkNtQ7FQNFllM0BdMhSH/4t8b
 7tBEJsECl9U3DjW0+Nbdoi5eWUhYsKghFdJ3RhaJ8AO4Bafx7ncy07BtAj/3ltN2nIdg
 5pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=SM/DjLts2NGU+Kystdi5gESGkqH5v/cSh354jRHQ17w=;
 b=ijo5zJNodyoZ8p9awKQBAc5oqFEUS/2i7WlPVVdYfZraa351P8FzD06tNVXcsf0MFE
 B/A38fX1nFm+3cY48x53gCEE3BvtUFtJXJwu3avTgnjuIMt+STEymRDFMaTCbLtOEV3v
 x9UFmDFxgpaeipftTOW97LgS8C0oLDbLTwQR0OwKvk5ATPRBlDtWQSmCjwydjM1sxPDW
 HeWcoQ7Y5+xEnQXtFR7k+o04jrpaI26bVpzbYu/bQxjtssCy1edgevBaSg5rejfur+Zj
 /0vpzoFkHcpRV+lWDdqikgmurxCaFjUe++KED6zn/Gw54jPK/x7MPA4USY7nT1H8HL3a
 lfpg==
X-Gm-Message-State: AGi0PuafH0xtSaEUMXfz1AsndCxm8lGgdLJqx/eKBv30Got2VcEB4/h9
 mOaln9NlBiOGoqU4d1CD+riEreFA6T/M
X-Google-Smtp-Source: APiQypIs2bjHlEylq+bSTxAomfo7XQnHnq61aheThkkDCqp0CjvTMYIc4TdM4NAAlRFaYg2WnIUF3w==
X-Received: by 2002:a5d:6a92:: with SMTP id s18mr8546178wru.50.1588766473005; 
 Wed, 06 May 2020 05:01:13 -0700 (PDT)
Received: from Mem ([145.136.49.157])
 by smtp.gmail.com with ESMTPSA id h16sm2629888wrw.36.2020.05.06.05.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:01:12 -0700 (PDT)
Date: Wed, 6 May 2020 14:01:09 +0200
From: Paul Chaignon <paul@cilium.io>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200506120107.GA3242@Mem>
References: <b6c5ae24-f24c-a0d5-796a-8e9cbd17a7d6@web.de>
 <20200429190733.GA5695@Mem>
 <72cb854f-912b-4c34-a526-be7b584e8fd8@web.de>
 <20200505095911.GA7247@Mem>
 <78195706-c910-5c3b-5887-da94c244b61c@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <78195706-c910-5c3b-5887-da94c244b61c@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 06 May 2020 14:01:20 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 06 May 2020 14:01:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Exit with non-zero status
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

T24gVHVlLCBNYXkgMDUsIDIwMjAgYXQgMDE6MDg6MjZQTSArMDIwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6Cj4gPiBGb3IgdGhlIHJlY29yZCwgSSBlbmFibGVkIENvY2NpbmVsbGUgaW4gb3VyIENJ
IChHaXRIdWIgQWN0aW9ucykKPiA+IHllc3RlcmRheSBhbmQgd29ya2VkIGFyb3VuZCB0aGF0IGlz
c3VlIHdpdGggdGhlIGZvbGxvd2luZyBzY3JpcHQ6Cj4gPgo+ID4gICBtYWtlIC1DIGJwZi8gY29j
Y2ljaGVjayB8IHRlZSAvdG1wL3N0ZG91dAo+ID4gICBleGl0ICQoZ3JlcCAtYyAiW3ByZWZpeCBv
ZiB3YXJuaW5nIG1lc3NhZ2VzXSIgL3RtcC9zdGRvdXQpCj4gCj4gSSBwcm9wb3NlIHRvIGltcHJv
dmUgdGhlIGRhdGEgcHJvY2Vzc2luZyBhcHByb2FjaCBhY2NvcmRpbmcgdG8geW91ciByZWNlbnQK
PiBjb21taXQg4oCcY29jY2luZWxsZTogUnVuIGNvY2NpY2hlY2sgd2l0aCBHaXRIdWIgQWN0aW9u
c+KAnS4KPiBodHRwczovL2dpdGh1Yi5jb20vY2lsaXVtL2NpbGl1bS9jb21taXQvMzVkMjk5YTRl
ZTk5NmRjMmY0YmVlYzNjODhiNzdkZWRiZDAwYjJiYQo+IAo+IAo+ID4gUGxlYXNlIHNlZSBhYm92
ZSBzY3JpcHQuIEkgY3VycmVudGx5IGV4aXQgd2l0aCBudW1iZXIgb2YgZmFpbHVyZXMsCj4gPiBi
dXQgaGF2aW5nIGp1c3QgMCAoc3VjY2VzcykgYW5kIDEgKGZhaWwpIHN0YXR1c2VzIHdvdWxkIGJl
IGVub3VnaC4KPiAKPiBJIHN1Z2dlc3QgdG8gc3RpY2sgdG8gYSBtb3JlIHRyYWRpdGlvbmFsIGhh
bmRsaW5nIG9mIHRoZSBwcm9ncmFtCj4gZXhpdCBzdGF0dXMgYmVjYXVzZSBvZiBkZXZlbG9wbWVu
dCBjb25jZXJucyBhcm91bmQgc29mdHdhcmUgcG9ydGFiaWxpdHkuCj4gCj4gCj4gPj4gV2lsbCB0
aGUgdXNhZ2Ugb2YgYWRkaXRpb25hbCBkYXRhIHN0cnVjdHVyZXMgYmVjb21lIG1vcmUgaW50ZXJl
c3Rpbmc/Cj4gPgo+ID4gTm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBxdWVzdGlvbi4gV2hhdCBk
YXRhIHN0cnVjdHVyZXM/Cj4gCj4gRXhhbXBsZXM6Cj4gCj4gKiBPcmRpbmFyeSB0ZXh0IGZpbGVz
IGZvciB0aGUgc3RhbmRhcmQgb3V0cHV0IGFuZCBlcnJvciBjaGFubmVscy4KPiAKPiAqIFdvdWxk
IHlvdSBsaWtlIHRvIHN0b3JlIGFueSBzZWFyY2ggcmVzdWx0cyBpbnRvIGRhdGFiYXNlIHRhYmxl
cz8KPiAKPiAqIEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gcGVyZm9ybSBkYXRhIHRyYW5zbWlz
c2lvbnMgYnkgaGlnaGVyIGxldmVsCj4gICBwcm9ncmFtbWluZyBpbnRlcmZhY2VzIGZvciBkaXN0
cmlidXRlZCBwcm9jZXNzZXM/Cj4gCj4gCj4gV2hpY2ggc29mdHdhcmUgZXh0ZW5zaW9ucyBjYW4g
YmVjb21lIG1vcmUgaW50ZXJlc3RpbmcgYWxzbyBmb3IKPiBhcHBsaWNhdGlvbnMgYXJvdW5kIHlv
dXIgY29udGludW91cyBpbnRlZ3JhdGlvbiBzeXN0ZW0/CgpJIHNlZS4gV2UncmUgbm90IHBsYW5u
aW5nIHRvIHVzZSBhbnkgb2YgdGhlIGFib3ZlIGluIHRoZSBtZWRpdW0gdGVybS4KV2UncmUgb25s
eSBwbGFubmluZyB0byBhZGQgQ29jY2luZWxsZSBydWxlcyBpbiB0aGUgZnV0dXJlLiBJZiB3ZSBu
ZWVkIG1vcmUKY29tcGxleCBwb3N0LXByb2Nlc3NpbmcsIHdlJ2xsIGxpa2VseSBpbXBsZW1lbnQg
aXQgaW4gR2l0SHViIEFjdGlvbnMgYW5kCm5vdCBkaXJlY3RseSBpbiBDb2NjaW5lbGxlIHNjcmlw
dHMuCgpQYXVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1l
LmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
