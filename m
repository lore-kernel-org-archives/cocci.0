Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4C7C369C2
	for <cocci@archiver.kernel.org>; Fri, 25 Apr 2025 21:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jO2+GyKL5oezjn1H8L3eX3s9wAM8OzFuG2Bk4Q1O5IY=;
  b=p1QKU4Rqy4zNzSjcI6tS03V9fB61YJg+DJAkkaouIuYeylimpJDPRnQ7
   nNkXLwrpvnq4XvO3mr5Ev6rFX/X1WAV/ynMaVG2gCxl0gB7++8P3tWygR
   gyKvNRRcuNnZYqsdIDFBfBKdNSBkzynPss5dTa54dqIwJ0KvOB1oBjXNf
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@messagingengine.com
X-IronPort-AV: E=Sophos;i="6.15,240,1739833200"; 
   d="cpp'?scan'208";a="219526333"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Apr 2025 23:57:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F29B3E0D1D; Fri, 25 Apr 2025 23:57:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D724DE007A
	for <cocci@sympa.inria.fr>; Fri, 25 Apr 2025 23:57:50 +0200 (CEST)
IronPort-SDR: 680c055e_+Ju+q0x2UOeObc5cEAgY38bF3QhxTM7R42w60Sl5knelbGZ
 gXlVSmCPA115dzgiE4GJQOf6NsIhu7R7myaQlzQ==
X-IPAS-Result: =?us-ascii?q?A0ECBACdBAxoj5WsqGdaH4I/gkKBVjQHCEiEVYh7iHaEP?=
 =?us-ascii?q?pN9h1kIBwEDAQ1EBAEBAwSQMgIfBgEENQUNAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQECOgVJhXsNgluBLIEmAQEBAQEBAQEBAQEBHQIIJ?=
 =?us-ascii?q?D8BSAQZAQE4XAIEbwEBgn4Bgi8BAzECsER/M4EBggwBAQaCaddyAUsDdoFeB?=
 =?us-ascii?q?wmBSoVsglgLAYVsG4UDD4FVRIE8g0GIHhmCUIIxRVKeToFpA1ksAVUTFwsHB?=
 =?us-ascii?q?YFpA4EPbjMdRoIEhSWCD4IEiQ+EUi1PhTKBHB02CgIBC209NwkLGwaXG4NnB?=
 =?us-ascii?q?nwTAQpBlT6RRg+hMDQHhB4FgVkGDIRtgzGXQAYTL5dEkxMumFCpNYF/IoFcT?=
 =?us-ascii?q?XOCZ08DGQ+OLQ0Jg16BMrEARDI8AgcLAQEDCZAcgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:UcEKVq/CWP0kZdsSO2puk+AfI+orL9Y04lQ7vn2ZOiYlCfBw9v
 re+cjzsCWY5Ar5N0tQ/uxoR5PwIk80maQFmbX5Xo3SOjUO2lHYSL2KhLGKq1aLak/DH4VmpN
 pdmsZFeafN5BRB/L/HyTj9N/pl+cKA4bDAv4fj5kYoaS0vUrpn/hc8IA6GCEEefmh7LKt8ML
 bZ3cZMqzq+dXl/VKqGL0hAe8SGndHNmZ78CCRoOyIa
X-Talos-CUID: 9a23:lDR8CGAuIx2EZwH6Ew9L/lYVE84iSSDywm/AEX+YAn83Y6LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AMh906QzRp6EU4sP4kyYsdXhc9iSaqITzNWRcz80?=
 =?us-ascii?q?egdGNFS5BfBuhnjfwWqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,240,1739833200"; 
   d="cpp'?scan'208";a="219526330"
