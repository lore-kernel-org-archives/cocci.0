Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF284ECAAD5
	for <cocci@archiver.kernel.org>; Mon,  5 Sep 2022 09:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DU4HWKGxA1VQEzkIAXna7nX6wi9AONQ5cw01rlPVU2U=;
  b=NJl6svhJlJNZ0PJGoOTUQ0hgZ6HcNNFfVjHliRW7rPTn/4uuqbWDBe1K
   b7EbjQj4Ji2PgPnXX+M764JUJIKL1LwYBtl8+sQNWDLrGpnXaneLN1koO
   N9YEFbwXmImRX9k6aeuqh0GuDx03gQ+3xb1a+9GlUAD0dpFHJNqEuzFfh
   4=;
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
   d="scan'208";a="51291729"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2022 11:11:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8D514E779D; Mon,  5 Sep 2022 11:11:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CC7B1E015F
	for <cocci@sympa.inria.fr>; Mon,  5 Sep 2022 11:10:59 +0200 (CEST)
IronPort-SDR: hEExtNQsIACvLSOOR02hgP1lwPYQGzI1uhFTquzUPwrDPWjiMCuZZJQgrFRxlheb6WSyDfq0E2
 bJPfQJYLIgU2fOzIQtoChZN13rqQa+J9xvhXo67ITEtUU+lUFq6GELxyfo6SdEzzmu4x7Yyxuo
 FFMJ/TLgDm0NZ5DLyluHPX9rIVch2fzDVoZjfkhE1bjOzVf7QDy1EqUn2TJM9Q0ti81vAD+Qu9
 LCRJX0dEGPo+aCPaEBdyeuwGDpnFzRh/PDVRk2xYKl6SccWWBom8FSiY5u9N4UdchIwc6ZDQRr
 NT3DOva5C0i/HHL8NH7IELMa
