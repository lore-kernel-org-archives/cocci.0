Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2309ECAAD5
	for <cocci@archiver.kernel.org>; Sat,  3 Sep 2022 09:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=wi3tgTgmSKkUVHwwcbnija2Ozvtjh59Po5ixgi8U2jk=;
  b=vDH0mIULSVz2mLzepbY3Ebdfibvq0qWtwsshrJP/yxESSLdONZFZQkUC
   uJA+W1xdGbYffsD4Dq4FRjJnxlD7qIZKyflxELW8g/QxCiOUvV4058/hk
   0dOWi0OvXWGl0z5C2IwUsU1/IKDCzKHofY2VDQ2LTCDHO8auuhxk4jEcp
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.93,287,1654552800"; 
   d="scan'208";a="51140875"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Sep 2022 11:39:15 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AD35CE7799; Sat,  3 Sep 2022 11:39:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9E872E015F
	for <cocci@sympa.inria.fr>; Sat,  3 Sep 2022 11:39:10 +0200 (CEST)
IronPort-SDR: o59ZgzSC8IqMbuuwzW/DKiHicXjD/qEeUAZWETg4FBCnP1XU8PWmoepCgke7bzGA8XfhpaQhRo
 76fBgpt4AI3Y7BKt+PUdE2XK5f/3Jne4LAo6zBlqnr3hbalhGR1O50Jpz5gAiGRpzToX54UBxH
 9OBAL65RreOPcEYuh6XKvTUQqy26F8mYwCD/WaX8flhILFmGAk+EsZiEMdc0cDr+HzCjD3hmJZ
 Tygqwwruc+va4bekWLhJH4U7PzLv9Qi87/ZvOPzO8yFUAXmgkoNTkvkfeqM1S0g/zVCNVSZOKA
 vu9I2g3ozdl6JZuphA3a7dAR
