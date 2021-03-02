Return-Path: <SRS0=Rern=IA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635E1C433E0
	for <cocci@archiver.kernel.org>; Tue,  2 Mar 2021 11:43:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E8664EE8
	for <cocci@archiver.kernel.org>; Tue,  2 Mar 2021 11:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E8664EE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 122BhVsF019524;
	Tue, 2 Mar 2021 12:43:31 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E4FFA77CC;
	Tue,  2 Mar 2021 12:43:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 57A7A5DC3
 for <cocci@systeme.lip6.fr>; Tue,  2 Mar 2021 12:43:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 122BhS7c012379
 for <cocci@systeme.lip6.fr>; Tue, 2 Mar 2021 12:43:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614685408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWaPcBxKAs1BsMkeSmYHfbE6ueCCwzmEN1p1ofIATS0=;
 b=OY2zy0c3agDM7glKwldOSPM8csxKzlmlcP7qhypIQvF4CZ/0/Wjg3c39qwAVrRvzOP+wVF
 9LmwAf5gPiT0I6aISvl0qsORw3oiNdBW4tTHGIjZcV1bs3PMVQKgcaO4xp1BAK1l9bmM5d
 KHO2nBMbakMgW8UMiOsZjV4uNt64sqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-llhTE-AUNtu56ze_mFc4sA-1; Tue, 02 Mar 2021 06:43:24 -0500
X-MC-Unique: llhTE-AUNtu56ze_mFc4sA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E14E80196E;
 Tue,  2 Mar 2021 11:43:23 +0000 (UTC)
