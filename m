Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D3EC433E0
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 07:45:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09D621475
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 07:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+aoy4Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09D621475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05H7iih6001391;
	Wed, 17 Jun 2020 09:44:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EADFD7577;
	Wed, 17 Jun 2020 09:44:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7B1BE3D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 09:44:42 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:634])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05H7idg8019783
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 09:44:40 +0200 (CEST)
Received: by mail-pl1-x634.google.com with SMTP id x11so535217plo.7
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=PM9lqne/sFigqMHj6jeg3zvEeUR4bt3TlqnaeTfflqE=;
 b=A+aoy4Dx2lVRsjc/yrQov8xkVhzvqMMRAPLvo3m8Q/BOMjBat+cmiQ4jCA9Rk3gRW7
 D0yF6SfFLOeBUUYrkOosAXzisodF64b7DzQ4zmWHEsARz9pSvHlEYpkgt6yifOpMW1q5
 4bugwQwAX4bpxCK3zTBjXYF1fxlfbyXZ2lwm79cOGzXIArcKYfV11Dei/bQsOTSYsKbT
 +wBnsfoyquWNRQN8fC76ZyHqUtMAAo6md7ulyTYQm+afhrTuNeIC0F0JrNY6QnjWifpf
 ErcRL46V7QXbrKqt8pHAsFbRRtIA99o4WMkCLSQ3BFRlMCVzBMhu6MabXQZsQzTPWcwQ
 28+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=PM9lqne/sFigqMHj6jeg3zvEeUR4bt3TlqnaeTfflqE=;
 b=DvJ/3M1fI1kNAnnORSijTCczGGJb+01po7hTXWbrisluYjfuRTy6gnYOI11GTIIKbC
 Tw6sjfA45IxaJH3CZRLAVZuLC/ov352QaG1IEI8TioTqudfbGOBmg0MzsYhaoxkeAHo7
 yOnGMVc8W6uvLY5PDBgtvx7fvvG8VVPqpiwvS3un27xYh2wwkhvpSuYLVp9JVgvWl6WR
 Rn+SKjdVApR/mjy5L8ZxCTPDgS+dY6mjQJSLCha+Dmipm8tVdEhv2CxoOscGPO30jRP4
 cyaE6qQHnjBQchaLEPbV6tNTw73TeXFTUBJAmrjyWi/3jUnYxuCVhNftmXZC77Su32LU
 5kBw==
X-Gm-Message-State: AOAM532r0DGiSb59HcKjOXSdjmzoKHS41UDoiDLTlu1LNiTr08STcpV/
 o54z6pZ1HwIYglFd3gpzpR8=
X-Google-Smtp-Source: ABdhPJxVWDxoW+ivnD1i+cWZ7Z0zmclK5YF/UkW8J7qB5Qgi4GVCdMJ51C8WrGXqPYLmFwaLry470w==
X-Received: by 2002:a17:90a:db91:: with SMTP id
 h17mr6571011pjv.6.1592379878657; 
 Wed, 17 Jun 2020 00:44:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1869:44d7:d31c:86d3:db1:2cdc])
 by smtp.gmail.com with ESMTPSA id p16sm16350830pgj.53.2020.06.17.00.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:44:37 -0700 (PDT)
Message-ID: <e6a9456615df93634d86eb342a3282809fa62acd.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Date: Wed, 17 Jun 2020 13:14:33 +0530
In-Reply-To: <15347e89-21a9-8e08-8301-fef957c7332a@web.de>
References: <37e4e561-8d88-263a-0037-f58cb8c1861e@web.de>
 <CALOnNCpr_-1BLPN+Bayof6XjLLvVrMgR4Z+EHpC_8RnAOWiD0Q@mail.gmail.com>
 <15347e89-21a9-8e08-8301-fef957c7332a@web.de>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 09:44:44 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 17 Jun 2020 09:44:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Software analysis around data type annotations
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

