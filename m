Return-Path: <SRS0=ZbCT=R5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B043C43381
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 10:12:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016682075D
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 10:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lij5X2WX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016682075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2QABl0r026220
          ; Tue, 26 Mar 2019 11:11:47 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BCD707725;
	Tue, 26 Mar 2019 11:11:47 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BABF17711
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 11:11:46 +0100 (CET)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2QABjPM013479
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 11:11:45 +0100 (CET)
X-pt: isis.lip6.fr
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2QA90Uw038277;
 Tue, 26 Mar 2019 10:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=AB0YaICaasoYS0X63qlpptAXq48WFU6qakXfDgTD7bM=;
 b=Lij5X2WXmkW5XGP+e5GIbKmuFSEOszD8p+YLc+15+A2XpGVK6nLOickJ4fACex1ANrtf
 GlAdIqkLwqSIp4+t+9gyuNEXtnLILKMXwkMSKL628DAHYF6CuYyy5evnJdxPs4OasLkr
 8v/0AUIFV77EFMJf4JcpIlMExLvHuH6+TgS4lX+yBBcfvPq0V2kJ87TtKluN5WjQlAIg
 htGO1oa5AO7IOu+jEl+v00YnXoiqlFsA70J9XSoMketbl5Cr2jd64D88CkRQUhvt5m0z
 IcSPzNZVfb6HK+Be94s/aVJYqxj7eNqxhXhTUoJKup6rwGwi3Jv4nb5WGMq2MniKpSgH 1Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by userp2130.oracle.com with ESMTP id 2re6g11cee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Mar 2019 10:11:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2QABMqF010715
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Mar 2019 10:11:23 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2QABF8T029198;
 Tue, 26 Mar 2019 10:11:17 GMT
Received: from kadam (/197.157.0.51) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 26 Mar 2019 03:11:15 -0700
Date: Tue, 26 Mar 2019 13:11:04 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190326101103.GH32613@kadam>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <179bbdd1-3fcb-bba5-52b3-7f96973c7650@web.de>
 <alpine.DEB.2.21.1903232104030.5660@hadrien>
 <20190326084512.GC32590@kadam>
 <alpine.DEB.2.20.1903261037320.5021@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1903261037320.5021@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260076
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 Mar 2019 11:11:48 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 26 Mar 2019 11:11:46 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        kernel-janitors@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Markus Elfring <Markus.Elfring@web.de>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [Cocci] [PATCH] coccinelle: put_device: reduce false positives
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

T24gVHVlLCBNYXIgMjYsIDIwMTkgYXQgMTA6Mzg6NDNBTSArMDEwMCwgSnVsaWEgTGF3YWxsIHdy
b3RlOgo+IAo+IAo+IE9uIFR1ZSwgMjYgTWFyIDIwMTksIERhbiBDYXJwZW50ZXIgd3JvdGU6Cj4g
Cj4gPiBPbiBTYXQsIE1hciAyMywgMjAxOSBhdCAwOTowNjo1NFBNICswMTAwLCBKdWxpYSBMYXdh
bGwgd3JvdGU6Cj4gPiA+Cj4gPiA+Cj4gPiA+IE9uIFNhdCwgMjMgTWFyIDIwMTksIE1hcmt1cyBF
bGZyaW5nIHdyb3RlOgo+ID4gPgo+ID4gPiA+ID4gRG9uJ3QgY29tcGxhaW4gYWJvdXQgYSByZXR1
cm4gd2hlbiB0aGlzIGZ1bmN0aW9uIHJldHVybnMgIiZwZGV2LT5kZXYiLgo+ID4gPiA+Cj4gPiA+
ID4gV291bGQgdGhpcyBpbmZvcm1hdGlvbiBxdWFsaWZ5IHRvIGFkZCB0aGUgdGFnIOKAnEZpeGVz
4oCdIHRvIHRoZSBjb21taXQgbWVzc2FnZT8KPiA+ID4KPiA+ID4gRml4ZXMgdGFncyByZWxhdGUg
dG8gc3RhYmxlIGtlcm5lbHMsIHNvIHRoYXQgb25lIGNhbiBzZWUgd2hpY2ggc3RhYmxlCj4gPiA+
IGtlcm5lbHMgYSBwYXJ0aWN1bGFyIHBhdGNoIHNob3VsZCBiZSBwcm9wYWdhdGVkIHRvLiAgVGhl
cmUgaXMgbm8gbmVlZCB0bwo+ID4gPiBwcm9wYWdhdGUgcGF0Y2hlcyBvbiBzZW1hbnRpYyBwYXRj
aGVzIHRvIHN0YWJsZSBrZXJuZWxzLiAgUGVvcGxlIHdobyBydW4KPiA+ID4gc3RhYmxlIGtlcm5l
bHMgYXJlIGludGVyZXN0ZWQgaW4gdGhlaXIgYmVoYXZpb3IsIG5vdCB0aGUgYnVnIGZpbmRpbmcK
PiA+ID4gcnVsZXMgdGhhdCB0aGV5IGNvbnRhaW4uCj4gPgo+ID4gVGhlIEZpeGVzIHRhZyBpcyBu
b3QganVzdCBhYm91dCBzdGFibGUuLi4gIEZvciBleGFtcGxlLCB3ZSB1c2UgdGhlbSBmb3IKPiA+
IHN0YXRpc3RpY3MgdG8gc2VlIGhvdyBxdWlja2x5IGJ1Z3MgZ2V0IGZpeGVkIGV0Yy4KPiAKPiBP
Sy4gIEJ1dCBzdGlsbCBkbyB3ZSBuZWVkIGZpeGVzIHRhZ3MgZm9yIGJ1ZyBmaW5kaW5nIHJ1bGVz
PyAgUGVyaGFwcyBpZgo+IHRoZSBwcmV2aW91cyB2ZXJzaW9uIHdhcyByZWFsbHkgYnJva2VuLCBh
bmQgaXQgd291bGQgYmUgcmVhbGx5IHVuZGVzaXJhYmxlCj4gdG8gdXNlIGl0LgoKSXQncyBub3Qg
d29ydGggcmVzZW5kaW5nIGEgcGF0Y2ggZm9yIHRoYXQsIGJ1dCBJIHByb2JhYmx5IHdvdWxkIHVz
ZSB0aGUKZml4ZXMgdGFnLiAgSXQgZGVwZW5kcyBvbiB5b3VyIGRlZmluaXRpb24gb2YgImJ1ZyIg
cmVhbGx5Li4uICBJIHRlbGwKcGVvcGxlIG5vdCB0byB1c2UgRml4ZXMgZm9yIHNwZWxsaW5nIG1p
c3Rha2VzIGFuZCB1bnVzZWQgdmFyaWFibGVzLiAgQnV0CkkgZG8gdXNlIHRoZSBGaXhlcyB0YWcg
Zm9yIHRoaW5ncyBsaWtlICJhbiBvZmYgYnkgb25lIGluIGEgc2FuaXR5IGNoZWNrCndoaWNoIGRv
ZXNuJ3QgYWZmZWN0IHJ1biB0aW1lIGJlY2F1c2UgdGhlIGluZGV4IGlzIGFsd2F5cyBjb3JyZWN0
Ii4KCnJlZ2FyZHMsCmRhbiBjYXJwZW50ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5m
cgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
