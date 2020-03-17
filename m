Return-Path: <SRS0=qWDJ=5C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31D7C10F29
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 10:04:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B74F205ED
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 10:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yUge6lqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B74F205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02HA4183012134;
	Tue, 17 Mar 2020 11:04:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 79C6D7808;
	Tue, 17 Mar 2020 11:04:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4EB403B93
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 11:03:59 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02HA3vZc013438
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 11:03:58 +0100 (CET)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 34113205ED;
 Tue, 17 Mar 2020 10:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584439436;
 bh=3oukVbkDCC1ZnviMpCKaL3jr7lAzIEZ7rEPJY9/SDz4=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=yUge6lqqzy5U4PupB+UNdySETACVCkXszXQa/RAlqnO23F7yt4Doj2YhaZLsgMy27
 RTv8NnZDm1Ud496RE/yW41BIhkR5BFfZOQj2fGAHY22Rr6DsHo9xbIRPkiIiAOKkny
 jZmK/LTh3sAsg/FlRNS6uw8otQAZwQ81EbfqpW0E=
Date: Tue, 17 Mar 2020 11:03:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr,
        linux-kernel-mentees@lists.linuxfoundation.org
Message-ID: <20200317100354.GA1089518@kroah.com>
References: <537c752c-009b-1fa7-4bdd-c294790d453a@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <537c752c-009b-1fa7-4bdd-c294790d453a@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 17 Mar 2020 11:04:01 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 17 Mar 2020 11:03:58 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] [Linux-kernel-mentees] [v2 05/26] parsing_cocci:
 visitor_ast: Add cases for ParenType/FunctionType
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

T24gVHVlLCBNYXIgMTcsIDIwMjAgYXQgMTA6MzQ6MDhBTSArMDEwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6Cj4gPiBDaGFuZ2VzIGluIHYyOgo+ID4g4oCmCj4gPiAtIENoYW5nZSB0aGUgInZpc2l0
b3JfYXN0MCIgaW4gcGF0Y2ggc3ViamVjdCB0byAidmlzaXRvcl9hc3QiCj4gCj4gVGhhbmtzIGZv
ciBzdWNoIGEgc29mdHdhcmUgdXBkYXRlLgo+IAo+IEkgc3VnZ2VzdCB0byByZWNvbnNpZGVyIHRo
ZSBwYXRjaCBncmFudWxhcml0eSBvbmNlIG1vcmUuCj4gV291bGQgeW91IGxpa2UgdG8gcmVkdWNl
IHRoZSBwb3NzaWJpbGl0aWVzIGZvciBjb25mdXNpb24gYXJvdW5kCj4gdGhlIHByZXNlbnRlZCBz
b2Z0d2FyZSB0cmFuc2Zvcm1hdGlvbj8KCk9uZSBvZiB0aGUgaGFyZGVzdCB0aGluZ3MgaW4gZGVh
bGluZyB3aXRoIGEgY29tbXVuaXR5IGlzIHRvIGxlYXJuIHdobyB0bwppZ25vcmUgd2hlbiBpdCBj
b21lcyB0byBwYXRjaCByZXZpZXdzIGFuZCBjb21tZW50cy4gIEp1c3QgYSBmcmllbmRseQpyZW1p
bmRlciB0aGF0IHRoaXMgcGVyc29uIGlzIG9uIG1hbnkgdXBzdHJlYW0ga2VybmVsIGRldmVsb3Bl
cidzCmVtYWlsLWJsb2NrIGxpc3RzIGR1ZSB0byB0aGUgYWJpbGl0eSB0byBjYXVzZSBodWdlIHRp
bWUtc2lua3MgZm9yIG5vCnZhbGlkIHJlYXNvbi4KCkkgc3VnZ2VzdCB0aGF0IG90aGVycyBkbyB0
aGUgc2FtZSBhcyB3ZWxsLgoKdGhhbmtzIQoKZ3JlZyBrLWgKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3Rl
bWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2Np
Cg==