Received: from localhost (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1611119C46;
 Tue,  2 Mar 2021 11:43:22 +0000 (UTC)
Date: Tue, 2 Mar 2021 11:43:22 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20210302114322.GB1818@redhat.com>
References: <alpine.DEB.2.22.394.2102270905410.2926@hadrien>
 <b40328ba-fa6d-972a-3b8e-db5acbdf1692@web.de>
MIME-Version: 1.0
In-Reply-To: <b40328ba-fa6d-972a-3b8e-db5acbdf1692@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 02 Mar 2021 12:43:31 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 02 Mar 2021 12:43:29 +0100 (CET)
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking evolution according to version 1.1.0
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

T24gU3VuLCBGZWIgMjgsIDIwMjEgYXQgMDk6MDE6NTRQTSArMDEwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6Cj4gPiBBIG5ldyB2ZXJzaW9uIDEuMS4wIGhhcyBiZWVuIHJlbGVhc2VkLgo+IAo+IFRo
YW5rcy4KPiAKPiBJIGhhdmUgZGFyZWQgdG8gYWN0aXZhdGUgYWxzbyBhIGN1cnJlbnQgT0NhbWwg
dmVyc2lvbiBieSB0aGUgY29tbWFuZAo+IOKAnG9wYW0gc3dpdGNoIGNyZWF0ZSA0LjEyLjDigJ0u
Cj4gSSBoYXZlIHRyaWVkIHRvIHJlYnVpbGQgeW91ciBzb2Z0d2FyZSBhY2NvcmRpbmdseS4KPiAK
PiBlbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2luZWxsZS8yMDE2MDIwNT4gbWFrZSBkaXN0
Y2xlYW4gJiYgZ2l0IGNoZWNrb3V0IG1hc3RlciAmJiBnaXQgcHVsbCAmJiAuL2F1dG9nZW4gJiYg
Li9jb25maWd1cmUgJiYgZWNobyAiJCguL3ZlcnNpb24uc2gpIiAmJiBncmVwIFZFUlNJT049MSBN
YWtlZmlsZS5jb25maWcKPiAKPiAKPiBOb3cgSSBzdHVtYmxlIG9uIHRoZSBmb2xsb3dpbmcgZXJy
b3IgbWVzc2FnZS4KPiAKPiBlbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2luZWxsZS8yMDE2
MDIwNT4gTEFORz1DIG1ha2Ugd29ybGQKPiBtYWtlIC1DIGJ1bmRsZXMvc3RkY29tcGF0IGFsbAo+
IG1ha2VbMV06IEVudGVyaW5nIGRpcmVjdG9yeSAnL2hvbWUvZWxmcmluZy9Qcm9qZWt0ZS9Db2Nj
aW5lbGxlLzIwMTYwMjA1L2J1bmRsZXMvc3RkY29tcGF0Jwo+IGNkIHN0ZGNvbXBhdC1jdXJyZW50
OyBtYWtlICYmIGNwICoubWxpICouY21pICouY214ICouY21hICouY214YSAqLmEgKi5oIC4uCj4g
bWFrZVsyXTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvaG9tZS9lbGZyaW5nL1Byb2pla3RlL0NvY2Np
bmVsbGUvMjAxNjAyMDUvYnVuZGxlcy9zdGRjb21wYXQvc3RkY29tcGF0LWN1cnJlbnQnCj4gbWFr
ZSAgYWxsLWFtCj4gbWFrZVszXTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvaG9tZS9lbGZyaW5nL1By
b2pla3RlL0NvY2NpbmVsbGUvMjAxNjAyMDUvYnVuZGxlcy9zdGRjb21wYXQvc3RkY29tcGF0LWN1
cnJlbnQnCj4gb2NhbWxmaW5kIG9jYW1sb3B0IC1jIC1wYWNrYWdlIHNlcSAtcGFja2FnZSB1Y2hh
ciAtYmluLWFubm90IC1uby1hbGlhcy1kZXBzIC1JIC4gLWFsZXJ0IC1kZXByZWNhdGVkIHN0ZGNv
bXBhdF9fYXJnX3MubWxpIC1vIHN0ZGNvbXBhdF9fYXJnX3MuY21pCj4gRmlsZSAic3RkY29tcGF0
X19hcmdfcy5tbGkiLCBsaW5lcyAzLTE3LCBjaGFyYWN0ZXJzIDAtMzg6Cj4gIDMgfCB0eXBlIHNw
ZWMgPSBBcmcuc3BlYyA9Cj4gIDQgfCAgIHwgVW5pdCBvZiAodW5pdCAtPiB1bml0KQo+ICA1IHwg
ICB8IEJvb2wgb2YgKGJvb2wgLT4gdW5pdCkKPiAgNiB8ICAgfCBTZXQgb2YgYm9vbCByZWYKPiAg
NyB8ICAgfCBDbGVhciBvZiBib29sIHJlZgo+IC4uLgo+IDE0IHwgICB8IFR1cGxlIG9mIHNwZWMg
bGlzdAo+IDE1IHwgICB8IFN5bWJvbCBvZiBzdHJpbmcgbGlzdCAqIChzdHJpbmcgLT4gdW5pdCkK
PiAxNiB8ICAgfCBSZXN0IG9mIChzdHJpbmcgLT4gdW5pdCkKPiAxNyB8ICAgfCBFeHBhbmQgb2Yg
KHN0cmluZyAtPiBzdHJpbmcgYXJyYXkpLgo+IEVycm9yOiBUaGlzIHZhcmlhbnQgb3IgcmVjb3Jk
IGRlZmluaXRpb24gZG9lcyBub3QgbWF0Y2ggdGhhdCBvZiB0eXBlIEFyZy5zcGVjCj4gICAgICAg
IENvbnN0cnVjdG9ycyBudW1iZXIgMTQgaGF2ZSBkaWZmZXJlbnQgbmFtZXMsIFJlc3RfYWxsIGFu
ZCBFeHBhbmQuCj4gbWFrZVszXTogKioqIFtNYWtlZmlsZToxNjEyOiBzdGRjb21wYXRfX2FyZ19z
LmNtaV0gRXJyb3IgMgo+IOKApgo+IAo+IAo+IFdvdWxkIHlvdSBsaWtlIHRvIHBvaW50IGFueSBj
b3JyZXNwb25kaW5nIGFkanVzdG1lbnRzIG91dD8KClRoaXMgcGF0Y2ggd2lsbCBtYWtlIGl0IHdv
cmssIGFsdGhvdWdoIGl0J3MgYSBoYWNrOgoKaHR0cHM6Ly9zcmMuZmVkb3JhcHJvamVjdC5vcmcv
cnBtcy9jb2NjaW5lbGxlL3RyZWUvcmF3aGlkZQoKUmljaC4KCi0tIApSaWNoYXJkIEpvbmVzLCBW
aXJ0dWFsaXphdGlvbiBHcm91cCwgUmVkIEhhdCBodHRwOi8vcGVvcGxlLnJlZGhhdC5jb20vfnJq
b25lcwpSZWFkIG15IHByb2dyYW1taW5nIGFuZCB2aXJ0dWFsaXphdGlvbiBibG9nOiBodHRwOi8v
cndtai53b3JkcHJlc3MuY29tCnZpcnQtYnVpbGRlciBxdWlja2x5IGJ1aWxkcyBWTXMgZnJvbSBz
Y3JhdGNoCmh0dHA6Ly9saWJndWVzdGZzLm9yZy92aXJ0LWJ1aWxkZXIuMS5odG1sCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