X-IPAS-Result: =?us-ascii?q?A0BuBgDLHxNjfzTaVdFagQmBT4IkgVcuBFCEToh+k06Ld?=
 =?us-ascii?q?4VVgXwLAQMBCwEBQAIEAQE+AYRHhGYCHQcBBDIHDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBARgJGQcODgVgAWEDAUSBT4FPJQsDMQ2CNSKDb?=
 =?us-ascii?q?hYRBAsBDQEbHQEDEhAPAiYCIwIRAQUBNSKCW4JtAQMwAwSePIEEQosyfxYFF?=
 =?us-ascii?q?4EBggkGgmGBbgoZKA1nA4FZAgcJAQh/LIZ8g3CEOIEhHIFJRIJRgiyCIII5g?=
 =?us-ascii?q?0GCZQSECI4whG0EBRQPAwMCIAMJBAcFLB4CCQMjEQMLEAgHDQEWKQYFAQEMA?=
 =?us-ascii?q?gEEAQUDAQQFAwcCAQUGAgkDAwkDAQEFAQMEAwMDAgcDAQIMBAgDAwIDBAICA?=
 =?us-ascii?q?gIBAwIHBQgEAgcCAgIBAgIGAgEDCQECAwUCAgkLAQQCAgMBAwEBAggECQQCA?=
 =?us-ascii?q?wQCAQEDAgECAgEFAg4FAQEBAQIFAQIDAQYHAggCDg4KAQMDAwICBQICAQIDA?=
 =?us-ascii?q?g0BAQQCAQIBAgYBAwECAgMBAwECAgMCBgkCBAEFAwMCAgMBAQUOBQIEAgECB?=
 =?us-ascii?q?gUCAQEBBAEDBAQGAgIBAwMCDgIEAQQBAgEBIwMEAgMBAxcBAgECAwMDBAYHB?=
 =?us-ascii?q?QIBAhMBAgEBAQUBAgEBAwQEBwkDAgIEAwMFAQECAwIBAQEHDAICAhICEwMBB?=
 =?us-ascii?q?gEOBRQDAgQCAgECAgoDAQICAQMCCQIBAgEFIAMBAQ8kAQECAgICAwQHAgEEB?=
 =?us-ascii?q?gMNAgIBAQEFBg0DAgMIDQIHAwIBAwUCAgQBAgQKCQECAgECBAUHAgEIBgUNB?=
 =?us-ascii?q?QkLAQECAQMHBAMRAgUDBQUDAwIBBgQFAgMBAgEBAwQBAwQGAQECAwICAQYCA?=
 =?us-ascii?q?gEBAwMEAwECBgICBwIDAgEEAgMDAQEBBAICAgICAwMIAwIIBwUBBgECAQQDA?=
 =?us-ascii?q?gIBAgcBBAEIAgEDAwUDBAEKDwMFAwEDAwIUCgUBAwgGCQIEBQIFAwIEAgMDA?=
 =?us-ascii?q?gIIAwIEAwILAwUEAgcTBwIDAgIFAgICAgIFBAMBAgICAgICBQIEAgEFAQICA?=
 =?us-ascii?q?QICAgQBAgIHBAIDAQMEDgQDAgIHAQICAQYCBwMBAgEEAwEBBAIEAQIFAgQBA?=
 =?us-ascii?q?wECBgIEAwoCAwICAgYIAwMMCQIDBQIEAQECBwQCAgsBBgIHAgIDEAEDAgEEB?=
 =?us-ascii?q?QUDAwMJAgIDAgQCAgoBAQEBAgIBBQUCBAcPAgICBAICAgEDAgIBAQICBQQJE?=
 =?us-ascii?q?gEBAgMGBAYFAwIIGAEGAgIBAQICAwMCBgIBAggCBAEEBQIBAgICAgQBAwYCA?=
 =?us-ascii?q?wEBAgECAgMDAgMCBAMDAQIBAgICAwICAgMCAgEQAgYGAQICAgICAgICAQIGA?=
 =?us-ascii?q?QIBAgQCBwIEAwIBAgIFAgICAwEBBgIECwEDAgcGAQMCBwUCAwEEAwQDAwUGB?=
 =?us-ascii?q?QwIAQUBAwEhAwICCAIHAgEGBQEPAwICAwICAQQKAgMFAgQCAQQJBwIEAQIJA?=
 =?us-ascii?q?wMGAgcFGAECAgcEDAoCAgIFBgIEAQMDAQICAQIDBAIDAgQFAQUCAQIFBAICA?=
 =?us-ascii?q?QECBQIMAQIBBwYCBwMCAgIDAQQCAQIBAwMCAwEBAQMGBgUGBAIDAwYCAgIEA?=
 =?us-ascii?q?gICAwISAwkCBgMCBAENDgUEBwgBAgEBAgcCBAIHCQIOAgEGAQcCAgMCAgECA?=
 =?us-ascii?q?QICAQYEBwEDAgICAgICBQgFAwQFAgNNmAEWeIJLknmDDYskn3tuYYJ7miSFa?=
 =?us-ascii?q?hoylmaSEC2WWpEckXWEJwIKBwYQIxKBMwopgVtNIxU7MYI2TgECAQEBDQECA?=
 =?us-ascii?q?QEDAQIBAgkBAQKSD4pgPzQ7AgYBCgEBAwmFRoUMAQE?=
IronPort-PHdr: A9a23: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
 yTWo5hlpFT0yoFnLxJoVRNPrnBAg4fZ5S1f
