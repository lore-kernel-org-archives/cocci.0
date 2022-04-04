Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED1CC433F5
	for <cocci@archiver.kernel.org>; Tue,  5 Apr 2022 06:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=bTzou43pxVjLYjVfIWrVWgWWPdHNH0Ynv/+oDE+Yxkw=;
  b=DA1RnQdcUEc/5wn3z7lISdQTrPRXtdhJHwUCLW+oQ/HRDpP48CYW54P7
   kTvOBQeTTewWu1mqGvaQGG2e603Ha0WWX4e1JTyG4Sx9S+v+2m8ZjjL5S
   dPH4tfdtrIcfzEGiz/l97q8gi0J5W1mwqqT4hxiGWvdBaexXVVbtYAkyp
   o=;
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
X-IronPort-AV: E=Sophos;i="5.90,235,1643670000"; 
   d="scan'208";a="30042108"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Apr 2022 08:18:15 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 04C33E033D; Tue,  5 Apr 2022 08:18:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 21848E00A8
	for <cocci@sympa.inria.fr>; Mon,  4 Apr 2022 23:59:35 +0200 (CEST)
IronPort-SDR: fnl5mSrXiqRWvf+cbWM65TMLsC2sNAcZPOZTvb+QSCCiLj9DY7QnjSeHTJdZX41aVzahMBHtcu
 L8bHFhBfDrNvsEE/T7Tjc1EH7DLbQbufQHaQugFku7KciZq58VB2xyV+xys8izwKwEATN4M/EI
 qx3Deawwz8WI4diza/bcR6EXaondgi+Ni07C8wzd+AU0GxWJRzfLPtrYqJRefxWOId+5viZ3a1
 Um8TqMlN3xwGOk3jzHugkAVYmJT7bwfmkhX0PhwJEhX+Cc8wOJaOwyVXPsNlzWiLzx1NKUblE5
 oqshnxKcsKMdqciYNJ18uZEU
X-IPAS-Result: =?us-ascii?q?A0AMAAAtaUtimPgXL8ZaHAEBAQEBAQcBARIBAQQEAQGCC?=
 =?us-ascii?q?AUBAQsBgieBVgEpBAtEjVqkfIF8CwEDAQsBAUMEAQGFB4RgAh0HAQQyBw4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBAQEBAQEJCwkHBgwFD?=
 =?us-ascii?q?hAFPGRogU+BdAs0DYI1KQGEHAENAQE3AYE9AQ0FgwSDF7FogQGCCAEBBoYHg?=
 =?us-ascii?q?VwJgTwBiTyEF4EhHIFJRIEVgTyCLIpEmX0BgQ2lQp4gg1OfY02WUZF9AS2WM?=
 =?us-ascii?q?SChazSEJAICAgIEBQIWgWgHggczGggbFYMkTgECAQINAQICAwECAQIJAQECj?=
 =?us-ascii?q?h0Zg1mKfCQBMjgCBgsBAQMJkAYBAQ?=
IronPort-PHdr: A9a23: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
 IYPDLRcUQ5sfhv/IlhkWtcFJcUvNg4=
