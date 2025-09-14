Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1A4CAC592
	for <cocci@archiver.kernel.org>; Mon, 15 Sep 2025 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:from:to:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=fm9P4Z8bSsEjG5udMloT/wa8sX0g7MMMSNzgwWRyZgU=;
  b=AqNkbtpz45laHdtZpjlT/kwaVO0I75Duqwdd/48OM1IheSXAeT2dsyOO
   H9DJzCUFWKWYFCxc5emT00/CWBHTstEczDvNoQnDTSG49PHJNKPs8J2G0
   LKuQuYs9PJTY0u/yPHQY+5CzGRix6Kjwo+gK5D+BNF7Cx51XZZxu2YULK
   I=;
X-CSE-ConnectionGUID: j1dsJgEBS0usR2bJh5CoJw==
X-CSE-MsgGUID: L9Yw7YnKSjiIkhf5hrl2xw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chud.cyou
X-IronPort-AV: E=Sophos;i="6.18,267,1751234400"; 
   d="scan'208,217";a="239206763"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Sep 2025 23:30:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CC637E0B0D; Mon, 15 Sep 2025 23:30:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 02D3DE0171
	for <cocci@sympa.inria.fr>; Mon, 15 Sep 2025 23:30:37 +0200 (CEST)
X-CSE-ConnectionGUID: IThedOCvRRaOc14kOCH57g==
X-CSE-MsgGUID: LZEIQsj4RU6q4bPOUNC53g==
IronPort-SDR: 68c8857c_39mwe5hY3g0Ie+8SVnujd90pQ9nhxxdaf6tTC3qytNqmPA4
 Ax0NXQSkJIe6ZBSWkp7SRetQ+pMbPgzJWE4i/ow==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H8KAAPhcho/yIc7sJaHgE8DAILIQ2BPII+gVsSIgcIS?=
 =?us-ascii?q?YRViHuHTAGFZ49Lhy+EZA8BAwENUQQBAYVYFYtQIAYBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAoEKE4ZPDUkBDAGBbgwDAwGENB0BA?=
 =?us-ascii?q?TgYBgE9AnMBAYJ+giMCTgeVfpxGgTKBAYIMAQEGgmnZPIFKGgmBSYVsgmQBK?=
 =?us-ascii?q?oE0An+DVIRygTtSgTyBFIE/AYI9AYM/gw6CaYImgQIUHZAUi2yBRCIDJjMsA?=
 =?us-ascii?q?VUTFwsHBSaBPQOBD24yHYEnhQyEHitPhQKBGINTJGsPBoEVg1uFPkACAQttP?=
 =?us-ascii?q?TcJCxsGlgoXQ4ZKsjiVEgWEJgWBX4MMk02JHwYPBC+BS6kghkCFMo0UqUGBf?=
 =?us-ascii?q?yaBWTMaCDCDIk8DGQ+OLRaEBbwSRDI8AgcBCgEBAwmKFYgJgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 QwhtFcfNBg=
IronPort-HdrOrdr: A9a23:5OIaKKN75259ysBcTvyjsMiBIKoaSvp037BZ7TEJdfU1SKylfq
 WV95omPHDP+VQssR0b6LS90cu7MBDhHPdOiOEsFIyvVgnrp2ekRbsJjLcKqAeQfBEWmNQts5
 uIP5IObeEYFWIWsS/h2mWF+sgbr+W6zA==
X-Talos-CUID: 9a23:LtqdLGDU6J+UEm36Ewhb9EMYPes7SEfU63yJf0yfIkY0F7LAHA==
X-Talos-MUID: 9a23:d2iEPAUdMzTkpyzq/BveqRBbL8U02ZnwERwHqbI7neLZbiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,267,1751234400"; 
   d="scan'208,217";a="239206760"
X-MGA-submission: =?us-ascii?q?MDGEWtjtUI/+8ixqsDE21W/YHKuJLOFXBxORCA?=
 =?us-ascii?q?u+3pPYID4FOH/n7c/CEIGdWyItq1x48nhBrnTaF8qlGh8Vm9oYPRMvWa?=
 =?us-ascii?q?95sO1UM40A09At70B9ebZKlEypVS8cW+Ydhn7JA9s8SKOAn3OxZ31AVc?=
 =?us-ascii?q?16ADGF7Ksdf/eHmmESdYkgCw=3D=3D?=
