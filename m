Return-Path: <SRS0=zNwH=6T=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996DAC47247
	for <cocci@archiver.kernel.org>; Tue,  5 May 2020 13:53:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10919206A5
	for <cocci@archiver.kernel.org>; Tue,  5 May 2020 13:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=schleiser.de header.i=@schleiser.de header.b="vibZY11q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10919206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=schleiser.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 045Dqacw024116;
	Tue, 5 May 2020 15:52:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2C1F7775A;
	Tue,  5 May 2020 15:52:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7AF993E6B
 for <cocci@systeme.lip6.fr>; Tue,  5 May 2020 15:52:34 +0200 (CEST)
Received: from mail.socioholic.net (mail.socioholic.net [138.201.210.212])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 045DqW6t014805
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 5 May 2020 15:52:32 +0200 (CEST)
Received: from [IPV6:2003:db:172e:4500:fdde:906:7c0a:2789]
 (p200300DB172E4500FDDE09067C0A2789.dip0.t-ipconnect.de
 [IPv6:2003:db:172e:4500:fdde:906:7c0a:2789])
 (Authenticated sender: kaspar)
 by mail.socioholic.net (Postfix) with ESMTPSA id 6F78F10640E;
 Tue,  5 May 2020 15:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schleiser.de; s=mail;
 t=1588686820; bh=M3p/HGkVK9/+B1PpbuA3odbwlYM81mgRzoT3WNQhiRw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=vibZY11quzuYVSWBZrXA2BxUtUczYRl3cTNSa5892fZ98n04UtLEOsbE9IiKG0UzB
 ZMqLq/p6gZTCPeZQV3qV+WmLHLk9CbSO+swwpA9dEC7bwMt5LLpn3jGlDNOwMOSd8z
 wkB9YnyF8dXOcPCslC2/wvYZxeXyqXUkBidcuoWvhB+bOoSs2ItXV1L6oIS/6WZ9ZS
 k5gL3tL/ovRQCfj+vrhzU90oYRqG3lEV80YfXwXPhppDI1AqM5lDT7v+y2PyIjP7Ta
 iti8KcCV2H/ll0DXtdesE2sDf33H7ait+TJN/3DCUi8HVAiOwO4hCIKutwRpfBlRH5
 mkgbRcfH1S1PA==
Date: Tue, 5 May 2020 15:52:24 +0200
From: kaspar@schleiser.de
To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>,
        Julia Lawall <julia.lawall@inria.fr>
Message-ID: <57b1cdf1-e481-43bd-b74c-496890703d00.maildroid@localhost>
In-Reply-To: <alpine.DEB.2.21.2005051522410.2462@hadrien>
References: <alpine.DEB.2.21.1909302142430.2925@hadrien>
 <eccc921f-c5f5-6dc5-5233-75f0fc16cb51@schleiser.de>
 <904fcac6-77cb-b44b-07fd-430bf3596614@univ-grenoble-alpes.fr>
 <ed125ed8-a2f8-2c1a-b0aa-acf83544cae8@schleiser.de>
 <fe7da089-446f-1d37-3d37-b24cdeff2a9f@univ-grenoble-alpes.fr>
 <alpine.DEB.2.21.2005051522410.2462@hadrien>
MIME-Version: 1.0
X-Mailer: MailDroid/4.92 (Android 10)
User-Agent: MailDroid/4.92 (Android 10)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 05 May 2020 15:52:36 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 05 May 2020 15:52:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] 1.0.8 on Ubuntu
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