IronPort-Data: A9a23:Aq9DVKvTkRi24McP32EZySX5GefnVE1YMUV32f8akzHdYApBsoF/q
 tZmKWiBM/aOMWv1L9BxOt++8hwO6JeEyNVhSlZppHpjRShHgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCYEidfCc8IMsboUsLd9UR38g52rBVPyvX4
 Ymo+5yHYwf/s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnZKRVjUOA7z0ovQYbiVdGHhjAad69bCSdBBTseTLp6HHW37lwvErAUNveINFoKB4BmZB8
 fFeIzcIBvyBr7jukfTrF68235RlcZOD0IA34hmMyRnbEfEkR5nZa6rP7N5cmjw3g6iiGN6EP
 ZVHNWc1NnwsZTVFJH0lUpYTvtyxn0TNQS0EmXirtIQotj27IAtZieCxarI5YOeiTsJelUewv
 XPD522/AxcANdXZxyDtz563rurGnCe+VYBLUbPlrLhlh1qcwmFVAxoTPbemnRWnokCfROB4F
 l0swDorkJQ3/xW2ctPBUhLt9RZooSUgc9ZXFuQ77iSExazV/xuVCwA4othpOIxOWCgeFWxC6
 7OZoz/6LWcw7+DNGBpx4p/R/GziY3FERYMXTXZcFVNt3jX1nG0kYvvyojtLFae0ipj4G2i1z
 W3Q6ic5gLoXgIgA0KDTEbH7b9CE9sWhou0dvF2/soeZAuVROtDNi2uAtwWz0Bq4BNzFJmRtR
 VBd8yRk0MgADIuWiAuGS/gXEbei6p6taWOC2wczRMV7qW/9phZPmLy8BhkudC+F1e5UKVfUj
 LP75Gu9GbcIYSPyNfIvC25PI51zlfW5fTgaahwkRoMWPsIZmP6v8yZpakqdt10BY2B9+ZzTz
 ayzKJ72ZV5DUfoP5GPvG481jOF2rghjmju7bc6hk3yPj+HFDFbLEudtDbd7RrpmhE9yiF6Fr
 Yg32grj40k3bdASlQGNqtRNdApRcSdrbX00wuQOHtO+zsNdMDlJI5fsLXkJIuSJRoxZybXF+
 G+TQEhdxAatjHHLM1TYZXVqabepVpF69CppMSspNFeu+n4ifYf/tPdFJ8VrJeEqpL550Pp5b
 /gZYMHfUPlCTzLw/T5CP5TwqYpVcgum2FCVNC2/bTljJJNtHlSb+tLtcgb12jMJCy676Zk3r
 7G6h1HURJMCQ0JpC8OPMKCjyFa4vH48nuNuXhuQcoMDJhm0qIUzcn7/lP46Jc0IOC7v/DrC2
 lbEGwocqMnMv5Qxr4vEiKWCmIGjTLlzE09cKG/EtOrkOCTf+F2j9o9OSuO/ez7QCTHv86K4a
 OQJlvzxPaFVnFtOtIYgQb9nwbhkvInqrr5eiwlmRTDFMg7tBbRnLX2Lm8JIs/QVlLNevAK3X
 GOJ+8VbaerVYpK7SAZJKVp3dPmH2NEVhiLWsaY/LnL86XIl57GAS0hTY0SBhXAPNrdzK495k
 +4ttNRMsF66gxsud9uE12Vaqj7KIXsHXKEq8JodBdaz2AYsz1hDZ73aCzP3sM7TMYQSahFyL
 2/GnrfGipRd2lHGLyg5G0/L0LcPnp8Joh1LkAIPKlnhdgApXRPrMMC9MAjbTzi5Cj1C2uN3f
 2Vpbgh7eP/I8DBvi8xOGWurHmmtwfFfFlPZkzM0eK/xFiFElVAh6EUyPO+M+AYS9Gc0kv1z4
 uSD0Gi8Odr1VJiZ48bxMHKJb9TsSNVw8kvJn8XP8wFp2XUlSWKNv5JCrlbkZ/cq7Q3dSaEHS
 SRXED5MVJDG
IronPort-HdrOrdr: A9a23:rc9Ow6PJT4+7PsBcTvajsMiBIKoaSvp037Dk7TEVdfUzSL3jqy
 nOpoVh6faQslwssR4b6Le90cW7MBDhHP1OkPEs1MmZLW/bUQKTRekIjbcKqweAJ8SUzJ846U
 4PSdkdNDQyNzRHZATBjTVQ3+xO/DD+ytHQuQ4W9RlQcT0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,287,1654552800"; 
   d="scan'208";a="22764522"
X-MGA-submission: =?us-ascii?q?MDHQZIDWT8o7hmhbqs+QuNzGUGIdzSw/b7QRY3?=
 =?us-ascii?q?hgWIxVyJx1VhZwNN0IDCkSYGQe9rIqujOBqsfIWweMzgrL9B2pvh/o5V?=
 =?us-ascii?q?nqCeiGi3OkNDzVqpTXwxslTeZqIS+u50cd9vScA/lQ0PTcYHbIbY4Py9?=
 =?us-ascii?q?VsXrmxuxnBAJnYoxCSLTxnMA=3D=3D?=
