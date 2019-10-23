Return-Path: <SRS0=uT6i=YQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F93CA9EBC
	for <cocci@archiver.kernel.org>; Wed, 23 Oct 2019 09:57:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97EB2084B
	for <cocci@archiver.kernel.org>; Wed, 23 Oct 2019 09:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97EB2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9N9vV7C028238;
	Wed, 23 Oct 2019 11:57:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 691AC77D7;
	Wed, 23 Oct 2019 11:57:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3FAE777B4
 for <cocci@systeme.lip6.fr>; Wed, 23 Oct 2019 11:41:22 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9N9fIS4016436
 for <cocci@systeme.lip6.fr>; Wed, 23 Oct 2019 11:41:20 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id B0B94FA68FE1FDF5569C;
 Wed, 23 Oct 2019 17:41:17 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
 by mse-fl2.zte.com.cn with SMTP id x9N9ewHd054107;
 Wed, 23 Oct 2019 17:40:59 +0800 (GMT-8)
 (envelope-from zhong.shiqi@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid32;
 Wed, 23 Oct 2019 17:40:58 +0800 (CST)
Date: Wed, 23 Oct 2019 17:40:58 +0800 (CST)
X-Zmail-TransId: 2af95db0202a5f8ac26d
X-Mailer: Zmail v1.0
Message-ID: <201910231740582401627@zte.com.cn>
In-Reply-To: <alpine.DEB.2.21.1910231054250.2335@hadrien>
References: 1571819563-18118-1-git-send-email-zhong.shiqi@zte.com.cn,
 alpine.DEB.2.21.1910231054250.2335@hadrien
Mime-Version: 1.0
From: <zhong.shiqi@zte.com.cn>
To: <julia.lawall@lip6.fr>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn x9N9ewHd054107
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 23 Oct 2019 11:57:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 23 Oct 2019 11:41:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 23 Oct 2019 11:57:27 +0200
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        cheng.shengyu@zte.com.cn, cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5BPATCH=5D_Configuring_COCCI_parameter_as_a_di?=
	=?utf-8?q?rectory_issupportted?=
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SnVsaWEsCiAgICAgICAgQWRkIGEgc2NyaXB0IHRvIGRldGVybWluZSBpZiAkQ09DQ0kgaXMgYSBk
aXJlY3RvcnkuIAogICAgICAgIElmICRDT0NDSSBpcyB1bmRlZmluZWQsIG1lYW5zIGZpcnN0IGlm
IGJyYW5jaCBzdWNjZXNzLCB0aGVuIGZpcnN0IGlmIGJyYW5jaCBpcyBleGVjdXRlZC4gCiAgICAg
ICAgSWYgJENPQ0NJIGlzIGRlZmluZWQsIG1lYW5zIHRoYXQgZmFpbHMsIHRoZW4gZWxpZiBicmFu
Y2ggaXMgZXhlY3V0ZWQuIEFuZCB0aGVuLCBUaGUgZWxpZiBicmFuY2gganVkZ2VzIHdoZXRoZXIg
JENPQ0NJIGlzIGEgZGlyZWN0b3J5KGJhc2VkIG9uICItZCIgb3B0aW9uKS4gCiAgICAgICAgSWYg
aXQgaXMgYSBkaXJlY3RvcnksIHRoZSBuZXh0IHN0YXRlbWVudCBpcyBleGVjdXRlZC4gSWYgaXQg
aXMgbm90IGEgZGlyZWN0b3J5IG9yIGlmIGl0IGlzIGp1c3QgYSBmaWxlIHdpdGggYSBhIHN1ZmZp
eCBvZiBjb2NjaSwgdGhlIHN0YXRlbWVudCBhZnRlciB0aGUgZmluYWwgZWxzZSBicmFuY2ggaXMg
ZXhlY3V0ZWQuClRoYW5rcyBmb3IgeW91IHJlcGx577yMCnpob25nLnNoaXFpCgoKCgoKRTogemhv
bmcuc2hpcWlAenRlLmNvbS5jbgp3d3cuenRlLmNvbS5jbgotLS0tLS0tLS0tLS0tLS0tLS1Pcmln
aW5hbCBNYWlsLS0tLS0tLS0tLS0tLS0tLS0tClNlbmRlcjogSnVsaWFMYXdhbGwgPGp1bGlhLmxh
d2FsbEBsaXA2LmZyPgpUbzogemhvbmdzaGlxaTEwMjY1ODY3OwpDQzogSnVsaWEuTGF3YWxsQGxp
cDYuZnIgPEp1bGlhLkxhd2FsbEBsaXA2LmZyPkdpbGxlcyBNdWxsZXIgPEdpbGxlcy5NdWxsZXJA
bGlwNi5mcj5uaWNvbGFzLnBhbGl4QGltYWcuZnIgPG5pY29sYXMucGFsaXhAaW1hZy5mcj5taWNo
YWwubGttbEBtYXJrb3ZpLm5ldCA8bWljaGFsLmxrbWxAbWFya292aS5uZXQ+Y29jY2lAc3lzdGVt
ZS5saXA2LmZyIDxjb2NjaUBzeXN0ZW1lLmxpcDYuZnI+bGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz54dWUgemhpaG9uZzEwMDE3Nzg5O3dh
bmcgeWkxMDEyOTk2MztjaGVuZyBzaGVuZ3l1MTAwMTM1NTc7eWFtYWRhLm1hc2FoaXJvQHNvY2lv
bmV4dC5jb20gPHlhbWFkYS5tYXNhaGlyb0Bzb2Npb25leHQuY29tPgpEYXRlOiAyMDE5LzEwLzIz
IDE2OjU1ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIENvbmZpZ3VyaW5nIENPQ0NJIHBhcmFtZXRlciBh
cyBhIGRpcmVjdG9yeSBpc3N1cHBvcnR0ZWQKCgpPbiBXZWQsIDIzIE9jdCAyMDE5LCB6aG9uZ3No
aXFpIHdyb3RlOgoKPiBUaGlzIHBhdGNoIHB1dHMgYSBtb2RpZmljYXRpb24gaW4gc2NyaXB0cy9j
b2NjaWNoZWNrIHdoaWNoIHN1cHBvcnRzIHVzZXJzCj4gaW4gY29uZmlndXJpbmcgQ09DQ0kgcGFy
YW1ldGVyIGFzIGEgZGlyZWN0b3J5IHRvIHRyYXZlcnNlIGZpbGVzIGluCj4gZGlyZWN0b3J5Lgo+
Cj4gU2lnbmVkLW9mZi1ieTogemhvbmdzaGlxaSA8emhvbmcuc2hpcWlAenRlLmNvbS5jbj4KPiAt
LS0KPiAgc2NyaXB0cy9jb2NjaWNoZWNrIHwgNCArKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9zY3JpcHRzL2NvY2NpY2hlY2sgYi9zY3JpcHRz
L2NvY2NpY2hlY2sKPiBpbmRleCBlMDRkMzI4Li5hMWM0MTk3IDEwMDc1NQo+IC0tLSBhL3Njcmlw
dHMvY29jY2ljaGVjawo+ICsrKyBiL3NjcmlwdHMvY29jY2ljaGVjawo+IEBAIC0yNTcsNiArMjU3
LDEwIEBAIGlmIFsgIiRDT0NDSSIgPSAiIiBdIDsgdGhlbgo+ICAgICAgZm9yIGYgaW4gYGZpbmQg
JHNyY3RyZWUvc2NyaXB0cy9jb2NjaW5lbGxlLyAtbmFtZSAnKi5jb2NjaScgLXR5cGUgZiB8IHNv
cnRgOyBkbwo+ICAgICAgY29jY2luZWxsZSAkZgo+ICAgICAgZG9uZQo+ICtlbGlmIFsgLWQgIiRD
T0NDSSIgXSA7IHRoZW4KPiArICAgIGZvciBmIGluIGBmaW5kICRDT0NDSS8gLW5hbWUgJyouY29j
Y2knIC10eXBlIGYgfCBzb3J0YDsgZG8KPiArICAgIGNvY2NpbmVsbGUgJGYKPiArICAgIGRvbmUK
PiAgZWxzZQo+ICAgICAgY29jY2luZWxsZSAkQ09DQ0kKPiAgZmkKClRoYW5rcyBmb3IgdGhlIGNv
bnRyaWJ1dGlvbi4gIEknbSBub3QgdGhhdCBrbm93bGVkZ2VhYmxlIGFib3V0IHRoZXNlCnNjcmlw
dHMuICBXaGF0IGlzIHRoZSByZWxhdGlvbiBiZXR3ZWVuIHRoZSBsYXN0IHR3byBpZiBicmFuY2hl
cz8gIElmIHRoZQpmaXJzdCBvbmUgZmFpbHMsIGRvZXMgdGhhdCBtZWFuIHRoYXQgJENPQ0NJIGhh
cyBubyBkZWZpbml0aW9uPyAgSW4gdGhhdApjYXNlLCBpcyB0aGUgZmluYWwgZWxzZSB1c2VmdWw/
Cgp0aGFua3MsCmp1bGlh


--=====_003_next=====--

--=====_001_next=====
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--=====_001_next=====--

