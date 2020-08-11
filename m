Return-Path: <SRS0=8ujx=BV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D80C433DF
	for <cocci@archiver.kernel.org>; Tue, 11 Aug 2020 08:24:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C59E20678
	for <cocci@archiver.kernel.org>; Tue, 11 Aug 2020 08:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wEavTbVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C59E20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07B8O2P2023873;
	Tue, 11 Aug 2020 10:24:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 00EE14084;
	Tue, 11 Aug 2020 10:24:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 788FC3C97
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 10:24:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07B8NwAx014939
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 10:23:59 +0200 (CEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7BBF020678;
 Tue, 11 Aug 2020 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597134238;
 bh=e4cpDk0boX/iV+YqjkiI+GIWkiE8A7x1ApDty9mkzMQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wEavTbVdt8q7mUrlUwpzGN2eaGWliSSG83YFiI8j/AuAaER7ylyflD91gAR09lDnr
 Qi1iuOqM6tjTFzdpVEJx0AWgMRxQf7m/83lP7EJe+sIuU6MAwROUX5bLYJIb/tFEga
 32hgbtD+Qus42MeGoqgYVG3N2cIP75iqRFFQi2zg=
Date: Tue, 11 Aug 2020 10:24:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200811082408.GE113774@kroah.com>
References: <478715f8-87dd-7b4d-d3fd-01585f5f3bd7@web.de>
 <alpine.DEB.2.22.394.2008102249570.2466@hadrien>
 <d6dcb49d-3dca-327e-e782-2cae789e31b7@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d6dcb49d-3dca-327e-e782-2cae789e31b7@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 11 Aug 2020 10:24:02 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 11 Aug 2020 10:24:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Jonathan Corbet <corbet@lwn.net>, Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, linux-doc@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [Cocci] [v3] documentation: coccinelle: Improve command example
 for make C={1, 2}
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

T24gVHVlLCBBdWcgMTEsIDIwMjAgYXQgMDk6MDM6MDlBTSArMDIwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6Cj4gPj4+IHRoZSB1c2FnZSBvZiB0aGUgbWFrZWZpbGUgQyB2YXJpYWJsZSBmbGFnIGJ5
IGNvY2NpY2hlY2suCj4gPj4KPiA+PiAqIENhbiBpdCBiZSBjb25mdXNpbmcgdG8gZGVub3RlIGFu
IGl0ZW0gYXMgYSB2YXJpYWJsZSBhbmQgYSBmbGFnPwo+ID4+Cj4gPj4gKiBXb3VsZCB5b3UgcmVh
bGx5IGxpa2UgdG8gc3RyZXNzIGhlcmUgdGhhdCBhIGZsYWcgY2FuIGJlIHZhcmlhYmxlPwo+ID4K
PiA+IFRoaXMgaXMgbm90IHBhcnQgb2YgdGhlIGRvY3VtZW50YXRpb24sIHNvIGl0IGRvZXNuJ3Qg
cmVhbGx5IG1hdHRlci4KPiAKPiBJdCBzZWVtcyB0aGVuIHRoYXQgeW91ciBleHBlY3RhdGlvbnMg
Zm9yIHRoZSBjbGFyaXR5IG9mIGNoYW5nZSBkZXNjcmlwdGlvbnMKPiAob3IgY29tbWl0IG1lc3Nh
Z2VzKSBjYW4gdmFyeSBjb25zaWRlcmFibHkuCj4gCj4gCj4gPiBOZXZlcnRoZWxlc3MsIFN1bWVy
YSwgdGhlcmUgaXMgc3RhaWwgYW4gb2NjdXJyZW5jZSBvZiBmbGFnIGluIHRoZSBwcm9wb3NlZAo+
ID4gY2hhbmdlIHRvIHRoZSBkb2N1bWVudGF0aW9uLCBzbyB5b3UgY291bGQgaW5kZWVkIGNoYW5n
ZSB0aGF0IG9uZSB0byB2YXJpYWJsZS4KPiAKPiBXaWxsIGFueSByZWxhdGVkIGFkanVzdG1lbnRz
IGJlY29tZSBtb3JlIGludGVyZXN0aW5nPwo+IAo+IAo+ID4+PiArVGhpcyB2YXJpYWJsZSBjYW4g
YmUgdXNlZCB0byBydW4gc2NyaXB0cyBmb3Ig4oCmCj4gPj4KPiA+PiBDYW4gdGhlIHNjb3BlIGZv
ciBhIG1ha2UgY29tbWFuZCBiZSBzZWxlY3RlZCBhbHNvIHdpdGhvdXQgc3VjaCBhIHZhcmlhYmxl
Pwo+ID4KPiA+IElmIHlvdSBrbm93IHNvbWV0aGluZyB0aGF0IGlzIGRpZmZlcmVudCB0aGFuIHdo
YXQgaXMgaW4gdGhlIGRvY3VtZW50YXRpb24sCj4gPiB0aGVuIHBsZWFzZSBzYXkgd2hhdCBpdCBp
cy4gIERvbid0IGp1c3QgYXNrIHF1ZXN0aW9ucy4KPiAKPiBJIHN1Z2dlc3QgdG8gaW5jcmVhc2Ug
dGhlIGRpc3RpbmN0aW9uIGZvciB0aGUgYXBwbGljYXRpb24gb2Ygc3VjaCBjb21tYW5kIHBhcmFt
ZXRlcnMuCj4gCj4gCj4gPj4gV2lsbCBjbGFyaWZpY2F0aW9uIHJlcXVlc3RzIGZvciBwcmV2aW91
c2x5IG1lbnRpb25lZCBiYWNrZ3JvdW5kIGluZm9ybWF0aW9uCj4gPj4gaW5mbHVlbmNlIHRoZSBw
cm9wb3NlZCBkZXNjcmlwdGlvbnMgYW55IGZ1cnRoZXI/Cj4gPgo+ID4gVGhlIHBvaW50IGlzIHRv
IGRvY3VtZW50IHRoZSB1c2Ugb2YgbWFrZSBjb2NjaWNoZWNrLAo+IAo+IEFub3RoZXIgYXR0ZW1w
dCBpcyBldm9sdmluZyBmb3IgdGhlIGFmZmVjdGVkIHNvZnR3YXJlIGRvY3VtZW50YXRpb24uCj4g
Cj4gCj4gPiBub3QgdGhlIEMgdmFyaWFibGVzLgo+IAo+IEkgZ290IGFuIG90aGVyIGltcHJlc3Np
b24gaGVyZS4KPiAKPiAKPiA+IFNvIHRoZSBwb2ludCBhYm91dCBLQlVJTERfQ0hFQ0ssIHdoaWxl
IGludGVyZXN0aW5nLCBkb2VzIG5vdCBzZWVtCj4gPiBhcHByb3ByaWF0ZSBmb3IgdGhpcyBkb2N1
bWVudGF0aW9uLgo+IAo+IEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gY2xhcmlmeSB0aGUgaW5m
bHVlbmNlIG9mIGEgbWFjcm8gbGlrZSDigJxLQlVJTERfQ0hFQ0tTUkPigJ0KPiAob3IgdGhlIHNw
ZWNpZmljYXRpb24g4oCcJChjYWxsIGNtZCxmb3JjZV9jaGVja3NyYynigJ0pPwo+IAo+IFdpbGwg
YSBjcm9zcyByZWZlcmVuY2UgZm9yIHRoZSBhcHBsaWVkIG1ha2Ugc2NyaXB0cyBoZWxwIHRvIGFj
aGlldmUKPiBhIGJldHRlciBjb21tb24gdW5kZXJzdGFuZGluZyAoYW5kIGNvcnJlc3BvbmRpbmcg
ZGVzY3JpcHRpb25zKSBvZgo+IHRoZSBpbnZvbHZlZCBkZXBlbmRlbmNpZXM/Cj4gCj4gUmVnYXJk
cywKPiBNYXJrdXMKCgoKSGksCgpUaGlzIGlzIHRoZSBmcmllbmRseSBzZW1pLWF1dG9tYXRlZCBw
YXRjaC1ib3Qgb2YgR3JlZyBLcm9haC1IYXJ0bWFuLgpZb3UgaGF2ZSBzZW50IGhpbSBhIHBhdGNo
IHRoYXQgaGFzIHRyaWdnZXJlZCB0aGlzIHJlc3BvbnNlLgoKUmlnaHQgbm93LCB0aGUgZGV2ZWxv
cG1lbnQgdHJlZSB5b3UgaGF2ZSBzZW50IGEgcGF0Y2ggZm9yIGlzICJjbG9zZWQiCmR1ZSB0byB0
aGUgdGltaW5nIG9mIHRoZSBtZXJnZSB3aW5kb3cuICBEb24ndCB3b3JyeSwgdGhlIHBhdGNoKGVz
KSB5b3UKaGF2ZSBzZW50IGFyZSBub3QgbG9zdCwgYW5kIHdpbGwgYmUgbG9va2VkIGF0IGFmdGVy
IHRoZSBtZXJnZSB3aW5kb3cgaXMKb3ZlciAoYWZ0ZXIgdGhlIC1yYzEga2VybmVsIGlzIHJlbGVh
c2VkIGJ5IExpbnVzKS4KClNvIHRoYW5rIHlvdSBmb3IgeW91ciBwYXRpZW5jZSBhbmQgeW91ciBw
YXRjaGVzIHdpbGwgYmUgcmV2aWV3ZWQgYXQgdGhpcwpsYXRlciB0aW1lLCB5b3UgZG8gbm90IGhh
dmUgdG8gZG8gYW55dGhpbmcgZnVydGhlciwgdGhpcyBpcyBqdXN0IGEgc2hvcnQKbm90ZSB0byBs
ZXQgeW91IGtub3cgdGhlIHBhdGNoIHN0YXR1cyBhbmQgc28geW91IGRvbid0IHdvcnJ5IHRoZXkg
ZGlkbid0Cm1ha2UgaXQgdGhyb3VnaC4KCnRoYW5rcywKCmdyZWcgay1oJ3MgcGF0Y2ggZW1haWwg
Ym90Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2Np
IG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYu
ZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
