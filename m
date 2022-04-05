Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DE9C433F5
	for <cocci@archiver.kernel.org>; Tue,  5 Apr 2022 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=/OV5EIXkyfTUEfMK+NbO/uRsTKu3O0KPAyqpHSHxqVY=;
  b=LGsMr357jI4kLPdt6cvJ4n4nr/vQPUu/wdrUgTvoOYj/xWrGALTqOSdE
   nn5mcmK+ZMpfqE5oLduTl+uG1or4F7AcPIDpDT67M1ia4pwb6UfvAVe53
   JIoi+IK8DRy2vc32VdUIo0wJ1CrfMC16NLzDoGlU/X/Mp2zLq2W4BgC7H
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@ti.com
X-IronPort-AV: E=Sophos;i="5.90,236,1643670000"; 
   d="scan'208";a="30152547"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Apr 2022 14:57:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9F6AEE00B8; Tue,  5 Apr 2022 14:57:29 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 441B9E002D
	for <cocci@sympa.inria.fr>; Tue,  5 Apr 2022 14:40:09 +0200 (CEST)
IronPort-SDR: OOMnhZ1YoJ5GPsdeqbyd/SaFnNQyzZF78H29L0sE2X/K9pVuxxuau3BWDzqpy6ZhcXm867gJ+6
 dWdy+IxZcuIrIZ2bDhZz8jIsfrHZB8SjpcKrDBFXoi+gvaUG7Qxzwj9dy5Q3cJ8jeM9AqBvEeN
 iMKiWaobzOmXYfGAvUspbIgZJDYHaYCAB8IcX2BLLf33r+YYkp4xBR5ia0emdIUKnn8OhP0Bzb
 gLcwasyugeqp0m4g3Oaz+8g3fQkU8e2c4tv1OQE2FyqPv72a7paFJ+GbBuGtxpolwYNdbLRqUx
 p+NTKqa6pZpGJjwbiltSA1qB