Received: from mail-ej1-f52.google.com ([209.85.218.52])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 11:39:09 +0200
Received: by mail-ej1-f52.google.com with SMTP id fy31so8083037ejc.6
        for <cocci@inria.fr>; Sat, 03 Sep 2022 02:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=wi3tgTgmSKkUVHwwcbnija2Ozvtjh59Po5ixgi8U2jk=;
        b=pFF/ZKaxoViC0G0YFmryamNHLefR9QcAr57qf5HnXzoIQcoMfMKq8fBuyAixUynqha
         smKDpgUgAA1BaW/L/V5WAHRDEixy7f3b/OAO/CMdpX5FJ8rOlWxqTKjF3DJ2GL7b0nd8
         tWPFKKTL2MtEr/9Roj9D718s9VmeK0lhE8+ooD7Vk0vlA55pswU3D859yD1jB0BuyE76
         Bjib8Zl5IYhfIgqDcATQP9hNhw/1fNR+REVQ7B7PVcLZbCd9bl6SFencbSO0MrfGYxko
         X6pM/hhq15Q2TmsaZjYEOQp6fzwXDcyiVSxAMhNj6D2w9jw3rW4raZ1TcOLWKeFXCWTC
         HjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wi3tgTgmSKkUVHwwcbnija2Ozvtjh59Po5ixgi8U2jk=;
        b=D/2uEC93F2Mtf9QdylzK8zTLgnpEHsHwu0TJLubjIPiWEpFexpWw3WQ9oNqTzWePt+
         NCx1Ble+JUVJADj7Ro6aRi6h6QSgIJN3SwGLj0eR4gj2AEZexCSEydnban59hUFLPnoa
         y0qPa3KzaEx/QHBum0wyqI2TzIIKAGZ61PAdWjrsyukV56NzWnLkW4MZPIoZxRb4oQck
         All1zGtB/GwC/SZFIBU98HgBT+71x9z9VbEvLGQdZWnnwh1s+ZCyQv+frHlDkC/uuMCD
         xHQpQ+OrgrfTdSfVkjkgSCLQGMyNulUJHg3v7eeRAmlu+ORYZ9xaoLL7eZq2dFxqpsMK
         HVWQ==
X-Gm-Message-State: ACgBeo3x9Zi+Xg40Q3U3/8NmiMw/uTgWyRARxks2bou/OAzHMBaia1aZ
	08ztBGg8BayO4zk1DswQ8GOW2ARtgbw=
X-Google-Smtp-Source: AA6agR6odNh8/NLo/2HxuZElQLUgnvx3M8MjD6w5ca1KeGhIzBxVXs5ic/rAMn0SaPNFkOiaeXgKtw==
X-Received: by 2002:a17:906:8462:b0:73e:482a:8657 with SMTP id hx2-20020a170906846200b0073e482a8657mr25968429ejc.153.1662197948803;
        Sat, 03 Sep 2022 02:39:08 -0700 (PDT)
Received: from theo.localdomain (ip-89-177-215-237.bb.vodafone.cz. [89.177.215.237])
        by smtp.gmail.com with ESMTPSA id p2-20020a170906b20200b00734bfab4d64sm2350389ejz.25.2022.09.03.02.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 02:39:08 -0700 (PDT)
From: Jan Tojnar <jtojnar@gmail.com>
To: cocci@inria.fr
Cc: Jan Tojnar <jtojnar@gmail.com>
Date: Sat,  3 Sep 2022 11:38:42 +0200
Message-Id: <20220903093843.2579539-1-jtojnar@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH 1/2] engine/postprocess_transinfo.ml: Fix
 indentation
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 534
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220903093843.2579539-1-jtojnar%40gmail.com>

Previously, the file mixed tabs and spaces inconsistently,
making viewing diffs annoying.

Let’s replace tabs with eight spaces,
which appears to be the assumed value.

This Separate commit to make the successive diff cleaner.

Signed-off-by: Jan Tojnar <jtojnar@gmail.com>
---
 engine/postprocess_transinfo.ml | 172 ++++++++++++++++----------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/engine/postprocess_transinfo.ml b/engine/postprocess_transinfo.ml