X-MGA-submission: =?us-ascii?q?MDE3YV5DLLFZhff5idvpBE1x9iHgKujzh2lf8o?=
 =?us-ascii?q?WocEt2tBlIPBuu6QvyKQ83gpbdkhJUuRaLqKu7F2eAW6w9QjXIE1Qxpr?=
 =?us-ascii?q?02kvzVCEiogUziqwgLDtnqLd3hNJokyeu76nsAER7zutvU8mgSdpNs0/?=
 =?us-ascii?q?Usv3bam6Yytq3hdpgrqa5Usg=3D=3D?=
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 23:57:49 +0200
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 90182138051E
	for <cocci@inria.fr>; Fri, 25 Apr 2025 17:57:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 17:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1745618266; x=1745704666; bh=jO2+GyKL5oezjn1H8L3eX3s9wAM8OzFu
	G2Bk4Q1O5IY=; b=VpKnsIyfpPRiTcP9MD9+UNl9FdBAfYPqndxfKL9BPBr70SeE
	54lhb74qOD1W8VILsXV50yRLfjxILHQubNywVvdKwHzXlTazGHVIG5pwOc1sEJ29
	ns1QQnr0EcJ4CZ8xYCrhCT4SlbX/QDEAn7xhKXMVEs/kmYuYSzgoI/+gxijOLgF+
	QrqQ+pxP48Q/4YmRWuf/W+LnDt1Y1oJjn4DvRHl/oREmjZlufhNdsqYCTx6tSs29
	Mo1J5vLnP59z9yf1J9pFFA5jrTjErZ7sOPrQCZiiyWA+InruTdL1Lkb1anb3xbaS
	Ge8MGiKBpBafF/fJC6Vc7NgwVNOEmTkFb0v6WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745618266; x=
	1745704666; bh=jO2+GyKL5oezjn1H8L3eX3s9wAM8OzFuG2Bk4Q1O5IY=; b=m
	5Ycm/Ll+oClaBSicPI38qjohyLY3EotTlcfcw7G+AO49cX/LIkcFm5FLWLeHs0Ju
	RpaVcaotHVr5/iXVYuAi8h0e6cvCUj9pvyeMoJEx2k9IUN6gvt/0m2foBX0XXToZ
	DIBYXAX9ar5j71JwXIDwEfyK17JikBz9bPp4/oaaxAgoxhzi223Sh4HmaLBCE2Kg
	knGQq+Wl+ByI+Ro7CflMTO6ra0QOqHzr7LyEsabnKC10tuGR1ApwhfAxLmTKm17s
	9sFeaOd92m0EwypeHYQbdbMtsoyZjfAbvxJ5TW8eSultsMVWPrwgUS44tkoZXjLp
	KwS/pl6TeDN8k/mSaRjZA==
X-ME-Sender: <xms:WgUMaD_639jSQnrRzQ6r90RbdEPX9p9d-SLxwZ_P04PGA4qD0WDbiQ>
    <xme:WgUMaPtCPC6Znl3O56BMsWd5dGoU10MpoBg176BMoYw1ZIAH51oLaayBBop5-uGQC
    klFcv8TeHhpgCAz>
X-ME-Received: <xmr:WgUMaBBfmjQnsNPzT9N4tAsh-QnLRUXQe__Kk_1ogJMVWn6LIYjubCbk8MrP_GDWJdcIC-gEPjiYg8aNryBfbNuCB7wyF0OX6cbOUpqeLGnXMNy-uiTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpegtkf
    ffgggfhffvufesmhdtreertddvjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhht
    uceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrg
    htthgvrhhnpeejudfhieeuveetfeegudduvdfghedutdeiffdvhfehkeehgeehkedvhfff
    heffheenucffohhmrghinhepthihphgvpggtrdhmlhgspdhthihpvggptgdrmhhlnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-ME-Proxy: <xmx:WgUMaPdFxt400Ik0mLZx9HbJihdZTw3op1pclRX1hxUcOwNCYifvsA>
    <xmx:WgUMaIN4P-sHIkLyCtN3g1RioEGv7aaytdDtoKk0lEk1wpFsNy8GIg>
    <xmx:WgUMaBme9mNxnIUQ8DNKSTerx6WPVElCGIeABLTQHPmkUKExWD3LZQ>
    <xmx:WgUMaCtYtQEABW7SRkTjMvO-0g2kspH_BbJwMf4DcYYCmodK5xczfQ>
    <xmx:WgUMaJzkjW31xEHhZJtc_5wEZskBld696QVj4Uz3IzDqcL9OcUSzyz5d>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <cocci@inria.fr>;
 Fri, 25 Apr 2025 17:57:45 -0400 (EDT)