IronPort-Data: A9a23:G775qagYYfV4IMppTiUIZy2XX161GRYKZh0ujC45NGQN5FlHY01je
 htvDW/TP/vYYWTxe9lza9m3oxkC757SydQySQFlqitnFCpjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq/5WDYAXNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplrJbvVwFxb4T2m+USEAZpPSd7BfEF0eqSSZS/mZT7I0zud3bo3a03UBpwMJ0EvPp2R2pJ8
 JT0KhhUP0DF273wmun9ELU87iggBJGD0Ic3vHRI0TCfBvEjKXzGa/ySuIMJgmds7ixINab4N
 pZIaBF1Vzb/WzFVOXU8C7xnl9790xETdBUD+QzO9cLb+VP7xwt627nFK8vQYtXMRMNPn0/eq
 Hiu12DwHRgeMPSNyD+P6Hvqh+nVnCq9Vph6KVGj3vpnhEPLnzBIThAGSR2noL+yjUvWt89jx
 1I84yBxs65qpWWRTdjyHAKJjniBhkJfco8FewEl0z2lxq3R6gefI2ELSD9dddAr3PMLqSwWO
 kyhxIiwXGMx2FGBYTfMqOnL/Gra1T09cDdaDRLoWzfp9DUKTGsbpxbLQ9AL/EWd0YCtQGqYL
 9xnUEEDa1g7icMPyf3ioQuBjiKw4ITICAUy4207v15JDCsnOeZJhKTyszA3CMqsyq7CEzFtW
 1BYwqCjABgmV83lqcB0aLxl8EuVz/iEKibAplVkAoMs8T+gk1b6I9wBuGgveR83bJ5aEdMMX
 KM1kV8KjHO0FCf1BZKbn6roYyjX5fW+To6Nug78N4omjmdNmP+vp3AwPh74M5HFjEU8mLp3O
 JGAbdyxCHscFb8P8dZFb7p17FPf/QhnnTm7bcmil3yPiOPCDFbIF+ttGAbQP4gRsfPVyC2Io
 o03H5bblH13DrakCgGJqtF7ELz/BSVhbXwAg5YJJrfrz8sPMDxJNsI9Npt6INM1x/0Fz7iQl
 px/M2cBoGfCabT8AV3iQhhehHnHBP6TdFo3Yn4hO0iGwX8mbdr95asTbcVlYbhh/+tmlKYmQ
 /4AcsSGI/JOVjWaom5ENMGt9NRvJEaxmAaDHyu5ezxjLZRucArEp43/dQz1+ShSUye67JNso
 7Cp2g7Bb4AEQgBuUJTfZP61kQGtvD4Wn+crBxnEJdxaeUPN9ol2KnGo1KZue5FUcRian2mUz
 QebBxsctNLhmY5t/Ymbn72AoqeoD/B6QhhQEV7d4OvkLiLd5GeindJNXevULzDQUGT4pPera
 elPlqCuNPADgg4T79E6HqZ3i74/odDoouYCnAhjGXzKaXWtC69hfyDchJAX5vUVy+8LoxayV
 2KO5sJeZeeDNvTjHQNDPwEidOmCiawZl2WA9/gzO0mmtiZ78KDeABdWMh2S0HUBd/14IJ9j3
 eZns8kTslTthh0vO9eAryZV62XRdyZZCv137skXUN3xlw4m6lBeepiAWCX415eCNodXOU4wL
 z7I2afPitywHKYZn6bfyJQM4QZcuXjKkBRHyEFafgjS3NfVmrkr3Vta9jFfosG5CPlY+7obB
 4SpHxQdyWayE/NAmMkFVGepc+2ELAPM4VT/kjPli0WAJ3RFlQXxwKkVJefL90ccm46Zkv634
 5nAoFvYvf3WkA0dE8f8tYOJaxAucDCpyjD/pQ==
IronPort-HdrOrdr: A9a23:pcWV3Knn0MguDAr1Qm2tyoAh7qrpDfIr3DAbv31ZSRFFG/Fxl6
 iV7ZcmPHjP+U8ssRAb6Ki90cy7K080mqQFhLX5UY3CYOCEghrPEGgB1/qH/9SIIUSXnYMwus
 ldmsNFeb/N5DZB7foTuWKDYq0dKaG8gceVuds=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,235,1643670000"; 
   d="scan'208";a="10549684"
X-MGA-submission: =?us-ascii?q?MDFSJpwIuG/uSf4aXuA5DyxyAwl5PzjagLbjBx?=
 =?us-ascii?q?eYxAjU6AxrQKqidpS6KRnjy4MJDHkezDEpJQlzk0kTK275FbHrGJg4CV?=
 =?us-ascii?q?PHH0vi0kvxaQMBHWC0tHJhWTXi6m47AOdZ+vgQbd8DAoP0pKsNVBq1v+?=
 =?us-ascii?q?GSFzXN26aCuLx3T9y+7TLwbA=3D=3D?=
