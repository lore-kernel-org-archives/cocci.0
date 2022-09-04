Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E11DECAAD5
	for <cocci@archiver.kernel.org>; Sun,  4 Sep 2022 22:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=DIeQ1fIBVSGvyPkjUgovvSneU3X+it0b5kot1xlTmtU=;
  b=YRh/ulqtojvnIXcH5Lzm+63aexPhpt0eFZkDHduQSZE3fNkyzowiEypo
   hQ2LSBRUzDFlyGvGa/uf3JEd0+GZfFowJQDqkD28jYGF0Qou6KpWZlXh+
   8M2yUkHghbVj6fIcXEmpx2pcm3dqZ+RZk+N4UHV/Tb4fM+k5ZSATkALdj
   E=;
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
X-IronPort-AV: E=Sophos;i="5.93,290,1654552800"; 
   d="scan'208";a="51223073"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2022 00:50:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2D812E779B; Mon,  5 Sep 2022 00:50:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 59700E015F
	for <cocci@sympa.inria.fr>; Mon,  5 Sep 2022 00:50:16 +0200 (CEST)
IronPort-SDR: zJ8MwjP8MrEOYrJ4LU8yYKG8DHhDatBjiZrcERyOkfyksPqfY6JVSlQoX8lB6Q9HpuD0atUDM+
 lc/UCiKBVIdkZ3VqizskuZg1Vk90JcwzPDHbIn8FuHJyGMLyhdgXilSbm4EJ9KuXK66jvPer02
 otn6LbkfUJzN+BNYGsGwgGFvGC0gry4aPL4urqyKHydc2XdwXKo61Db2UuPM0pl0c1eTDaB0C4
 EJKoZ0EITIrZBam8ik9wWY+lYCIUXNxRdUHkODEy7hfB2whyQ279BvkWY4bO3P5ey3AQiW4ojD
 Zz4HKCwycsZqmgalrViP2ZWR