Content-Type: multipart/mixed; boundary="------------i30hnPPnw0ZDWhnCAy0G9bs0"
Message-ID: <5ed0ac32-bb11-4faf-8f70-76431df289ec@fastmail.fm>
Date: Fri, 25 Apr 2025 23:57:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
To: cocci@inria.fr
Subject: [cocci] Fatal error: exception
 Coccinelle_modules.Common.Impossible(126)
Reply-To: Bernd Schubert <bernd.schubert@fastmail.fm>
X-Loop: cocci@inria.fr
X-Sequence: 2721
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/5ed0ac32-bb11-4faf-8f70-76431df289ec%40fastmail.fm>

This is a multi-part message in MIME format.
--------------i30hnPPnw0ZDWhnCAy0G9bs0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Bonsoir,

we just found a simple reproducer for an issue that was affecting a few
of our files. At least I hope that this is the only issue


bschubert2@imesrv6 red>spatch --sp-file find_bug.cocci --c++=17 coccinelle_bug_example.cpp
init_defs_builtins: /usr/lib/coccinelle/standard.h
Starting the test...
HANDLING: coccinelle_bug_example.cpp
Fatal error: exception Coccinelle_modules.Common.Impossible(126)

Issue is here:

// This struct definition with combined variable declaration fails Coccinelle parsing
struct example_struct_t : public base_type_t {
    example_struct_t() : base_type_t()
        { }

    void do_something() {
        REDTRC(0, 0, 0, "Testing %s %d", member1.c_str(), member2);
    }

    std::string member1 = {"test"};
    int member2 = {42};
} global_instance1;  // This form causes Coccinelle to fail


It works fine if we rewrite it as:

// This struct definition with combined variable declaration fails Coccinelle parsing
struct example_struct_t : public base_type_t {
    example_struct_t() : base_type_t()
        { }

    void do_something() {
        REDTRC(0, 0, 0, "Testing %s %d", member1.c_str(), member2);
    }

    std::string member1 = {"test"};
    int member2 = {42};
};
struct example_struct_t global_instance1;  // This form works fine


bschubert2@imesrv6 red>spatch --sp-file find_bug.cocci --c++=17 coccinelle_bug_example.cpp
init_defs_builtins: /usr/lib/coccinelle/standard.h
Starting the test...
HANDLING: coccinelle_bug_example.cpp
coccinelle_bug_example.cpp:18: Found REDTRC
coccinelle_bug_example.cpp:32: Found REDTRC
coccinelle_bug_example.cpp:8: Found REDTRC



We are using Agument AI and without knowing myself anything about
coccinelle, I just let the Agent go over it and it suggested this
change, which indeed fixes the issue for me

diff --git a/parsing_c/type_c.ml b/parsing_c/type_c.ml
index 70da45b089a4..d77ac6658ace 100644
--- a/parsing_c/type_c.ml
+++ b/parsing_c/type_c.ml
@@ -224,7 +224,9 @@ let structdef_to_struct_name ty =
           qu, attr, Ast_c.mk_tybis (StructUnionName (su, s)) [i1;i2]
       | None, _ ->
           ty
-      | x -> raise (Impossible 126)
+      (* Handle the case of combined struct definition with variable declaration *)
+      | Some s, _ ->
+          qu, attr, Ast_c.mk_tybis (StructUnionName (su, s)) (Common.take 2 iis)
       )
   | _ -> raise (Impossible 127)
 



Thanks,
Bernd