X-IPAS-Result: =?us-ascii?q?A0AFAABoOEximPkXL8ZaHAEBAQEBAQcBARIBAQQEAQGCB?=
 =?us-ascii?q?gcBAQsBgid+VgEBASkEC0QDjHdgpH2BfAsBAwELAQE3DAQBAYUHhGACHQcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEBAQEBAQkLC?=
 =?us-ascii?q?QcGDAUOEAU8ZGiBT4F0CzQNgjUpAYQcAQ0BATcBgT0BDQWDBAGDFg+vUIEBg?=
 =?us-ascii?q?ggBAQaBPwGER4FcAwaBPAGJPIQXgSEcgUlEglGBN3WKRJoRgQ4spReeIINTi?=
 =?us-ascii?q?xWUTk2WU5F+LZYxIIx4lHM0hCUCAgICBAUCFoFhghUzGggbFYMkEzsBAgECD?=
 =?us-ascii?q?QECAgMBAgECCQEBAo4dGYNZhRSFaCMBAQExAgE1AgYLAQEDCY4mAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:/Y758q3epDBrOfGYAPbD5at3kn2cJEfYwER7XKvMYLTBsI5bpzFTy
 jEfDzuDbKyKYjake99/a9jlpEsFv8LRydNgHgFt3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1/V5
 IuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt9Jjw
 99xnJLgdQoGJoGWqeQgaxlGShgraMWq+JefSZS+mciey1OeKie2hfh+EAcqPMsT/eMf7WNmr
 K1IbmxSKErYwbjqkdpXScE07ignBM/uFJ8e/HpnyFk1CN5/Gc6ZE/SRure02h8XhYcQHLXTP
 vBEYCAzVTvhYT5FMXoIXcdWcOCA3SihKG0wREiujaEw6GPS5Bdg1aDkdtvTYN2DA8tP9m6cr
 33P+2DREBAfPsaWjzuD6HOlwOHV9R4XQ6oWGbmmrqc22hue1nBVFBxQXly+yRWktqKgc9BNI
 EYo0yR+kaUd7GDxf9nAZx2m+UfR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9VTA2iCMlbWdxj
 wbWwbsFERQq4ePLFiPEnluBhW7qYUAowXk+iTjopOfvy/DnpIw15v4kZok+SPfu5jEZ9M2Z/
 txnhCwzg6tL1JJRkair4RbbgnSnoZ2hou8JCuf/AD/NAuBRPtTNi2mUBb7ztqsowGGxEgDpg
 ZT8s5LChN3i9LnU/MB3fM0DHauy+9GOOyDGjFhkEvEJrmrxqib6LN0Ivm8mei+F1/ronxe1O
 yc/XisNu/du0IeCNMebnqrsVZ9wpUQePY21PhwrUja+SsMgKlTXlM2fTVKdz2n22Ekqir0lJ
 JKWd9q3ZUv2+ow6pAdas9w1iOdxrghnnDu7bcmik3yPjOTCDFbIF+ZtGAbeP4gRsfLfyC2Io
 ok3H5XRkX13DrahChQ7BKZOdzjm21BhW8CvwyGWH8beSjdb9JYJUKaLm+5+ItA7xMy4VI7gp
 xmAZ6OR83Kn7VWvFOlAQik8AF82dZog/389IwI2OlOkhyoqbYq1svUDdt08erx+rL5vyvt9T
 v8kfcScA6kWEG2eo2RFNZSt/pZ/cBmLhB6VO3b3ajYIeZM9FRfC/cXpf1ey+SRXVni3uMIyr
 qeOzATeRZZfFQ1uANyIOu6uiVi2uCFFyu51WkLJJPhVeVntrdEwcnWp3qdvLphVexvZxzac2
 wKHOjsipLHA890v7d3EpaGYtIP1QeFwKUxXQjvA5rGsOCiGo2euzNMSUOuMejyBBmr49L/7N
 LdRwvXiaKRbxhBHo5Y6D7ctxqU7voO9q7hfxwViPXPKc1X2U+k5eyHWhZFC5v9X27tUmQqqQ
 UbTqNNUDrOEZZH+G1kLKQt5M+mOiaMOlj/J4ahnKUn2/nYmrr6KVVsKZkXWziFNMP1pMcUux
 uJ44Jwa7Am2ixwLNNeaj30NrT3VdixYC6h35IsHBILLixYwzg0Qa5LrDCKrsoqEbM9BMxV3L
 zKZ7EYYa2+wGqYfn7sP+XnxMS51gZkKpkgTkAVEKkSV3MbEwPQw2XW9NNjxoht9ln16PyBbY
 wCH9HGZ4Y2S/nFjg80rs6WEBVRaHBPAkqDu4wJhqYAaJnVEkkTRLSs2PuPlEIX1NY5DVmAzw
 Yx0A1oJndonkA8dE8fytYNYRyTfcOFM
IronPort-HdrOrdr: A9a23:VAjGZqxZe5toBIyZhnCOKrPwK71zdoMgy1knxilNoRw8SL36qy
 nIpoVj6faUskdoZJhEo7q90ca7MBbhHPJOgLX5Xo3SOjUO2lHYSL2KhLGKq1aMd0KRygc379
 YDT0ERMr3N5QEQt7eA3ODBKadG/OW6
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,236,1643670000"; 
   d="scan'208";a="10628937"
X-MGA-submission: =?us-ascii?q?MDHFo8XM/orvqnHcX6bpuT+cuKp/WDMFkcrvcX?=
 =?us-ascii?q?R+KPrb6iagjno4B6059FyQ7NpKeW6TAbJX65A8klT8K90tM7YPHLsKcr?=
 =?us-ascii?q?OcRD96ZhLkG45thTt6qZUZK/YFuqU19h6UHhsFxi8DZeBozH8Ed6LOWY?=
 =?us-ascii?q?8UYTycB1Y3tH4xbr+5xIU2FQ=3D=3D?=
