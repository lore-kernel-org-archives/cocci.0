Return-Path: <SRS0=1Yua=GL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E62C433E0
	for <cocci@archiver.kernel.org>; Fri,  8 Jan 2021 23:10:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5966E23A60
	for <cocci@archiver.kernel.org>; Fri,  8 Jan 2021 23:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5966E23A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 108NAMdj004774;
	Sat, 9 Jan 2021 00:10:22 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4BDE477A3;
	Sat,  9 Jan 2021 00:10:22 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 864143783
 for <cocci@systeme.lip6.fr>; Sat,  9 Jan 2021 00:10:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 108NAJC7013947
 for <cocci@systeme.lip6.fr>; Sat, 9 Jan 2021 00:10:19 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.79,333,1602540000"; d="scan'208";a="369475426"
Received: from org51-h01-176-134-229-12.dsl.sta.abo.bbox.fr (HELO pl347-pro)
 ([176.134.229.12])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jan 2021 00:10:19 +0100
References: <20210105190008.GB27779@redhat.com>
 <alpine.DEB.2.22.394.2101082341230.2796@hadrien>
User-agent: mu4e 1.4.8; emacs 27.1
From: Thierry Martinez <Thierry.Martinez@inria.fr>
To: Julia Lawall <julia.lawall@inria.fr>
In-reply-to: <alpine.DEB.2.22.394.2101082341230.2796@hadrien>
Date: Sat, 09 Jan 2021 00:10:18 +0100
Message-ID: <ow4mtxjyqhx.fsf@inria.fr>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 09 Jan 2021 00:10:22 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 09 Jan 2021 00:10:19 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Python 3.10 again: _Py_fopen deprecated
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