X-IPAS-Result: =?us-ascii?q?A0DRBgAxvBVjfy/dVdFagQmBT4IkgQFWLgRQhE6IfogSM?=
 =?us-ascii?q?5xpgWgLAQMBCwEBLxECBAEBPgGERwKEZQIdBwEEMwYOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAQBEwEBGAkZBw4OBWABYQMBRIFPgXQLAzENgjUig?=
 =?us-ascii?q?2wCAQMSEQQLAQ0BGx0BAwwGEA8CJgICIQIRAQUBHBkiglsBgmwBAzADBJsog?=
 =?us-ascii?q?QRCizJ/FgUXgQGCCQaCYYFuChkoDWcDgVkCBwkBCH8thnuDcYQ4eiccgUlEg?=
 =?us-ascii?q?lGBPoI+UIIKL4NBgmUEhAeOL1OEGAQFFA8DAwIgAwkEBwUsHgIJAyMRAwsQC?=
 =?us-ascii?q?AcNARYkBgYFAQEMAgEEAQUDAQQFAwcCAQUGAgkDAwkDAQEFAQMEAwMDAgcDA?=
 =?us-ascii?q?QIMBAgDAwIDBAICAgIBAwIHBQgEAgcCAgIBAgIGAgEDCQECAwUCAgkLAQQCA?=
 =?us-ascii?q?gMBAwEBAggECQQCAwQCAQEDAgECAgEFAg4FAQEBAQIFAQIDAQYHAggCDg4KA?=
 =?us-ascii?q?QMDAwICBQICAQIDAg0BAQQCAQIBAgYBAwECAgMBAwECAgMCBgkCBAEFAwMCA?=
 =?us-ascii?q?gMBAQUPBQIEAgECBgUCAQEBBAEDBAQGAgIBAwMCDgIEAQQBAgEBIwMEAgMBA?=
 =?us-ascii?q?xcBAgECAwMDBAYHBQIBAhMBAgEBAQUBAgEBAwQEBwkDAgIEAwMFAQECAwIBA?=
 =?us-ascii?q?QEHDAICAhICEwMBBgEOBRQDAgQCAgECAgoDAQICAQMCCQIBAgEFIAMBAQ8kA?=
 =?us-ascii?q?QECAgICAwQHAgEEBgMNAgIBAQEFBg0DAgMIAQwCBwMCAQMFAgIEAQIECgkBA?=
 =?us-ascii?q?gIBAgQFBwIBCAYFDQUJCwEBAgEDBwQDEQIFAwUFAwMCAQYEBQIDAQIBAQMEA?=
 =?us-ascii?q?QMEBgEBAgMCAgEGAgIBAQMDBAMBAgYCAgcCAwIBBAIDAwEBAQQCAgICAgMDC?=
 =?us-ascii?q?AMCCAcFAQYBAgEEAwICAQIHAQQBCAIBAwMFAwQBCg8DBQMBAwMCFAoFAQMIB?=
 =?us-ascii?q?gkCBAUCBQMCBAIDAwICCAMCBAMCCwMFBAIHEwcCAwICBQICAgICBQQDAQICA?=
 =?us-ascii?q?gICAgUCAwIBBQECAgECAgIEAQICBwQCAwEDBA4EAwICBwECAgEGAgcDAQIBB?=
 =?us-ascii?q?AMBAQQCBAECBQIEAQMBAgYCBAMKAgMCAgIGCAMDDAkCAwUCBAEBAgcEAgILA?=
 =?us-ascii?q?QYCBwICAxABAwEEBQUDAwMJAgIDAgQCAgoBAQEBAgIBBQUCBAcPAgICBAICA?=
 =?us-ascii?q?gEDAgIBAQICBQQJEgEBAgMGBAYFAwIIGAEGAgIBAQICAwMCBgIBAggCBAEEB?=
 =?us-ascii?q?QIBAgICAgQBAwYCAwEBAgECAgMDAgMCBAMDAQIBAgICAwICAgMCAgEQAgYGA?=
 =?us-ascii?q?QICAgICAgICAQIBBQECAQIEAgcCBAMCAQICBQICAgMBAQYCBAsBAwIHBgEDA?=
 =?us-ascii?q?gcFAgMBBAMEAwMFBgUMCAEFAQMBIQMCAggCBwIBBQMFAQ8DAgIDAgIBBAoCA?=
 =?us-ascii?q?wUCBAIBBAkHAgQBAgkDAwYCBwUYAQICBwQMCgICAgUGAgQBAQIDAQICAQIDB?=
 =?us-ascii?q?AIDAgQFAQUCAQIFBAICAQECBQIMAQIBBwYCBwMCAgIDAQQCAQIBAwMCAwEBA?=
 =?us-ascii?q?QMGBgUGBAIDAwYCAgIGAgIDAhIDCAIGAwIEAQ0PBQQHCAECAQECBwIEAgcJA?=
 =?us-ascii?q?g4CAQYBBwICAwICAQIBAgIBBgQHAQMCAgICAgIFCAUDBAUCA02VdIIIB1kIF?=
 =?us-ascii?q?AYJCgEvgT8KA4EqkXSDN6sfbmGCe4stjneFahoyhUaRIJAvgWGXB5EckRBlh?=
 =?us-ascii?q?CcCCgcGECMSgUIkgVtNIxVsgjYJRQECAQEBDQECAQEDAQIBAgkBAQKSD4Qgh?=
 =?us-ascii?q?kA/NDsCBgEKAQEDCYVGhQwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:P5wRiKv+qDcL7Q0olrobMl3naufnVGVYMUV32f8akzHdYApBsoF/q
 tZmKWGBbPeNMGXzcohxYYW3oBkGsZSGzINlQFZtpS9hEC8VgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCYEidfCc8IMsboUsLd9UR38g52rBVPyvX4
 Ymo+5yHZAf+s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnYLqc1owJYD1o+RDeRdbIwNjbZZW/IaSdBBTseTLp6HHW37lwvErE1tveINEpaB4BmZB8
 fFeIzcIBvyBr7jukfTrF6823J1lcJaD0IA34hmMyRnbEfEkR5nZa6rP7N5cmjw3g6iiGN6EP
 ZpENWU+N3wsZTVSZlRUWZk3mNyHuXfBcztUpQ7SqpY4tj27IAtZieCxarI5YOeiQcxKl0Kcj
 nDH+m7jC1cbMsaewHyL6BqEjejEliLTQ5MXDLT+9/hwgVTVyHZ7NfENfV6yoP38lVTnHtwDd
 Aob/S0hqaV0/0uuJjXgY/GmiGDehEMFQPdpKO1kwg+O+ojJsz2JAlFRG1atd+canMMxQDUr0
 HqAkNXoGSFjvdWppZS1puf8QdSaaXh9EIMSWcMXZVBavIS78enfmjqKH4kzSvfk5jHgMWiom
 2jikcQou1kEYSc2O0iT+FnGh3ezvMGMQFJqoArQWW2h40VyY4vNi22UBbrzvKwowGWxFAHpU
 J04dy62srtm4XalynblfQn1NOv1j8tpyRWF6bKVI7Ev9i6251modp1K7Td1KS9Ba5haI2SwP
 hWJ6VkPuPe/2UdGi4cnM+pd7Ox6ncDd+SjNC5g4k/IVP8ApLFLflM2QTRfJhz20+KTTrU3PE
 c7DLZzE4YcyBqNgwz67L9rxIpd6rh3SMVj7HMihpzz+ieT2TCfMFd8tbQXTBshks/vsiFuPr
 753aZDRoz0BC72WX8Ui2dRMRbz8BSNrW86eRg0+XrLrHzeK70l4Wq+Mkex9JNI690mX/8+Rl
 kyAtoZj4AKXrRX6xc+iMxiPsZvjAsRyq2wVJyspMQr60nQve9f946IWdp9xdr4irbQxwflxR
 vgDWsOBHvUfEmSdq2pBNcHw/N54aRCmpQOSJC76MjUyephXQQaWqNLpew3Y8jYDU3isvswkr
 rz8jQ7WGMJRRwlrAMvMRuioyle94SoUlO5oDhnHJ9BSfAPn940zc379ifo+IsctLxTfx2vCh
 1zGX0tA/eSU+t076tjEg6yAvryFKeomExoIBXTf4Ja3KTLeoTiuzIpGZ+CCImLQWWbyz6O9P
 LkHwvz5NsoHq1ZEqY9LFbhmkPAl7Nz1qr4GlwlpESmZb1mvDb88cHCK0dMV7f9Iz75d/BSsA
 weBpoYcNrKON8foVlUWIVN9POiE0PgVnBjU7Og0cBqmvn4ppOLfXBUAJQSIhQxcMKBxbNEvz
 9AntZNE8Ae4kBcrbouLg3wG7WiKNXBcAawruotAW93ugwsvj05YONnSVnCw75aIZNFBdEItJ
 2bM1qbFgr1dwGvEcmYyRSeRh7sD3cxWtUAY1kIGKnSIhsHB2q090ipX/GllVQ9S1BhGj79+N
 2UD25eZ/klSE+qERfSvXlxA3ylEDRydv1Prkh4HyDKfQE6vWWjAamY6PI5hOazfH310JlBmE
 HOwkQ4JkgoGuOn+2yIzXQhurPmLoRlZ6FjZgM7+dyiaN8BSXNcm65NCoUIHrhLmBYU6g0ivS
 SyGOgpvQfWTCBP8aJHXx2VXOXr8hfxEyKF/rSldwZ40