T24gV2VkLCAyMDIwLTA2LTE3IGF0IDA5OjMwICswMjAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToK
PiA+IEknbSBhd2F5IGZyb20gbXkgY29tcHV0ZXIgcmlnaHQgbm93IHNvIGNhbid0IHRlc3QgdGhp
cywgYnV0IHRyeQo+ID4gZGVjbGFyaW5nIF9faW9tZW0gYXMgYW4gYXR0cmlidXRlOgo+IAo+IEBk
aXNwbGF5QAo+IGF0dHJpYnV0ZSBuYW1lIF9faW9tZW07Cj4gaWRlbnRpZmllciBhY3Rpb247Cj4g
QEAKPiAqdm9pZCBfX2lvbWVtICogYWN0aW9uKC4uLikKPiAgeyAuLi4gfQo+IAo+IAo+IGVsZnJp
bmdAU29ubmU6fi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0b3I+IHNwYXRjaCAtLXBhcnNlLWNv
Y2NpCj4gc2hvd19pb21lbV9mdW5jdGlvbnMyLmNvY2NpCj4g4oCmCj4gbWludXM6IHBhcnNlIGVy
cm9yOgo+ICAgRmlsZSAic2hvd19pb21lbV9mdW5jdGlvbnMyLmNvY2NpIiwgbGluZSA1LCBjb2x1
bW4gMTQsIGNoYXJwb3MgPSA3MAo+ICAgYXJvdW5kID0gJyonLAo+ICAgd2hvbGUgY29udGVudCA9
ICp2b2lkIF9faW9tZW0gKiBhY3Rpb24oLi4uKQo+IAo+IAo+IFRlc3QgdmVyc2lvbjogMS4wLjgt
MDAxMzEtZzY3NWI5NjcwCj4gCgpIbSwgb2theSB0aGlzIGlzIGR1ZSB0byBhIGNlcnRhaW4gcXVp
cmsgaW4gdGhlIFNtUEwgcGFyc2VyLCB3L3IvdApwb2ludGVycy4gSSBkb24ndCB0aGluayBpdCB3
YXMgYSBiaWcgZGVhbCBiZWZvcmUsIGJ1dCBub3cgaXQgbWlnaHQgYmUKZHVlIHRvIGF0dHJpYnV0
ZXMuLi4KCk9uY2UgSSdtIGRvbmUgd2l0aCB3aGF0IEknbSB3b3JraW5nIG9uIHJpZ2h0IG5vdyBJ
J2xsIGdldCBhcm91bmQgdG8KdGhpcy4gTWVhbndoaWxlLCB5b3UgY291bGQgZG8gdGhlIGZvbGxv
d2luZzoKCkBkaXNwbGF5QAphdHRyaWJ1dGUgbmFtZSBfX2lvbWVtOwppZGVudGlmaWVyIGFjdGlv
bjsKQEAKKnZvaWQgKiBfX2lvbWVtIGFjdGlvbiguLi4pCiB7Li4ufQoKSXQncyBub3QgcXVpdGUg
aW4gbGluZSB3aXRoIHRoZSB3aGF0LXlvdS1zZWUtaXMtd2hhdC15b3UtZ2V0IHByaW5jaXBsZSwK
YnV0IGl0J2xsIHdvcmsgZm9yIHlvdXIgdXNlIGNhc2UuCgo+IAo+IEhvdyBtYW55IHNvZnR3YXJl
IGRldmVsb3BtZW50IHJlc291cmNlcyB3aWxsIGJlIG5lZWRlZAo+IHRvIGdldCBzdWNoIFNtUEwg
c2NyaXB0IHZhcmlhbnRzIHRvIHdvcms/Cj4gCgpQbGVhc2Ugc3RvcCBhc2tpbmcgc3VjaCBxdWVz
dGlvbnMgYW5kIEknbGwgYmUgaGFwcHkgdG8gaGVscCB5b3Ugb3V0LgoKQ2hlZXJzLApKYXNrYXJh
bi4KCj4gUmVnYXJkcywKPiBNYXJrdXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIK
aHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