SGksIFJpY2hhcmQuCgpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHR3byBzdWNjZXNzaXZl
IHJlcG9ydHMgYWJvdXQKaW5jb21wYXRpYmlsaXRpZXMgYmV0d2VlbiBweW1sIGFuZCBQeXRob24g
My4xMC4gVGhleSBzaG91bGQgaGF2ZSBiZWVuCmZpeGVkIG5vdy4KClJpY2hhcmQ6Cj4+IFdoYXQg
SSBkb24ndCB1bmRlcnN0YW5kIGZyb20gdGhlIHB5eG1sIGNvZGUgaXMgd2h5IHdlIHVzZSB0aGVz
ZQo+PiBpbnRlcm5hbCBQeXRob24gZnVuY3Rpb25zIGF0IGFsbCwgaW5zdGVhZCBvZiBjYWxsaW5n
IHJlZ3VsYXIgQwo+PiBmdW5jdGlvbnMgbGlrZSBmb3BlbiBldGMuICBJbiBmYWN0IGl0IHNlZW1z
IGxpa2UgZm9yIFB5dGhvbiAyIHdlIGRpZAo+PiBjYWxsIGZvcGVuIC4uLgoKSW5kZWVkLCBmb3Ig
UHl0aG9uIDIsIHRoZXJlIGlzIGEgZmFsbGJhY2sgdG8gZm9wZW4gc2luY2UgUHlfZm9wZW4gaXMg
bm90CmF2YWlsYWJsZS4gIFdoZW4gUHlfZm9wZW4gb3IgUHlfd2ZvcGVuIGFyZSBhdmFpbGFibGUs
IHdlIHByZWZlciB0byB1c2UKdGhlbSBiZWNhdXNlIHRoZXkgaGFuZGxlIHRoZSBXaW5kb3dzIHNw
ZWNpYWwgY2FzZS4KCkJlc3QgcmVnYXJkcy4KLS0gClRoaWVycnkuCgpKdWxpYSBMYXdhbGzCoDoK
PiBPbiBUdWUsIDUgSmFuIDIwMjEsIFJpY2hhcmQgVy5NLiBKb25lcyB3cm90ZToKPgo+PiBGaXJz
dGx5IGEgZ2VudGxlIHJlbWluZGVyIHRoYXQgdGhlcmUncyBhIHBhdGNoIHdhaXRpbmcgdG8gYmUg
YXBwbGllZDoKPj4gaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvcGlwZXJtYWlsL2NvY2NpLzIwMjAt
Tm92ZW1iZXIvdGhyZWFkLmh0bWwjODM5OAo+Pgo+PiBEaWZmZXJlbnQgZnJvbSB0aGF0IHBhdGNo
LCBidXQgc3RpbGwgcmVsYXRlZCB0byBQeXRob24gMy4xMCwgd2UndmUgZ290Cj4+IGFub3RoZXIg
YnVnIHJlcG9ydCBoZXJlOgo+PiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcu
Y2dpP2lkPTE5MTI5MzEKPj4KPj4gVGhpcyB0aW1lIF9QeV9mb3BlbiBoYXMgYmVlbiBkZXByZWNh
dGVkLCByZXBsYWNlZCBieSBfUHlfd2ZvcGVuIG9yCj4+IF9QeV9mb3Blbl9vYmouICBJdCdzIHVu
Y2xlYXIgd2hpY2ggaXMgYmV0dGVyLiAgVGhlIHR3byBmdW5jdGlvbnMgYXJlCj4+IGRvY3VtZW50
ZWQgaGVyZToKPj4gaHR0cHM6Ly9naXRodWIuY29tL3B5dGhvbi9jcHl0aG9uL2Jsb2IvbWFzdGVy
L1B5dGhvbi9maWxldXRpbHMuYyNMMTQxOAo+Pgo+PiBXaGF0IEkgZG9uJ3QgdW5kZXJzdGFuZCBm
cm9tIHRoZSBweXhtbCBjb2RlIGlzIHdoeSB3ZSB1c2UgdGhlc2UKPj4gaW50ZXJuYWwgUHl0aG9u
IGZ1bmN0aW9ucyBhdCBhbGwsIGluc3RlYWQgb2YgY2FsbGluZyByZWd1bGFyIEMKPj4gZnVuY3Rp
b25zIGxpa2UgZm9wZW4gZXRjLiAgSW4gZmFjdCBpdCBzZWVtcyBsaWtlIGZvciBQeXRob24gMiB3
ZSBkaWQKPj4gY2FsbCBmb3BlbiAuLi4KPgo+IEV2ZXJ5dGhpbmcgc2hvdWxkIGJlIHVwIHRvIGRh
dGUgbm93IG9uIGdpdGh1Yi4gIFRoYW5rcyBmb3IgeW91ciBoZWxwLgo+IFRoaWVycnkgd2lsbCBj
b250YWN0IHlvdSBkaXJlY3RseSBhYm91dCB0aGUgY2hvaWNlIG9mIGZvcGVuLgo+Cj4ganVsaWEK
Pgo+Pgo+PiBSaWNoLgo+Pgo+PiAtLQo+PiBSaWNoYXJkIEpvbmVzLCBWaXJ0dWFsaXphdGlvbiBH
cm91cCwgUmVkIEhhdCBodHRwOi8vcGVvcGxlLnJlZGhhdC5jb20vfnJqb25lcwo+PiBSZWFkIG15
IHByb2dyYW1taW5nIGFuZCB2aXJ0dWFsaXphdGlvbiBibG9nOiBodHRwOi8vcndtai53b3JkcHJl
c3MuY29tCj4+IEZlZG9yYSBXaW5kb3dzIGNyb3NzLWNvbXBpbGVyLiBDb21waWxlIFdpbmRvd3Mg
cHJvZ3JhbXMsIHRlc3QsIGFuZAo+PiBidWlsZCBXaW5kb3dzIGluc3RhbGxlcnMuIE92ZXIgMTAw
IGxpYnJhcmllcyBzdXBwb3J0ZWQuCj4+IGh0dHA6Ly9mZWRvcmFwcm9qZWN0Lm9yZy93aWtpL01p
bkdXCj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4+IENvY2NpIG1haWxpbmcgbGlzdAo+PiBDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKPj4gaHR0cHM6
Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo+Pgo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gQ29jY2kgbWFpbGluZyBsaXN0
Cj4gQ29jY2lAc3lzdGVtZS5saXA2LmZyCj4gaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1h
bi9saXN0aW5mby9jb2NjaQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczov
L3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