SSdsbCBnbyB0aHJvdWdoIHRoZSBjb21tYW5kcyBsYXRlciB0b25pZ2h0IGFuZCByZXBvcnQgYmFj
ay4KCkthc3BhcgoKLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KRnJvbTogSnVsaWEgTGF3YWxs
IDxqdWxpYS5sYXdhbGxAaW5yaWEuZnI+ClRvOiBOaWNvbGFzIFBhbGl4IDxuaWNvbGFzLnBhbGl4
QHVuaXYtZ3Jlbm9ibGUtYWxwZXMuZnI+CkNjOiBLYXNwYXIgU2NobGVpc2VyIDxrYXNwYXJAc2No
bGVpc2VyLmRlPiwgY29jY2lAc3lzdGVtZS5saXA2LmZyClNlbnQ6IERpLiwgMDUgTWFpIDIwMjAg
MTU6MjQKU3ViamVjdDogUmU6IFtDb2NjaV0gMS4wLjggb24gVWJ1bnR1CgoKCk9uIFR1ZSwgNSBN
YXkgMjAyMCwgTmljb2xhcyBQYWxpeCB3cm90ZToKCj4KPgo+IExlIDA1LzA1LzIwMjAgw6AgMTE6
MTYsIEthc3BhciBTY2hsZWlzZXIgYSDDqWNyaXQgOgo+ID4gSGkgTmljb2xhcywKPiA+Cj4gPiB0
aGFua3MgZm9yIHRoZSBxdWljayByZXBseSEKPgo+IFlvdSdyZSB3ZWxjb21lLgo+Cj4gSnVsaWEs
IG1heWJlIGl0IHdvcnRoIHJlY29yZGluZyB0aGUgc2VxdWVuY2Ugb2YgY29tbWFuZHMgc29tZXdo
ZXJlLAo+IGluIHRoZSBSRUFETUUgb3IgdGhlIHdlYnNpdGUuCgpHb29kIGlkZWEuICBJJ20ganVz
dCBjb25jZXJuZWQgYWJvdXQgdGhlIHdvcmQgInJvdWdobHkiLiAgS2FzcGFyIGFyZSB0aGVyZQph
bnkgZGV0YWlscyB0aGF0IG5lZWQgdG8gYmUgYWRkZWQ/Cgp0aGFua3MsCmp1bGlhCgo+Cj4gPgo+
ID4gT24gNS81LzIwIDEwOjUwIEFNLCBOaWNvbGFzIFBhbGl4IHdyb3RlOgo+ID4+IEkgdGhpbmsg
eW91IGNvdWxkIHRyeSB0aGUgZm9sbG93aW5nIHZlcnNpb24gKGludGVuZGVkIGZvciAyMC4xMCku
Cj4gPj4gaHR0cHM6Ly9sYXVuY2hwYWQubmV0L3VidW50dS8rc291cmNlL2NvY2NpbmVsbGUvMS4w
LjguZGViLTIKPiA+Cj4gPiBJIG1hbmFnZWQgdG8gY29tcGlsZSB0aGUgMTkuMDQgdmVyc2lvbgo+
ID4gKGNvY2NpbmVsbGVfMS4wLjh+MTkuMDRucGFsaXgxLmRzYywKPiA+IGNvY2NpbmVsbGVfMS4w
Ljh+MTkuMDRucGFsaXgxLnRhci54eikuIFNvbWVob3cgSSBtaXNzZWQgdGhhdCB0aGVyZSdzIGEK
PiA+IDIwLjEwIHZlcnNpb24uCj4gPgo+ID4gVGhlIGNvbW1hbmRzIHdlcmUgcm91Z2hseToKPiA+
Cj4gPiAkIGFwdCBpbnN0YWxsIGRlYmhlbHBlciBkZXZzY3JpcHRzIGVxdWl2cwo+ID4gJCBkcGtn
LXNvdXJjZSAteCBjb2NjaW5lbGxlXzEuMC44fjE5LjA0bnBhbGl4MS5kc2MKPiA+ICQgY2QgY29j
Y2luZWxsZS0xLjAuOAo+ID4gJCBtay1idWlsZC1kZXBzIC1pCj4gPiAkIGRwa2ctYnVpbGRwYWNr
YWdlIC1yZmFrZXJvb3QgLWIKPiA+ICQgYXB0IGluc3RhbGwgLi4vY29jY2luZWxsZV8xLjAuOH4x
OS4wNG5wYWxpeDFfYW1kNjQuZGViCj4gPgo+ID4gVGhlIHJlc3VsdGluZyAuZGViIGNhbiBiZSBp
bnN0YWxsZWQgb24gYW4gb3RoZXJ3aXNlIGNsZWFuIGZvY2FsOmxhdGVzdAo+ID4gY29udGFpbmVy
LiBUaGUgc3BhdGNoIGJpbmFyeSBzdGFydHMgKHByaW50cyBoZWxwKSwgZGlkIG5vdCBkbyBmdXJ0
aGVyCj4gPiB0ZXN0aW5nLgo+ID4KPiA+IEthc3Bhcgo+ID4KPgo+Cj4gLS0KPiBOaWNvbGFzIFBh
bGl4Cj4gaHR0cDovL2xpZy1tZW1icmVzLmltYWcuZnIvcGFsaXgvCj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBDb2NjaSBtYWlsaW5nIGxpc3QKPiBD
b2NjaUBzeXN0ZW1lLmxpcDYuZnIKPiBodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xp
c3RpbmZvL2NvY2NpCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