X-IPAS-Result: =?us-ascii?q?A0CEBwA7KxVjfy/dVdFagQmDc4EBVi4EUIROiH6IEoxCk?=
 =?us-ascii?q?kILAQMBCwEBLxECBAEBPgGER4RmAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBARgJGQcODgVgAWEDAUSBT4FPJQsDMQ2CNSKDbhYRB?=
 =?us-ascii?q?AsBDQEbHQEDEhAPAiYCJREBBQFXglsBgmwBAzADBJw7gQRCizJ/FgUXgQGCC?=
 =?us-ascii?q?QaCYYFuChkoDWcDgVkCBwkBCH8sim2EOHonHIFJRIJRgT6CPoMJOIMJgmUEk?=
 =?us-ascii?q?jaEawQFFA8DAwIgAwkEBwUsHgIJAyMRAwsQCAcNARYkBgYFAQEMAgEEAQUDA?=
 =?us-ascii?q?QQFAwcCAQUGAgkDAwkDAQEFAQMEAwMDAgcDAQIMBAgDAwIDBAICAgIBAwIHB?=
 =?us-ascii?q?QgEAgcCAgIBAgIGAgEDCQECAwUCAgkLAQQCAgMBAwEBAggECQQCAwQCAQEDA?=
 =?us-ascii?q?gECAgEFAg4FAQEBAQIFAQIDAQYHAggCDg4KAQMDAwICBQICAQIDAg0BAQQCA?=
 =?us-ascii?q?QIBAgYBAwECAgMBAwECAgMCBgkCBAEFAwMCAgMBAQUPBQIEAgECBgUCAQEBB?=
 =?us-ascii?q?AEDBAQGAgIBAwMCDgIEAQQBAgEBIwMEAgMBAxcBAgECAwMDBAYHBQIBAhMBA?=
 =?us-ascii?q?gEBAQUBAgEBAwQEBwkDAgIEAwMFAQECAwIBAQEHDAICAhICEwMBBgEOBRQDA?=
 =?us-ascii?q?gQCAgECAgoDAQICAQMCCQIBAgEFIAMBAQ8kAQECAgICAwQHAgEEBgMNAgIBA?=
 =?us-ascii?q?QEFBg0DAgMIDQIHAwIBAwUCAgQBAgQKCQECAgECBAUHAgEIBgUNBQkLAQECA?=
 =?us-ascii?q?QMHBAMRAgUDBQUDAwIBBgQFAgMBAgEBAwQBAwQGAQECAwICAQYCAgEBAwMEA?=
 =?us-ascii?q?wECBgICBwIDAgEEAgMDAQEBBAICAgICAwMIAwIIBwUBBgECAQQDAgIBAgcBB?=
 =?us-ascii?q?AEIAgEDAwUDBAEKDwMFAwEDAwIUCgUBAwgGCQIEBQIFAwIEAgMDAgIIAwIEA?=
 =?us-ascii?q?wILAwUEAgcTBwIDAgIFAgICAgIFBAMBAgICAgICBQIDAgEFAQICAQICAgQBA?=
 =?us-ascii?q?gIHBAIDAQMEDgQDAgIHAQICAQYCBwMBAgEEAwEBBAIEAQIFAgQBAwECBgIEA?=
 =?us-ascii?q?woCAwICAgYIAwMMCQIDBQIEAQECBwQCAgsBBgIHAgIDEAEDAQQFBQMDAwkCA?=
 =?us-ascii?q?gMCBAICCgEBAQECAgEFBQIEBw8CAgIEAgICAQMCAgEBAgIFBAkSAQECAwYEB?=
 =?us-ascii?q?gUDAggYAQYCAgEBAgIDAwIGAgECCAIEAQQFAgECAgICBAEDBgIDAQECAQICA?=
 =?us-ascii?q?wMCAwIEAwMBAgECAgIDAgICAwICARACBgYBAgICAgICAgIBAgYBAgECBAIHA?=
 =?us-ascii?q?gQDAgECAgUCAgIDAQEGAgQLAQMCBwYBAwIHBQIDAQQDBAMDBQYFDAgBBQEDA?=
 =?us-ascii?q?SEDAgIIAgcCAQUDBQEPAwICAwICAQQKAgMFAgQCAQQJBwIEAQIJAwMGAgcFG?=
 =?us-ascii?q?AECAgcEDAoCAgIFBgIEAQECAwECAgECAwQCAwIEBQEFAgECBQQCAgEBAgUCD?=
 =?us-ascii?q?AECAQcGAgcDAgICAwEEAgECAQMDAgMBAQEDBgYFBgQCAwMGAgICBgICAwISA?=
 =?us-ascii?q?wgCBgMCBAENDwUEBwgBAgEBAgcCBAIHCQIOAgEGAQcCAgMCAgECAQICAQYEB?=
 =?us-ascii?q?wEDAgICAgICBQgFAwQFAgNNlXWCCAdhFAYJCgGBbgqBLZF0gzesDWGCe4stl?=
 =?us-ascii?q?GEaMoVGkSCQL4FgAZcHoxGEJwIKBwYQIxKBQyOBW00jFWyCNglFAQIBAQENA?=
 =?us-ascii?q?QIBAQMBAgECCQEBApIPhCCGQD80OwIGAQoBAQMJhUaFDAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:t3a2Qqs0qluiBr0DoDZRkKyymOfnVE1YMUV32f8akzHdYApBsoF/q
 tZmKTyOO/jYYWqjL48ibYuw909TupPWnNNiSQQ/rCBgRSoXgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCYEidfCc8IMsboUsLd9UR38g52rBVPyvX4
 Ymo+5yHZAf+s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnbqsEEA4GI/noeQYeRhaTA4nIvBHyLCSdBBTseTLp6HHW37lwvErE1tveINEpaB4BmZB8
 fFeIzcIBvyBr7jukfTrF6823J1lcJaD0IA34hmMyRnbEfEkR5nZa6rP7N5cmjw3g6iiGN6DP
 pBDMmIxPXwsZTVzKnQILpkGv9urm1CnejdG8EOzr/cetj27IAtZieCxarI5YOeiTsJelUewv
 XPD522/AxcANdXZxyDtz563rurGnCe+R5hLUbPkqbhlh1qcwmFVAxoTPbemnRWnomiiApVOD
 W4/wyorh6kwq2PyUYT8bxLt9RZooSUgc9ZXFuQ77iSExazV/xuVCwA4othpOIxOWCgeFWxC6
 7OZoz/6LWcw7+DNGBpx4p/R/GziY3FERYMXTXZcFVNt3jX1nG0kYvvyojtLFae0ipjqA2i1z
 WzV6ic5gLoXgIgA0KDTEbH7b9CE98Khou0dvF2/soeZAuVROtXNi2uAtwKz0Bq4BNzFJmRtR
 VBd8yRk0MgADIuWiAuGS/gXEbei6p6taWOC2wU2QcN7p27zpxZPmLy8BhkudC+F1e5UKVfUj
 LP75Gu9GbcIYSPyNfIvC25PI51zlfW5fTgaahwkRoMWPsIZmP6v8yZpakqdt10BY2B9+ZzTz
 ayzKJ72ZV5DUfoP5GPvG481jOF2rghjmju7bc6hk3yPj+HFDFbLEudtDbd7RrpmhE9yiF6Fr
 Yg32grj40k3bdASlQGNoNVNcwpVcSVibX00wuQOHtO+zsNdMDlJI5fsLXkJIuSJRoxZybXF+
 G+TQEhdxAatjHHLM1TYZXVqabepVpF69CppMSspNFeu+n4ifYf/tPdFJ8VrJeEqpL550Pp5b
 /gZYMHfUPlCTzLw/T5CP5TwqYpVcgum2FCVNC2/bTljJJNtHlSb+tLtcgb12jMJCy676Zk3r
 7G6h1HURJMCQ0JpC8OPMKCjyFa4vH48nuNuXhuQcoMDJhm0qIUzcn7/lP46Jc0IOC7v/DrC2
 lbEGwocqMnMv5Qxr4vEiKWCmIGjTLlzE09cKG/EtOrkOCTf+F2j9o9OSuO/ez7QCTHv86K4a
 OQJlvzxPaFVnFtOtIYgQb9nwbhkvInqrr5eixt+RTDFMwvtBbRnLX2Lm8JIs/QVlLNevAK3X
 GOJ+8VbaerVYpK7SAZJKVp3dPmH2NEVhiLWsaY/LnL86XIl57GAS0hTY0SBhXAPNrdzK495k
 +4ttNRMsF66gxsud8mc12VaqzvKIXsHXKEq8JodBdaz2AYsz1hDZ73aCzP3sM7TMYQSahFyL
 2/GnrfGipRd2lHGLyg5G0/L0LcPnp8Joh1LkAIPKlnhdgApXRPrMMC9MAjbTzi5Cj1C2uN3f
 3dxbgh7efrI8DBvi8xOGWurHmmtwfFfFlPZkzM0eK/xFiFElVAh6EUyPO+M+AYS9Gc0kv1z4
 uSD0Gi8Odr1VJiZ48bxMHKJb9TsSNVw8kvJn8XP8wFp2XUlSWKNv5JCrlbkZ/cq7Q3dSaEHS
 SRXED5MVJDG