index 5536f09c..2a00b797 100644
--- a/engine/postprocess_transinfo.ml
+++ b/engine/postprocess_transinfo.ml
@@ -51,104 +51,104 @@ let process_tree inherited_env l =
   let (all_fresh,local_freshs,new_triples) =
     List.fold_left
       (function (all_fresh,local_freshs,new_triples) ->
-	function (node,env,pred) ->
-	  let (other,fresh) = get_vars pred in
-	  let env = List.filter (function (x,_) -> List.mem x other) env in
-	  (Common.union_set fresh all_fresh,
-	   fresh::local_freshs,
-	   (node,env@inherited_env,pred)::new_triples))
+        function (node,env,pred) ->
+          let (other,fresh) = get_vars pred in
+          let env = List.filter (function (x,_) -> List.mem x other) env in
+          (Common.union_set fresh all_fresh,
+           fresh::local_freshs,
+           (node,env@inherited_env,pred)::new_triples))
       ([],[],[]) l in
   let local_freshs = List.rev local_freshs in
   let new_triples = List.rev new_triples in
   let fresh_env =
     List.map
       (function
-	  ((r,n) as fresh,Ast.NoVal) ->
-	    Printf.printf "%s: name for %s: " r n; (* not debugging code!!! *)
-	    flush stdout;
-	    (fresh,let v = string2val(read_fresh_id()) in function _ -> v)
-	| ((r,n) as fresh,Ast.StringSeed seed) ->
-	    (fresh,let v = string2val(get_seeded seed) in function _ -> v)
-	| ((r,n) as fresh,Ast.ListSeed seed) ->
-	    (fresh,
-	     function env ->
-	       let strings =
-		 List.map
-		   (function
-		       Ast.SeedString s -> s
-		     | Ast.SeedId id ->
-			 try
-			   (match List.assoc id env with
-			     Lib_engine.NormalMetaVal(Ast_c.MetaIdVal str) ->
-			       str
-			   | _ -> failwith "bad id value")
-			 with
-			   Not_found ->
-			     failwith
-			       ("fresh: no binding for meta "^(Dumper.dump id)))
-		   seed in
-	       string2val(String.concat "" strings))
+          ((r,n) as fresh,Ast.NoVal) ->
+            Printf.printf "%s: name for %s: " r n; (* not debugging code!!! *)
+            flush stdout;
+            (fresh,let v = string2val(read_fresh_id()) in function _ -> v)
+        | ((r,n) as fresh,Ast.StringSeed seed) ->
+            (fresh,let v = string2val(get_seeded seed) in function _ -> v)
+        | ((r,n) as fresh,Ast.ListSeed seed) ->
+            (fresh,
+             function env ->
+               let strings =
+                 List.map
+                   (function
+                       Ast.SeedString s -> s
+                     | Ast.SeedId id ->
+                         try
+                           (match List.assoc id env with
+                             Lib_engine.NormalMetaVal(Ast_c.MetaIdVal str) ->
+                               str
+                           | _ -> failwith "bad id value")
+                         with
+                           Not_found ->
+                             failwith
+                               ("fresh: no binding for meta "^(Dumper.dump id)))
+                   seed in
+               string2val(String.concat "" strings))
         | ((r, n) as fresh, Ast.ScriptSeed(name, lang, params, pos, body)) ->
-	    let res = ref None in
+            let res = ref None in
             let make_fresh_id env =
-	      match !res with
-		Some x -> x
-	      | None ->
-		  let args =
+              match !res with
+                Some x -> x
+              | None ->
+                  let args =
                     List.map
                       (fun (((rule, name) as meta_name), _) ->
-			try match List.assoc meta_name env with
-			| Lib_engine.NormalMetaVal v -> (meta_name, v)
-			| _ ->
+                        try match List.assoc meta_name env with
+                        | Lib_engine.NormalMetaVal v -> (meta_name, v)
+                        | _ ->
                             failwith
                               (Printf.sprintf
-				 "Undesired metavar_binding in line %d"
-				 (snd pos))
-			with
-			| Not_found ->
+                                 "Undesired metavar_binding in line %d"
+                                 (snd pos))
+                        with
+                        | Not_found ->
                             let get_meta_names l =
                               List.map
-				(fun (mn, _) -> Ast.string_of_meta_name mn)
-				l in
+                                (fun (mn, _) -> Ast.string_of_meta_name mn)
+                                l in
                             let string_of_list l =
                               "[" ^ String.concat "; " l ^ "]" in
                             failwith
                               (Printf.sprintf
-				 "%s: script on variable %s cannot be evaluated in line %d. available: %s\nwanted: %s"
-				 r n (snd pos)
-				 (string_of_list (get_meta_names env))
-				 (string_of_list (get_meta_names params)))
-			      )
+                                 "%s: script on variable %s cannot be evaluated in line %d. available: %s\nwanted: %s"
+                                 r n (snd pos)
+                                 (string_of_list (get_meta_names env))
+                                 (string_of_list (get_meta_names params)))
+                              )
                       params in