IronPort-HdrOrdr: A9a23:ClsWxagJKCerI9IWooLViijHRXBQXtwji2hC6mlwRA09TyX4rb
 HLoB11726XtN98YgBCpTnEAsK9qBDnmaKdg7NwAV7KZmCPhILrFutfBODZrAEIdReSysdtkY
 Vtf7FFBNrsZGIVsS6CizPIdurIuOPnzJyV
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,290,1654552800"; 
   d="scan'208";a="22854793"
X-MGA-submission: =?us-ascii?q?MDHGUC3SRHDhLcULsWm6KcacJ9hedqzkn8sfW9?=
 =?us-ascii?q?xpk6xmLXleWuc6TMR/n892D4VZ+IGov5yW+qU4RvTNrpG/YQwrodR2yK?=
 =?us-ascii?q?AOknG+oCY63qtuMVFSTphT6KFRJY45qZQ7wzEfd6ceqgDpSG7HNsy/Rt?=
 =?us-ascii?q?3r5ltoILYAcm8s1AndAouwgQ=3D=3D?=
Received: from mail-wr1-f47.google.com ([209.85.221.47])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 11:10:59 +0200
Received: by mail-wr1-f47.google.com with SMTP id c11so6203447wrp.11;
        Mon, 05 Sep 2022 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DU4HWKGxA1VQEzkIAXna7nX6wi9AONQ5cw01rlPVU2U=;
        b=SY2nNcAAXT7RpTJjLbIdaSUTOfye6PvT4cGkLfqxaLP+pSlJNge/0ICKFGB3MWfTQ2
         UkFlMR/nkP6st9796S2zXrsKCtGoMYw9TxZDQs18ivNFu41+l4/qqeegepRCj9MLcIbR
         ebtB2T2z/cgRgtLDxBVbn8znRtQOIxvGXDeE4vlwd4ktaW4JHksJoTdDrn97BY/AqtIM
         II4USO1lQY/OOHaPz1YefKT9gQ6Cm9uXsYk9Jz5fozHjrUOBNbyRqJjGp8tSYv7WfQF0
         f4OZUS0GHyUq4DXL2Jccy/s1PWGvRGNnJtLq+KwhssUm4spo7+ijg4pHpxI1acbiZt9C
         XzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DU4HWKGxA1VQEzkIAXna7nX6wi9AONQ5cw01rlPVU2U=;
        b=weUyUWxnb+lOLCUqpw1mEHutLvn3tR8TZ2OyKPoA403QtU8Q7Oc+v93YOOFYbHEJyt
         ccrNWmextloLW2n5i8yRfauJn7yyk+1i8GVmmRJ43y9fldLu4Ys/Hn8pkp6lYb4CeAoh
         aJr/v/2GLWi8ctCdzqyr5fzXVCD9R4LJEseEemCj2Qxok9qEi7MAZWSHg5Mlr6WMFf0O
         YwHychwDqqif33TwOZxBOBuzvGFzKGUxmi2ryNpPFX6u8Bi2XTyS1WzgzniltxGUd6xZ
         vO8scOV3OMrkcuO5Bl6+/TjYgoAT32+VBx8ibuk//m7U+ksHAyqb8YoQv6Wq94xFr4ir
         YiLw==