Received: from lelv0143.ext.ti.com ([198.47.23.248])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 23:59:33 +0200
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 234LxRla098419;
	Mon, 4 Apr 2022 16:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1649109567;
	bh=bTzou43pxVjLYjVfIWrVWgWWPdHNH0Ynv/+oDE+Yxkw=;
	h=From:To:CC:Subject:Date;
	b=C5XDR4jA/KiWytLZH7xLuLy4XsZpcYPA7/9IDiyu2FRgm/ZwlP+vVhiO0Q18HeOH2
	 fMPlwMTCiHWc9JAN4DDppXIUgPLNLV/HwlA79TVXyUt5kiWtBxRK8b39z5NdWSE5/O
	 MZ4QBW8QEuVFrgnpIyiS1qgAOAaKiJM4XP0mZemQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 234LxRTI070696
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 Apr 2022 16:59:27 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 4
 Apr 2022 16:59:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 4 Apr 2022 16:59:27 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 234LxRUq009509;
	Mon, 4 Apr 2022 16:59:27 -0500
From: Nishanth Menon <nm@ti.com>
To: Nicolas Palix <nicolas.palix@imag.fr>,
        Julia Lawall
	<Julia.Lawall@inria.fr>
CC: <linux-kernel@vger.kernel.org>, <cocci@inria.fr>,
        Kirill Smelkov
	<kirr@nexedi.com>, Nishanth Menon <nm@ti.com>
Date: Mon, 4 Apr 2022 16:59:26 -0500
Message-ID: <20220404215926.14811-1-nm@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: api/stream_open: Introduce
 metavariables for checks
Reply-To: Nishanth Menon <nm@ti.com>
X-Loop: cocci@inria.fr
X-Sequence: 354
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/20220404215926.14811-1-nm%40ti.com>

Coccinelle spatch version 1.1.1 reports the following:
warning: line 134: should no_llseek be a metavariable?
warning: line 141: should noop_llseek be a metavariable?
warning: line 223: should nonseekable_open be a metavariable?
warning: line 290: should nonseekable_open be a metavariable?
warning: line 338: should nonseekable_open be a metavariable?

So, introduce the metavariable similar to other check instances.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

NOTE: This is currently reported in next-20220404, though I have'nt
bisected for exact fixes tags to be used.

 scripts/coccinelle/api/stream_open.cocci | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
index df00d6619b06..d33732f35710 100644
--- a/scripts/coccinelle/api/stream_open.cocci
+++ b/scripts/coccinelle/api/stream_open.cocci
@@ -129,6 +129,7 @@ identifier llseek_f;
 
 @ has_no_llseek @
 identifier fops0.fops;
+identifier no_llseek;
 @@
   struct file_operations fops = {
     .llseek = no_llseek,
@@ -136,6 +137,7 @@ identifier fops0.fops;
 
 @ has_noop_llseek @
 identifier fops0.fops;
+identifier noop_llseek;
 @@
   struct file_operations fops = {
     .llseek = noop_llseek,
@@ -216,6 +218,7 @@ identifier stream_writer.writestream;
 
 @ report_rw depends on report @
 identifier fops_rw.openfunc;
+identifier nonseekable_open;
 position p1;
 @@
   openfunc(...) {
@@ -283,6 +286,7 @@ identifier stream_reader.readstream;
 
 @ report_r depends on report @
 identifier fops_r.openfunc;
+identifier nonseekable_open;
 position p1;
 @@
   openfunc(...) {
@@ -331,6 +335,7 @@ identifier stream_writer.writestream;
 
 @ report_w depends on report @
 identifier fops_w.openfunc;
+identifier nonseekable_open;
 position p1;
 @@
   openfunc(...) {
-- 
2.31.1