IronPort-HdrOrdr: A9a23:Kk6KkKPQF/keu8BcTvajsMiBIKoaSvp037Dk7TEVdfUzSL3jqy
 nOpoVh6faQslwssR4b6Le90cW7MBDhHP1OkPEs1MmZLW/bUQKTRekIjbcKqweAJ8SUzJ846U
 4PSdkdNDQyNzRHZATBjTVQ3+xO/DD+ytHQuQ4W9RlQcT0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,290,1654552800"; 
   d="scan'208";a="51223069"
X-MGA-submission: =?us-ascii?q?MDHDTEacr/CPknSBQtslLJaUGp6GhE+3Dabqgo?=
 =?us-ascii?q?sIVx5ep1Xi1yCIfMEpSS0Ta5Qn05/V0TOfR+O/tefU3ZXiQVEEa6X0Cl?=
 =?us-ascii?q?HJbaJE/qtc5B6tBMhcl5LFP2WjQQW7hKcXLctO/Yh/KNMIbmVLwCHD3r?=
 =?us-ascii?q?wKhS/Vg/lwqQc6qpMSj9ggKg=3D=3D?=
Received: from mail-wr1-f47.google.com ([209.85.221.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:50:16 +0200
Received: by mail-wr1-f47.google.com with SMTP id t14so1856839wrx.8
        for <cocci@inria.fr>; Sun, 04 Sep 2022 15:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=DIeQ1fIBVSGvyPkjUgovvSneU3X+it0b5kot1xlTmtU=;
        b=KOfcDe5TakfxupG0wiBZxetS/v9RO73tQjXwgWdBOw4QqBgIiSzditm/wVUkuIM47w
         /cqcggExja4+ZsUNZ/hXTNAf/CFeGF1nNOJ9MpRfWVc/HKlDDyVpHE6LQ7Nx42w8cN2B
         mvIN4FvPi93RRKkv5EKXpDsBre552PfUC9W/DvtEp9I6SiDaCi7YwgS7Sdft/ujXq1JM
         dNYoV9vh/vIEQufUfkGHzj21vg9GzSEDFURosvvSG1M7DcDGkMJphWoozhFPWXXBMEbH
         Hq/8yRxpQhZyxJS2tgW00yMgxjVQUKVjKqnStS6rYimEN/raw/XDeq9wpZed33jbZc0M
         4mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=DIeQ1fIBVSGvyPkjUgovvSneU3X+it0b5kot1xlTmtU=;
        b=UBbT5p9o+dU/PL2uKrvjSdfX77aYQP6XzKNbNHmVKlnd4lC40wXMZvw3RTzc320h5Q
         A71ML5ltLn3I5wJTkonn7eDScSPgdQO7d04cnwNGEUuEON6zSGh3xm+0uppYCc/JUzc7
         ZlwHsH3D2jLwLg4A7rqth/oUkwMBvxktrXjBShdDZ+IboaaFPAG+f6qtuP7OqTTgTIlR
         cF08WgLdARKcLRs9mUHsv+h2gZlTN9iCQ1Rx+AD9mNUy8T7+aZeYUQW6pYnrl0CQA16z
         GHTT5j/7DSHOTERf3Fg3Rpunwg8ROs7Ru78KjxIM71Fu41SbRqJM/nJc6ikMwYde2n65
         m7pA==
X-Gm-Message-State: ACgBeo2gq2i3WmN/DYXLGqGS4Fyoa3W7JAQ3XpHU/to5q3HNcWJpMv/l
	4ycfPt5wn5sxuce90sWLGt+2w7RqBqI=
X-Google-Smtp-Source: AA6agR587AjdCyydeA52yblu4G+x0p8NbG0/X2RU9UsIOu25apPUVEr49x07zedHQbiQOLzY1DU05Q==
X-Received: by 2002:a5d:5581:0:b0:20f:fc51:7754 with SMTP id i1-20020a5d5581000000b0020ffc517754mr23835725wrv.413.1662331814997;
        Sun, 04 Sep 2022 15:50:14 -0700 (PDT)
Received: from theo.localdomain (ip-89-177-215-237.bb.vodafone.cz. [89.177.215.237])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm776920wrc.41.2022.09.04.15.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 15:50:14 -0700 (PDT)
From: Jan Tojnar <jtojnar@gmail.com>
To: cocci@inria.fr
Cc: Jan Tojnar <jtojnar@gmail.com>
Date: Mon,  5 Sep 2022 00:50:06 +0200
Message-Id: <20220904225006.3438769-1-jtojnar@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 536
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220904225006.3438769-1-jtojnar%40gmail.com>

When an error occurs during patching of a file, the process terminates
with a 255 exit code.

    spatch docs/dev/file-path-error.cocci docs/dev/test1.c

This was not the case when trying to apply the patch on a directory:

    spatch docs/dev/file-path-error.cocci docs/dev/

The process would print errors for each file individually,
and then finish with a zero (success) exit code.
Additionally, it would write out files for files that succeeded.

Let’s exit with 255 when failure occurs during the mass patching
as well, and prevent writing the changes of successful transformations
to avoid the chance of accidentally not noticing the failure.
---
 enter.ml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/enter.ml b/enter.ml
index 53d4753f..56a4d4c6 100644
--- a/enter.ml
+++ b/enter.ml
@@ -1083,6 +1083,7 @@ let rec main_action xs =
   | _ -> failwith "only one .cocci file allowed");
   Iteration.base_file_list := xs;
   previous_merges := ([], []);
+  let patching_failed = ref false in
   let rec toploop = function
       [] -> failwith "no C files provided"
     | x::xs ->
@@ -1366,6 +1367,7 @@ singleton lists are then just appended to each other during the merge. *)
 					    (Printexc.to_string e)
 					    all_cfiles;
 					  flush stderr;
+					  patching_failed := true;
 					  prev (* *)
 					end
 					else raise e) in
@@ -1414,6 +1416,10 @@ singleton lists are then just appended to each other during the merge. *)
 		  (x,xs,cocci_infos,outfiles)
 		end) in
       let (x,xs,cocci_infos,outfiles) = toploop xs in
+      if !patching_failed then begin
+        Printf.fprintf stderr "An error occurred when attempting to transform some files.\n";
+        raise (UnixExit (-1))
+      end;
       Common.profile_code "Main.result analysis" (fun () ->
 	Ctlcocci_integration.print_bench();
 	generate_outfiles outfiles x xs;
-- 
2.37.2

