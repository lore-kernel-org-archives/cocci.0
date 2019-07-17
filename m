Return-Path: <SRS0=ZAj6=VO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCAEC76186
	for <cocci@archiver.kernel.org>; Wed, 17 Jul 2019 03:44:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C57206C2
	for <cocci@archiver.kernel.org>; Wed, 17 Jul 2019 03:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C57206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6H3hqXk011975;
	Wed, 17 Jul 2019 05:43:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CF3AE777E;
	Wed, 17 Jul 2019 05:43:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 425FA777C
 for <cocci@systeme.lip6.fr>; Wed, 17 Jul 2019 05:43:50 +0200 (CEST)
Received: from mxct.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6H3hlUq008562
 for <cocci@systeme.lip6.fr>; Wed, 17 Jul 2019 05:43:48 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 89DA56892C8571B33213;
 Wed, 17 Jul 2019 11:43:45 +0800 (CST)
Received: from kjyxapp01.zte.com.cn ([10.30.12.200])
 by mse-fl1.zte.com.cn with SMTP id x6H3hDsl007540;
 Wed, 17 Jul 2019 11:43:13 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp03[null]) by mapi (Zmail) with MAPI id mid14;
 Wed, 17 Jul 2019 11:43:13 +0800 (CST)
Date: Wed, 17 Jul 2019 11:43:13 +0800 (CST)
X-Zmail-TransId: 2b055d2e99514287d9d2
X-Mailer: Zmail v1.0
Message-ID: <201907171143136548526@zte.com.cn>
In-Reply-To: <663d8141-5740-a452-1f4a-8335203e65ba@web.de>
References: 1563246347-7803-1-git-send-email-wen.yang99@zte.com.cn,
 663d8141-5740-a452-1f4a-8335203e65ba@web.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x6H3hDsl007540
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jul 2019 05:43:53 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jul 2019 05:43:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        yellowriver2010@hotmail.com, xue.zhihong@zte.com.cn,
        cheng.shengyu@zte.com.cn, cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5BPATCH_v3=5D_coccinelle=3A_semantic_code_sear?=
	=?utf-8?q?ch_for_missingof=5Fnode=5Fput?=
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