Received: from chud.cyou (HELO mx.chud.cyou) ([194.238.28.34])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 23:30:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chud.cyou; s=mail;
	t=1757850320; bh=2DJoUIqZNPtIbQRD5NcCYBiaY0hNAuTRPWcBVxt4T44=;
	h=Date:From:Subject:To:From;
	b=JhjKrUV5HZGht8v4+NgnY3liMGAt8aAQpXtIZb3I/rafvv1PZIT8oOV+7bNT2TN+T
	 CbgftKoxv6hvBtTdAp5rgcT6tjFPBIuo1kFZ2RYsXuP6KJQCUwLGjtOOHMo7J5/ZkG
	 h3R5M85WgxovrzVd1Rp084OZwS3zefzACySJeM6SIWz4nYd74maGj9/0E9mBdJ5bdv
	 cQ6+Mr2CGjaAb7hxzeBRDL4FCnWetGIuwf7kRwEL9DWAy/7CBHQi7t8bixf5FU7Dvq
	 kt+oYHuDgMG+GY/JNM7byJcYALLsd/s2QS0XqgM2T0P0E22KBofcw6cRbbKIGO6hhZ
	 BuDXr7139X36g==
Recieved: hidden
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chud.cyou; s=mail;
	t=1757850319; bh=2DJoUIqZNPtIbQRD5NcCYBiaY0hNAuTRPWcBVxt4T44=;
	h=Date:From:Subject:To:From;
	b=yhvNgluSgQcTRaUXUHLZRDl7CiE0sscS0D+DZdaDo86QzB9wInjXmnx+cP8PohMFp
	 hV4v2MdLyX/5E1THu20T0h9DSaCzEb5b4TI5eIWX1NNGNv6jnVbbc9Lvfi1gIq4Q6C
	 Sl4LQaiCjBP0Bf2CeTFqdJYTQWjpNfV8ej41b3GhTGZ3hDe9j8rx5P8zQQF0nh8LHJ
	 nb62B53DOnpdX60pmkvFn+ixAPqCd52FGj48HfA3bPBtBhSOWMo494NgSPgfq4pH7S
	 zRKsvBUyGmHRGBkZ/EXwQpF53AGfdl4nz01pDi7roqnarTHjrJ0agNaoSlqSmpcTZb
	 m2PcwA3Bd8yGw==
Recieved: hidden
Content-Type: multipart/alternative;
 boundary="------------94rDOrQPine9SPGTIAb76xff"
Message-ID: <d04274ea-7bff-4c63-8fc6-55a19ab45b55@chud.cyou>
Date: Sun, 14 Sep 2025 13:47:08 +0200
User-Agent: Mozilla Thunderbird
From: Anon Anonson <anon@chud.cyou>
To: cocci@inria.fr
Content-Language: en-US
Subject: [cocci] Possible bug
Reply-To: Anon Anonson <anon@chud.cyou>
X-Loop: cocci@inria.fr
X-Sequence: 3018
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/d04274ea-7bff-4c63-8fc6-55a19ab45b55%40chud.cyou>

This is a multi-part message in MIME format.
--------------94rDOrQPine9SPGTIAb76xff
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Greetings,

I was playing around with spatch in an attempt to create a wrapper 
utility for renaming.

Given the following script:
@ rn_dec @
type T;
identifier I = i;
@@

- T I
+ T b
;

And the following input:
void f() {
     int i;
     for (int i;;) { ; }
}

The following patch is generated:
diff =
--- main.c
+++ /tmp/cocci-output-9754-fec11b-main.c
@@ -1,4 +1,4 @@
  void f() {
-    int i;
+    int b;
      for (int i;;) { ; }
  }

However, I would expect the declaration inside the 'for' to be replaced too.
My only questions is: is the observed behaviour intended?

Cheers!

--------------94rDOrQPine9SPGTIAb76xff
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Greetings,<br>
    <p>I was playing around with spatch in an attempt to create a
      wrapper utility for renaming.</p>
    <p>Given the following script:<br>
      <font color="#2ec27e">@ rn_dec @<br>
        type T;<br>
        identifier I = i;<br>
        @@<br>
        <br>
        - T I<br>
        + T b<br>
        ;<br>
      </font><br>
    </p>
    <p>And the following input:<br>
      <font color="#2ec27e">void f() {<br>
            int i;<br>
            for (int i;;) { ; }<br>
        }<br>
      </font></p>
    <p>The following patch is generated:<br>
      <font color="#f5c211">diff =<br>
        --- main.c<br>
        +++ /tmp/cocci-output-9754-fec11b-main.c<br>
        @@ -1,4 +1,4 @@<br>
         void f() {<br>
        -    int i;<br>
        +    int b;<br>
             for (int i;;) { ; }<br>
         }<br>
        <br>
      </font></p>
    <p>However, I would expect the declaration inside the 'for' to be
      replaced too.<br>
      My only questions is: is the observed behaviour intended?<br>
    </p>
    Cheers!<br>
    <br>
  </body>
</html>

--------------94rDOrQPine9SPGTIAb76xff--