-		  let args = (fresh, Ast_c.MetaIdVal n)::args in
-		  let fresh_id =
+                  let args = (fresh, Ast_c.MetaIdVal n)::args in
+                  let fresh_id =
                     match lang with
                     | "ocaml" ->
-			Run_ocamlcocci.run_fresh_id name (List.map snd args)
+                        Run_ocamlcocci.run_fresh_id name (List.map snd args)
                     | "python" -> Pycocci.run_fresh_id args pos body
                     | _ ->
-			failwith
-			  "languages other than ocaml or python not supported" in
-		  let r = string2val fresh_id in
-		  res := Some r;
-		  r in
+                        failwith
+                          "languages other than ocaml or python not supported" in
+                  let r = string2val fresh_id in
+                  res := Some r;
+                  r in
             (fresh, make_fresh_id)
       )
       all_fresh in
   let (_,res) =
     List.split
       (List.fold_left
-	 (function freshs_node_env_preds ->
-	   function (fresh,fn) ->
-	     List.map
-	       (function (freshs,((node,env,pred) as cur)) ->
-		 try
-		   let _ = List.assoc fresh freshs in
-		   (freshs,(node,(fresh,fn env)::env,pred))
-		 with Not_found -> (freshs,cur))
-	       freshs_node_env_preds)
-	 (List.combine local_freshs new_triples)
-	 fresh_env) in
+         (function freshs_node_env_preds ->
+           function (fresh,fn) ->
+             List.map
+               (function (freshs,((node,env,pred) as cur)) ->
+                 try
+                   let _ = List.assoc fresh freshs in
+                   (freshs,(node,(fresh,fn env)::env,pred))
+                 with Not_found -> (freshs,cur))
+               freshs_node_env_preds)
+         (List.combine local_freshs new_triples)
+         fresh_env) in
   (List.rev res, fresh_env)
 
 (* ----------------------------------------------------------------------- *)
@@ -161,16 +161,16 @@ let collect_used_after used_after envs l inherited_env =
   List.map2
     (function env -> function l ->
       let inherited_env =
-	match l with
-	  [] -> inherited_env
-	| (_,fse,_)::_ ->
-	    (* l represents the result from a single tree. fse is a complete
-	       environment in that tree.  for a fresh seed, the environments
-	       for all leaves contain the same information *)
-	    fse@inherited_env  in
+        match l with
+          [] -> inherited_env
+        | (_,fse,_)::_ ->
+            (* l represents the result from a single tree. fse is a complete
+               environment in that tree.  for a fresh seed, the environments
+               for all leaves contain the same information *)
+            fse@inherited_env  in
       List.map
-	(function (v,vl) -> (v,vl inherited_env))
-	(List.filter (function (v,vl) -> List.mem v used_after) env))
+        (function (v,vl) -> (v,vl inherited_env))
+        (List.filter (function (v,vl) -> List.mem v used_after) env))
     envs l
 
 (* ----------------------------------------------------------------------- *)
@@ -183,24 +183,24 @@ let fold_left_with_index f acc =
   let rec fold_lwi_aux acc = function
     | [] -> acc
     | x::xs ->
-	let n = !index in
-	index := !index + 1;
-	fold_lwi_aux (f acc x n) xs
+        let n = !index in
+        index := !index + 1;
+        fold_lwi_aux (f acc x n) xs
   in fold_lwi_aux acc
 
 let numberify trees =
   let trees =
     fold_left_with_index
       (function acc -> function xs -> function n ->
-	(List.map (function x -> (n,x)) xs) @ acc)
+        (List.map (function x -> (n,x)) xs) @ acc)
       [] trees in
   List.fold_left
     (function res ->
       function (n,x) ->
-	let (same,diff) = List.partition (function (ns,xs) -> x = xs) res in
-	match same with
-	  [(ns,xs)] -> (n::ns,xs)::diff
-	| _ -> ([n],x)::res)
+        let (same,diff) = List.partition (function (ns,xs) -> x = xs) res in
+        match same with
+          [(ns,xs)] -> (n::ns,xs)::diff
+        | _ -> ([n],x)::res)
     [] trees
 
 (* ----------------------------------------------------------------------- *)
-- 
2.37.2