SGkgTWFya3VzLAoKPiA+IFdlIGZpbmQgdGhlc2UgZnVuY3Rpb25zIGJ5IHVzaW5nIHRoZSBmb2xs
b3dpbmcgc2NyaXB0Ogo+IAo+IFdoeSB3b3VsZCB5b3UgbGlrZSB0byBrZWVwIHRoaXMgU21QTCBj
b2RlIGluIHRoZSBjb21taXQgZGVzY3JpcHRpb24/Cj4gCj4gSSB3b3VsZCBwcmVmZXIgc29mdHdh
cmUgZXZvbHV0aW9uIGluIGFuIG90aGVyIGRpcmVjdGlvbi4KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sLzQ0YmU1OTI0LTI2Y2EtNTEwNi1hYTI1LTNjYmMzMzQzYWEyY0B3ZWIuZGUvCj4g
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvNy80LzIxCj4gPiBAaW5pdGlhbGl6ZTpvY2FtbEAK
PiA+IEBACj4gPgo+ID4gbGV0IHJlbGV2YW50X3N0ciA9ICJ1c2Ugb2Zfbm9kZV9wdXQoKSBvbiBp
dCB3aGVuIGRvbmUiCj4gCj4gSSBzZWUgZnVydGhlciBwb3NzaWJpbGl0aWVzIHRvIGltcHJvdmUg
dGhpcyBkYXRhIHByb2Nlc3NpbmcgYXBwcm9hY2guCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC85MDRiOTM2Mi1jZDAxLWZmYzktNjAwYi0wYzQ4ODQ4NjE3YTBAd2ViLmRlLwo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMDk1MTY5LyMxMjkxMzc4Cj4gaHR0
cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvNi8yOC8zMjYKPiAKPiAKPiBJIGFtIG1pc3NpbmcgbW9y
ZSBjb25zdHJ1Y3RpdmUgYW5zd2VycyBmb3IgbWVudGlvbmVkIGRldmVsb3BtZW50IGNvbmNlcm5z
Lgo+IAoKTGV0IG1lIHRyeSB0byBndWVzcyB3aGF0IHlvdSBtZWFuOgoxKSwgUHJvdmlkZXMgYSBT
bVBMIEEgdGhhdCBwYXJzZXMgdGhlIGFubm90YXRpb25zIG9mIGEgcGFydGljdWxhciBrZXJuZWwg
ZmlsZSBhbmQgZXh0cmFjdHMgYSBsaXN0IG9mIGZ1bmN0aW9uIG5hbWVzIHRvIGJlIGZvbGxvd2Vk
OwoyKSwgVGhlbiBTbVBMIEEgZ2VuZXJhdGVzIGFub3RoZXIgU21QTCBCIGJhc2VkIG9uIHRoZSBm
dW5jdGlvbiBuYW1lIGxpc3Q7CjMpLCBGaW5hbGx5IFNtUEwgQSBleGVjdXRlcyBTbVBMIEIgb24g
dGhlIGVudGlyZSBrZXJuZWwgY29kZSwgbG9va2luZyBmb3IgdGhlIG1pc3Npbmcgb2Zfbm9kZV9w
dXQuCllvdSBleHBlY3QgdGhlIGVudGlyZSBwcm9jZXNzIGFib3ZlIHRvIGJlIGF1dG9tYXRlZC4K
ClRoaXMgaWRlYSBtYXkgYmUgaW50ZXJlc3RpbmcsIGJ1dCBpdCBjYW4ndCBiZSBkb25lIG5vdywg
YW5kIGl0IHdpbGwgaW50cm9kdWNlIHVuY29udHJvbGxhYmxlIGZhY3RvcnMuIAoKV2UgYWdyZWUg
d2l0aCBqdWxpYSdzIGNvbW1lbnRzOgpJIHdvdWxkIHByZWZlciBub3QgdG8gcHV0IHNlbWFudGlj
IHBhdGNoZXMgdGhhdCBpbnZvbHZlIGl0ZXJhdGlvbiBpbnRvIHRoZSBrZXJuZWwsIGZvciBzaW1w
bGljaXR5LgoKPiAKPiA+IEFuZCB0aGlzIHBhdGNoIGFsc28gbG9va3MgZm9yIHBsYWNlcyDigKYK
PiAKPiBEb2VzIGEgU21QTCBzY3JpcHQgcGVyZm9ybSBhbiBhY3Rpb24/Cj4gCgpUaGFua3MuCldl
J2xsIGNvbnRpbnVlIHRvIGltcHJvdmUgdGhlIGRlc2NyaXB0aW9uIGhlcmUuCgo+ID4gRmluYWxs
eSwgdGhpcyBwYXRjaCBmaW5kcyB1c2UtYWZ0ZXItZnJlZSBpc3N1ZXMgZm9yIGEgbm9kZS4KPiA+
IChpbXBsZW1lbnRlZCBieSB0aGUgcl91c2VfYWZ0ZXJfcHV0IHJ1bGUpCj4gCj4gVGhpcyBzb2Z0
d2FyZSBleHRlbnNpb24gaXMgYW5vdGhlciBpbnRlcmVzdGluZyBjb250cmlidXRpb24uCj4gQnV0
IEkgaW1hZ2luZSB0aGF0IGEgc2VwYXJhdGUgU21QTCBzY3JpcHQgY2FuIGJlIG1vcmUgaGVscGZ1
bCBmb3IKPiB0aGlzIHNvdXJjZSBjb2RlIHNlYXJjaCBwYXR0ZXJuLgoKV2UgZm91bmQgdGhhdCBh
ZGRpbmcgdGhlIG1pc3Npbmcgb2Zfbm9kZV9wdXQgbWF5IGNhdXNlIHVzZS1hZnRlci1mcmVlCmlm
IG5vdCBoYW5kbGVkIHByb3Blcmx5LCBzbyB3ZSBoYXZlIGFkZGVkIGEgbmV3IHJfdXNlX2FmdGVy
X3B1dCB0byBkZXRlY3QgaXQuCgpPdXIgZmlsZSBpcyBjYWxsZWQgb2Zfbm9kZV9wdXQuY29jY2ks
IHdoaWNoIGNvbnRhaW5zIHRocmVlIHJ1bGVzOiByX21pc3NfcHV0LAogcl9taXNzX3B1dF9leHQg
YW5kIHJfdXNlX2FmdGVyX3B1dC4gCklmIHlvdSBzZXBhcmF0ZSB0aGVtLCBpdCBzZWVtcyBpbmFw
cHJvcHJpYXRlLgoKPiA+IHYzOiBkZWxldGUgdGhlIGdsb2JhbCBzZXQsIOKApgo+IAo+IFRvIHdo
aWNoIHByZXZpb3VzIGltcGxlbWVudGF0aW9uIGRldGFpbCBkbyB5b3UgcmVmZXIgaGVyZT8KCkhl
cmUgaXMgYW4gaW1wcm92ZW1lbnQgYmFzZWQgb24ganVsaWEncyBjb21tZW50czoKaHR0cHM6Ly9s
a21sLm9yZy9sa21sLzIwMTkvNy81LzU1CldlIGFyZSB2ZXJ5IGdyYXRlZnVsIHRvIGhlci4gClRo
aXMgaXMgYSByZWFsLCB2YWx1YWJsZSBjb21tZW50IHRoYXQgY2FuIGJlIGFwcGxpZWQgaW4gY29k
ZSBwcmFjdGljZS4KCj4gPiArdmlydHVhbCByZXBvcnQKPiA+ICt2aXJ0dWFsIG9yZwo+ID4gKwo+
ID4gK0Bpbml0aWFsaXplOnB5dGhvbkAKPiA+ICtAQAo+ID4gKwo+ID4gK3JlcG9ydF9taXNzX3By
ZWZpeCA9ICJFUlJPUjogbWlzc2luZyBvZl9ub2RlX3B1dDsgYWNxdWlyZWQgYSBub2RlIHBvaW50
ZXIgd2l0aCByZWZjb3VudCBpbmNyZW1lbnRlZCBvbiBsaW5lICIKPiA+ICtyZXBvcnRfbWlzc19z
dWZmaXggPSAiLCBidXQgd2l0aG91dCBhIGNvcnJlc3BvbmRpbmcgb2JqZWN0IHJlbGVhc2Ugd2l0
aGluIHRoaXMgZnVuY3Rpb24uIgo+ID4gK29yZ19taXNzX21haW4gPSAiYWNxdWlyZWQgYSBub2Rl
IHBvaW50ZXIgd2l0aCByZWZjb3VudCBpbmNyZW1lbnRlZCIKPiA+ICtvcmdfbWlzc19zZWMgPSAi
bmVlZGVkIG9mX25vZGVfcHV0Igo+ID4gK3JlcG9ydF91c2VfYWZ0ZXJfcHV0ID0gIkVSUk9SOiB1
c2UtYWZ0ZXItZnJlZTsgcmVmZXJlbmNlIHByZWNlZGVkIGJ5IG9mX25vZGVfcHV0IG9uIGxpbmUg
Igo+ID4gK29yZ191c2VfYWZ0ZXJfcHV0X21haW4gPSAib2Zfbm9kZV9wdXQiCj4gPiArb3JnX3Vz
ZV9hZnRlcl9wdXRfc2VjID0gInJlZmVyZW5jZSIKPiAKPiBJZiB5b3Ugd291bGQgaW5zaXN0IG9u
IHRoZSB1c2FnZSBvZiB0aGVzZSB2YXJpYWJsZXMsIHRoZXkgc2hvdWxkIGJlIGFwcGxpZWQKPiBv
bmx5IGZvciB0aGUgc2VsZWN0ZWQgYW5hbHlzaXMgb3BlcmF0aW9uIG1vZGUuCj4gSSB3b3VsZCBl
eHBlY3QgY29ycmVzcG9uZGluZyBTbVBMIGRlcGVuZGVuY3kgc3BlY2lmaWNhdGlvbnMuCj4gaHR0
cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9ibG9iL2I0NTA5ZjZlN2ZiMDZk
NTYxNmJiMTlkZDVhMTEwYjIwM2ZkMGU1NjYvZG9jcy9tYW51YWwvY29jY2lfc3ludGF4LnRleCNM
NTU5Cj4gCgpUaGFua3MuCkhlcmUgYXJlIHNvbWUgaW1wcm92ZW1lbnRzLgoKPiA+ICtAcl9taXNz
X3B1dCBleGlzdHNACj4gPiArbG9jYWwgaWRleHByZXNzaW9uIHN0cnVjdCBkZXZpY2Vfbm9kZSAq
eDsKPiA+ICtleHByZXNzaW9uIGUsIGUxOwo+ID4gK3Bvc2l0aW9uIHAxLCBwMjsKPiA+ICtzdGF0
ZW1lbnQgUzsKPiA+ICt0eXBlIFQsIFQxOwo+ID4gK0BACj4gPiArCj4gPiArKiB4ID0gQHAxXChv
Zl9maW5kX2FsbF9ub2Rlc1x8Cj4gCj4gVGhlIHVzYWdlIG9mIHRoZSBTbVBMIGFzdGVyaXNrIGZ1
bmN0aW9uYWxpdHkgY2FuIGZpdCB0byB0aGUgb3BlcmF0aW9uIG1vZGUg4oCcY29udGV4dOKAnS4K
PiBodHRwczovL2JvdHRlc3Qud2lraS5rZXJuZWwub3JnL2NvY2NpY2hlY2sjbW9kZXMKPiBXb3Vs
ZCB5b3UgbGlrZSB0byBhZGQgYW55IGNvcnJlc3BvbmRpbmcgU21QTCBkZXRhaWxzPwo+IAo+IFVu
ZGVyIHdoaWNoIGNpcmN1bXN0YW5jZXMgd2lsbCByZW1haW5pbmcgcHJvZ3JhbW1pbmcgY29uY2Vy
bnMgYmUgY2xhcmlmaWVkCj4gZm9yIHN1Y2ggU21QTCBkaXNqdW5jdGlvbnM/CgpBZGRpbmcgYW4g
YXN0ZXJpc2sgaGVyZSBpcyBtb3JlIGNvbnZlbmllbnQgdG8gdXNlLCAKaXQgY2FuIG1hcmsgdGhl
IGxvY2F0aW9uIG9mIHRoZSBjb2RlIG9mIGludGVyZXN0LCBzdWNoIGFzOgoKJCAvdXNyL2xvY2Fs
L2Jpbi9zcGF0Y2ggLUQgcmVwb3J0ICAtLWNvY2NpLWZpbGUgc2NyaXB0cy9jb2NjaW5lbGxlL2Zy
ZWUvb2Zfbm9kZV9wdXQuY29jY2kgYXJjaC9hcm0vbWFjaC1heHhpYS9wbGF0c21wLmMgCmluaXRf
ZGVmc19idWlsdGluczogL3Vzci9sb2NhbC9iaW4vLi4vbGliL2NvY2NpbmVsbGUvc3RhbmRhcmQu
aApIQU5ETElORzogYXJjaC9hcm0vbWFjaC1heHhpYS9wbGF0c21wLmMKYXJjaC9hcm0vbWFjaC1h
eHhpYS9wbGF0c21wLmM6NDM6Mi04OiBFUlJPUjogbWlzc2luZyBvZl9ub2RlX3B1dDsgYWNxdWly
ZWQgYSBub2RlIHBvaW50ZXIgd2l0aCByZWZjb3VudCBpbmNyZW1lbnRlZCBvbiBsaW5lIDM3LCBi
dXQgd2l0aG91dCBhIGNvcnJlc3BvbmRpbmcgb2JqZWN0IHJlbGVhc2Ugd2l0aGluIHRoaXMgZnVu
Y3Rpb24uCmFyY2gvYXJtL21hY2gtYXh4aWEvcGxhdHNtcC5jOjUwOjEtNzogRVJST1I6IG1pc3Np
bmcgb2Zfbm9kZV9wdXQ7IGFjcXVpcmVkIGEgbm9kZSBwb2ludGVyIHdpdGggcmVmY291bnQgaW5j
cmVtZW50ZWQgb24gbGluZSAzNywgYnV0IHdpdGhvdXQgYSBjb3JyZXNwb25kaW5nIG9iamVjdCBy
ZWxlYXNlIHdpdGhpbiB0aGlzIGZ1bmN0aW9uLgpkaWZmID0gCi0tLSBhcmNoL2FybS9tYWNoLWF4
eGlhL3BsYXRzbXAuYworKysgL3RtcC9jb2NjaS1vdXRwdXQtMTMwMjYtODhmM2ExLXBsYXRzbXAu
YwpAQCAtMzQsMjAgKzM0LDE3IEBAIHN0YXRpYyBpbnQgYXh4aWFfYm9vdF9zZWNvbmRhcnkodW5z
aWduZWQKIAl2b2lkIF9faW9tZW0gKnN5c2NvbjsKIAl1MzIgdG1wOwoKLQlzeXNjb25fbnAgPSBv
Zl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAibHNpLGF4eGlhLXN5c2NvbiIpOwog
CWlmICghc3lzY29uX25wKQogCQlyZXR1cm4gLUVOT0VOVDsKCiAJc3lzY29uID0gb2ZfaW9tYXAo
c3lzY29uX25wLCAwKTsKIAlpZiAoIXN5c2NvbikKLQkJcmV0dXJuIC1FTk9NRU07CgogCXRtcCA9
IHJlYWRsKHN5c2NvbiArIFNDX1JTVF9DUFVfSE9MRCk7CiAJd3JpdGVsKDB4YWIsIHN5c2NvbiAr
IFNDX0NSSVRfV1JJVEVfS0VZKTsKIAl0bXAgJj0gfigxIDw8IGNwdSk7CiAJd3JpdGVsKHRtcCwg
c3lzY29uICsgU0NfUlNUX0NQVV9IT0xEKTsKCi0JcmV0dXJuIDA7CiB9Ci4uLgoKSW4gYWRkaXRp
b24gdG8gcmVhZGluZyB0aGUgZG9jdW1lbnRhdGlvbiwKeW91IG1heSBhbHNvIG5lZWQgdG8gZG8g
c29tZSBleHBlcmltZW50cyB5b3Vyc2VsZi4KVGhhbmsgeW91LgoKLS0KUmVnYXJkcywKV2VuCgo+
ID4gKy4uLiB3aGVuICE9IGUgPSAoVCl4Cj4gPiArICAgIHdoZW4gIT0gdHJ1ZSB4ID09IE5VTEwK
PiAKPiBXaWxsIGFzc2lnbm1lbnQgZXhjbHVzaW9ucyBnZXQgYW55IG1vcmUgc29mdHdhcmUgZGV2
ZWxvcG1lbnQgYXR0ZW50aW9uPwo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMDNjYzRk
ZjUtY2U3Zi1iYTkxLTM2YjUtNjg3ZmVjOGM3Mjk3QHdlYi5kZS8KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTA5NTE2OS8jMTI5MTg5Mgo+IGh0dHBzOi8vbGttbC5v
cmcvbGttbC8yMDE5LzYvMjkvMTkzCj4gCj4gCj4gPiArICAgIHdoZW4gIT0gb2Zfbm9kZV9wdXQo
eCkKPiDigKYKPiA+ICspCj4gPiArJgo+ID4gK3ggPSBmKC4uLikKPiA+ICsuLi4KPiA+ICtpZiAo
PCsuLi54Li4uKz4pIFMKPiA+ICsuLi4KPiA+ICtvZl9ub2RlX3B1dCh4KTsKPiA+ICspCj4gCj4g
WW91IHByb3Bvc2Ugb25jZSBtb3JlIHRvIHVzZSBhIFNtUEwgY29uanVuY3Rpb24gaW4gdGhlIHJ1
bGUg4oCccl9taXNzX3B1dF9leHTigJ0uCj4gSSBhbSBhbHNvIHN0aWxsIHdhaXRpbmcgZm9yIGEg
ZGVmaW5pdGl2ZSBleHBsYW5hdGlvbiBvbiB0aGUgYXBwbGljYWJpbGl0eQo+IG9mIHRoaXMgY29t
YmluYXRpb24uCj4gCj4gCj4gPiArQHJfcHV0QAo+ID4gK2V4cHJlc3Npb24gRTsKPiA+ICtwb3Np
dGlvbiBwMTsKPiA+ICtAQAo+ID4gKwo+ID4gKyogb2Zfbm9kZV9wdXRAcDEoRSkKPiAKPiBJIGd1
ZXNzIHRoYXQgdGhpcyBTbVBMIGNvZGUgd2lsbCBuZWVkIGZ1cnRoZXIgYWRqdXN0bWVudHMuCj4g
Cj4gCj4gPiArQHJfdXNlX2FmdGVyX3B1dCBleGlzdHNACj4gPiArZXhwcmVzc2lvbiByX3B1dC5F
LCBzdWJFPD1yX3B1dC5FOwo+IAo+IEkgaGF2ZSBnb3QgYW4gdW5kZXJzdGFuZGluZyBkaWZmaWN1
bHR5IGFyb3VuZCB0aGUgaW50ZXJwcmV0YXRpb24KPiBvZiB0aGUgc2hvd24gU21QTCBjb25zdHJh
aW50Lgo+IEhvdyB3aWxsIHRoZSBjbGFyaWZpY2F0aW9uIGJlIGNvbnRpbnVlZD8KPiAKPiBSZWdh
cmRzLAo+IE1hcmt1cw==


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