Received: from lelv0142.ext.ti.com ([198.47.23.249])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 14:39:42 +0200
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 235CdbGR027079;
	Tue, 5 Apr 2022 07:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1649162377;
	bh=/OV5EIXkyfTUEfMK+NbO/uRsTKu3O0KPAyqpHSHxqVY=;
	h=From:To:CC:Subject:Date;
	b=rBhAQvK+jG6gu6yh+a7D4lygUBpzbeisNCiBjy3MNPUnwXIrHof24o1aJMlicO6tc
	 P58OgNH+HBMBItFGCTa1Mo1RTPG/vdjiUMWMY0sNLaFoWxatW0qG7oxjQkmOJHPtzB
	 8DSsfUVYO1E4JjPYVAV2pwlcCnQ3Wj/Yx0n0cHPQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 235CdbAo035535
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Apr 2022 07:39:37 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Apr 2022 07:39:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Apr 2022 07:39:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 235CdbEr112656;
	Tue, 5 Apr 2022 07:39:37 -0500
From: Nishanth Menon <nm@ti.com>
To: Nicolas Palix <nicolas.palix@imag.fr>,
        Julia Lawall
	<Julia.Lawall@inria.fr>
CC: <linux-kernel@vger.kernel.org>, <cocci@inria.fr>,
        Kirill Smelkov
	<kirr@nexedi.com>, Nishanth Menon <nm@ti.com>
Date: Tue, 5 Apr 2022 07:39:36 -0500
Message-ID: <20220405123936.30259-1-nm@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH V2] coccinelle: api/stream_open: Introduce
 metavariables for checks
Reply-To: Nishanth Menon <nm@ti.com>
X-Loop: cocci@inria.fr
X-Sequence: 356
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/20220405123936.30259-1-nm%40ti.com>

Coccinelle spatch version 1.1.1 reports the following:
warning: line 134: should no_llseek be a metavariable?
warning: line 141: should noop_llseek be a metavariable?
warning: line 223: should nonseekable_open be a metavariable?
warning: line 290: should nonseekable_open be a metavariable?
warning: line 338: should nonseekable_open be a metavariable?

So, introduce these as symbols to be specific C identifier to match.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

based on: next-20220404
Changes since V1:

* Switch from identifier to more specific symbol

V1: https://lore.kernel.org/all/20220404215926.14811-1-nm@ti.com/

 scripts/coccinelle/api/stream_open.cocci | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
index df00d6619b06..d33732f35710 100644
--- a/scripts/coccinelle/api/stream_open.cocci
+++ b/scripts/coccinelle/api/stream_open.cocci
@@ -129,6 +129,7 @@ identifier llseek_f;
 
 @ has_no_llseek @
 identifier fops0.fops;
+symbol no_llseek;
 @@
   struct file_operations fops = {
     .llseek = no_llseek,
@@ -136,6 +137,7 @@ identifier fops0.fops;
 
 @ has_noop_llseek @
 identifier fops0.fops;
+symbol noop_llseek;
 @@
   struct file_operations fops = {
     .llseek = noop_llseek,
@@ -216,6 +218,7 @@ identifier stream_writer.writestream;
 
 @ report_rw depends on report @
 identifier fops_rw.openfunc;
+symbol nonseekable_open;
 position p1;
 @@
   openfunc(...) {
@@ -283,6 +286,7 @@ identifier stream_reader.readstream;
 
 @ report_r depends on report @
 identifier fops_r.openfunc;
+symbol nonseekable_open;
 position p1;
 @@
   openfunc(...) {
@@ -331,6 +335,7 @@ identifier stream_writer.writestream;
 
 @ report_w depends on report @
 identifier fops_w.openfunc;
+symbol nonseekable_open;
 position p1;
 @@
   openfunc(...) {
-- 
2.31.1