--------------i30hnPPnw0ZDWhnCAy0G9bs0
Content-Type: text/x-c++src; charset=UTF-8; name="coccinelle_bug_example.cpp"
Content-Disposition: attachment; filename="coccinelle_bug_example.cpp"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0cmluZz4KCi8vIEJhc2UgY2xhc3MKY2xhc3MgYmFzZV90eXBlX3Qgewpw
dWJsaWM6CiAgICBiYXNlX3R5cGVfdCgpIHt9CiAgICB2b2lkIGxvZ19zb21ldGhpbmcoKSB7
CiAgICAgICAgUkVEVFJDKDAsIDAsIDAsICJUZXN0IG1lc3NhZ2UgJXMiLCAidGVzdCIpOwog
ICAgfQp9OwoKLy8gVGhpcyBzdHJ1Y3QgZGVmaW5pdGlvbiB3aXRoIGNvbWJpbmVkIHZhcmlh
YmxlIGRlY2xhcmF0aW9uIGZhaWxzIENvY2NpbmVsbGUgcGFyc2luZwpzdHJ1Y3QgZXhhbXBs
ZV9zdHJ1Y3RfdCA6IHB1YmxpYyBiYXNlX3R5cGVfdCB7CiAgICBleGFtcGxlX3N0cnVjdF90
KCkgOiBiYXNlX3R5cGVfdCgpCiAgICAgICAgeyB9CgogICAgdm9pZCBkb19zb21ldGhpbmco
KSB7CiAgICAgICAgUkVEVFJDKDAsIDAsIDAsICJUZXN0aW5nICVzICVkIiwgbWVtYmVyMS5j
X3N0cigpLCBtZW1iZXIyKTsKICAgIH0KCiAgICBzdGQ6OnN0cmluZyBtZW1iZXIxID0geyJ0
ZXN0In07CiAgICBpbnQgbWVtYmVyMiA9IHs0Mn07Cn0gZ2xvYmFsX2luc3RhbmNlMTsgIC8v
IFRoaXMgZm9ybSBjYXVzZXMgQ29jY2luZWxsZSB0byBmYWlsCgovLyBUaGlzIGVxdWl2YWxl
bnQgc2VwYXJhdGVkIGZvcm0gd29ya3MgZmluZSB3aXRoIENvY2NpbmVsbGUKc3RydWN0IGV4
YW1wbGVfc3RydWN0Ml90IDogcHVibGljIGJhc2VfdHlwZV90IHsKICAgIGV4YW1wbGVfc3Ry
dWN0Ml90KCkgOiBiYXNlX3R5cGVfdCgpCiAgICAgICAgeyB9CgogICAgdm9pZCBkb19zb21l
dGhpbmcoKSB7CiAgICAgICAgUkVEVFJDKDAsIDAsIDAsICJUZXN0aW5nICVzICVkIiwgbWVt
YmVyMS5jX3N0cigpLCBtZW1iZXIyKTsKICAgIH0KCiAgICBzdGQ6OnN0cmluZyBtZW1iZXIx
ID0geyJ0ZXN0In07CiAgICBpbnQgbWVtYmVyMiA9IHs0Mn07Cn07CnN0cnVjdCBleGFtcGxl
X3N0cnVjdDJfdCBnbG9iYWxfaW5zdGFuY2UyOwo=
--------------i30hnPPnw0ZDWhnCAy0G9bs0
Content-Type: text/plain; charset=UTF-8; name="find_bug.cocci"
Content-Disposition: attachment; filename="find_bug.cocci"
Content-Transfer-Encoding: base64

QGluaXRpYWxpemU6cHl0aG9uQApAQApwcmludCgnU3RhcnRpbmcgdGhlIHRlc3QuLi4nKQoK
QGZpbmRfcmVkdHJjQApleHByZXNzaW9uIGUxLCBlMiwgZTMsIGZtdDsKZXhwcmVzc2lvbiBs
aXN0IGFyZ3M7CnBvc2l0aW9uIHBvczsKQEAKUkVEVFJDQHBvcyhlMSwgZTIsIGUzLCBmbXQs
IGFyZ3MpOwoKQHNjcmlwdDpweXRob25ACnBvcyA8PCBmaW5kX3JlZHRyYy5wb3M7CkBACnBy
aW50KCIlczolczogRm91bmQgUkVEVFJDIiAlIChwb3NbMF0uZmlsZSwgcG9zWzBdLmxpbmUp
KQo=

--------------i30hnPPnw0ZDWhnCAy0G9bs0--