X-Gm-Message-State: ACgBeo2GIL4KRmfUxaeo4GDjc4n4gILPAseHAflZY1ni3u3Ol7eNc4y5
	l9hnVYhGKZekjtJ8vh+1sDzyldOHZ/tCmg==
X-Google-Smtp-Source: AA6agR5chBY8MY38IpUa4WxnFIHzdMBey/JxIlR/+WfXM2Gek0gmXK9jWoyhLyJcywTaB/7AF8L1Gg==
X-Received: by 2002:a5d:5a9d:0:b0:225:2783:d6f1 with SMTP id bp29-20020a5d5a9d000000b002252783d6f1mr24627245wrb.385.1662369058202;
        Mon, 05 Sep 2022 02:10:58 -0700 (PDT)
Received: from theo.localdomain (ip-89-177-215-237.bb.vodafone.cz. [89.177.215.237])
        by smtp.gmail.com with ESMTPSA id w1-20020a05600018c100b00224f7c1328dsm8242974wrq.67.2022.09.05.02.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 02:10:57 -0700 (PDT)
From: Jan Tojnar <jtojnar@gmail.com>
To: julia.lawall@inria.fr
Cc: cocci@inria.fr,
	jtojnar@gmail.com
Date: Mon,  5 Sep 2022 11:09:15 +0200
Message-Id: <20220905090915.3569051-1-jtojnar@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <alpine.DEB.2.22.394.2209050952300.2731@hadrien>
References: <alpine.DEB.2.22.394.2209050952300.2731@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 539
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220905090915.3569051-1-jtojnar%40gmail.com>

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

Let’s also introduce a `--keep-going` flag that reverts to the previous
behaviour. And also do the same with `--bench` and `--compare-with-expected`
since the testing infrastructure relies on it.

Signed-off-by: Jan Tojnar <jtojnar@gmail.com>
---

Thansk, updated as per your instructions.

Though, I think, ideally, the test infrastructure would be updated
to use the newly introduced `--keep-going` flag and the magic
behaviour of `--bench` and `--compare-with-expected` would
be removed. I would do that but was not able to find any
uses of the two flags in the repo.

 enter.ml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/enter.ml b/enter.ml
index 53d4753f..b4fac617 100644
--- a/enter.ml
+++ b/enter.ml
@@ -28,6 +28,7 @@ let preprocess = ref false     (* run the C preprocessor before cocci *)
 let compat_mode = ref false
 let ignore_unknown_opt = ref false
 let profile_per_file = ref false
+let keep_going = ref false
 
 let dir = ref false
 let ignore = ref []
@@ -729,6 +730,8 @@ let other_options = [
     "   option to set if launch spatch in ocamldebug";
     "--disable-once",       Arg.Set Common.disable_pr2_once,
     "   to print more messages";
+    "--keep-going",         Arg.Set keep_going,
+    "     write transformations and exit with zero status, even if some files fail";
     "--show-trace-profile", Arg.Set Common.show_trace_profile,
     "   show trace";
     "--save-tmp-files",     Arg.Set Common.save_tmp_files,   " ";
@@ -1083,6 +1086,7 @@ let rec main_action xs =
   | _ -> failwith "only one .cocci file allowed");
   Iteration.base_file_list := xs;
   previous_merges := ([], []);
+  let patching_failed = ref false in
   let rec toploop = function
       [] -> failwith "no C files provided"
     | x::xs ->
@@ -1366,6 +1370,7 @@ singleton lists are then just appended to each other during the merge. *)
 					    (Printexc.to_string e)
 					    all_cfiles;
 					  flush stderr;
+					  patching_failed := true;
 					  prev (* *)
 					end
 					else raise e) in
@@ -1414,6 +1419,12 @@ singleton lists are then just appended to each other during the merge. *)
 		  (x,xs,cocci_infos,outfiles)
 		end) in
       let (x,xs,cocci_infos,outfiles) = toploop xs in
+      if !patching_failed && not !keep_going && !Flag_ctl.bench == 0 && !compare_with_expected == None
+      then
+        begin
+          Printf.fprintf stderr "An error occurred when attempting to transform some files.\n";
+          raise (UnixExit (-1))
+        end;
       Common.profile_code "Main.result analysis" (fun () ->
 	Ctlcocci_integration.print_bench();
 	generate_outfiles outfiles x xs;
-- 
2.37.2

