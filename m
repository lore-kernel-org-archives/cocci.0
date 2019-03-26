Return-Path: <SRS0=ZbCT=R5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E52BC43381
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 08:46:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847D420856
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 08:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TBE+c2Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847D420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2Q8jpSq025676
          ; Tue, 26 Mar 2019 09:45:51 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AD4ED7725;
	Tue, 26 Mar 2019 09:45:51 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B97247711
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 09:45:49 +0100 (CET)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2Q8jmA6013730
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 09:45:48 +0100 (CET)
X-pt: isis.lip6.fr
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q8hp7P166651;
 Tue, 26 Mar 2019 08:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=3U0zNVC0lsiCPw7uX8AGQ0P64csD1XLhYs6Pbs0Lzu4=;
 b=TBE+c2RlEdMzZ5yq+N8rdn1JykFiy1t3XjVBBtI6Xbgg1MxzFR5k4omO74oZmilJO/Rh
 tnCO1nLRqbFxuX4f8GRLy1bMarte09V2o3+uLDW83ri6W8aiHPLvq69Nw/Sp2qN9k9E8
 AbOQkD5qxOErmTLuKAavpTWgzYpVUgxRRRKdCh0PDoAbBkbXLvQPzbjVAWf9/qTNQbFE
 X/v0J30VK/RQEWp6ARgCs0E2RsCBbaJK1Qb/V/sqIiHNdNnO99pgpQ3XoOpwpkvgBwxC
 Niq2cqEgws8dQGHOHmdYs007LLh2FShOyZFnR6gKrLFF3f6dkhWqZ3aji/3v+Xw/dQsJ vw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by userp2120.oracle.com with ESMTP id 2re6dj908m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Mar 2019 08:45:32 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q8jUqa025403
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Mar 2019 08:45:30 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2Q8jPNv023446;
 Tue, 26 Mar 2019 08:45:25 GMT
Received: from kadam (/197.157.0.51) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 26 Mar 2019 01:45:24 -0700
Date: Tue, 26 Mar 2019 11:45:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190326084512.GC32590@kadam>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <179bbdd1-3fcb-bba5-52b3-7f96973c7650@web.de>
 <alpine.DEB.2.21.1903232104030.5660@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903232104030.5660@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=861 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260066
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 Mar 2019 09:45:52 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 26 Mar 2019 09:45:49 +0100 (CET)
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

T24gU2F0LCBNYXIgMjMsIDIwMTkgYXQgMDk6MDY6NTRQTSArMDEwMCwgSnVsaWEgTGF3YWxsIHdy
b3RlOgo+IAo+IAo+IE9uIFNhdCwgMjMgTWFyIDIwMTksIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgo+
IAo+ID4gPiBEb24ndCBjb21wbGFpbiBhYm91dCBhIHJldHVybiB3aGVuIHRoaXMgZnVuY3Rpb24g
cmV0dXJucyAiJnBkZXYtPmRldiIuCj4gPgo+ID4gV291bGQgdGhpcyBpbmZvcm1hdGlvbiBxdWFs
aWZ5IHRvIGFkZCB0aGUgdGFnIOKAnEZpeGVz4oCdIHRvIHRoZSBjb21taXQgbWVzc2FnZT8KPiAK
PiBGaXhlcyB0YWdzIHJlbGF0ZSB0byBzdGFibGUga2VybmVscywgc28gdGhhdCBvbmUgY2FuIHNl
ZSB3aGljaCBzdGFibGUKPiBrZXJuZWxzIGEgcGFydGljdWxhciBwYXRjaCBzaG91bGQgYmUgcHJv
cGFnYXRlZCB0by4gIFRoZXJlIGlzIG5vIG5lZWQgdG8KPiBwcm9wYWdhdGUgcGF0Y2hlcyBvbiBz
ZW1hbnRpYyBwYXRjaGVzIHRvIHN0YWJsZSBrZXJuZWxzLiAgUGVvcGxlIHdobyBydW4KPiBzdGFi
bGUga2VybmVscyBhcmUgaW50ZXJlc3RlZCBpbiB0aGVpciBiZWhhdmlvciwgbm90IHRoZSBidWcg
ZmluZGluZwo+IHJ1bGVzIHRoYXQgdGhleSBjb250YWluLgoKVGhlIEZpeGVzIHRhZyBpcyBub3Qg
anVzdCBhYm91dCBzdGFibGUuLi4gIEZvciBleGFtcGxlLCB3ZSB1c2UgdGhlbSBmb3IKc3RhdGlz
dGljcyB0byBzZWUgaG93IHF1aWNrbHkgYnVncyBnZXQgZml4ZWQgZXRjLgoKcmVnYXJkcywKZGFu
IGNhcnBlbnRlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3Rl
bWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
